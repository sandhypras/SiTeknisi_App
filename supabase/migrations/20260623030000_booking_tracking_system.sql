-- Booking & Tracking System
-- TAHAP 4: Booking lifecycle, status updates, location tracking

-- 1. Add additional fields ke bookings
alter table bookings 
  add column if not exists technician_location_lat numeric(10, 7),
  add column if not exists technician_location_lng numeric(10, 7),
  add column if not exists location_updated_at timestamptz,
  add column if not exists arrival_time timestamptz,
  add column if not exists work_started_at timestamptz,
  add column if not exists work_notes text,
  add column if not exists customer_notes text,
  add column if not exists cancellation_reason text,
  add column if not exists cancelled_by text, -- customer or technician
  add column if not exists cancelled_at timestamptz;

-- 2. Enable RLS untuk bookings
alter table bookings enable row level security;

-- 3. RLS Policies untuk bookings

-- Customer dapat view bookings miliknya
create policy "Customers can view own bookings"
on bookings for select
to authenticated
using (customer_id = auth.uid());

-- Teknisi dapat view bookings miliknya
create policy "Technicians can view own bookings"
on bookings for select
to authenticated
using (technician_id = auth.uid());

-- Teknisi dapat update bookings miliknya (status, location, notes)
create policy "Technicians can update own bookings"
on bookings for update
to authenticated
using (technician_id = auth.uid())
with check (technician_id = auth.uid());

-- Customer dapat update bookings miliknya (customer_notes only)
create policy "Customers can update own booking notes"
on bookings for update
to authenticated
using (customer_id = auth.uid())
with check (customer_id = auth.uid());

-- Admin dapat view & update semua bookings
create policy "Admin can view all bookings"
on bookings for select
to authenticated
using (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'admin'
  )
);

create policy "Admin can update all bookings"
on bookings for update
to authenticated
using (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'admin'
  )
);

-- 4. Function untuk teknisi confirm booking (after payment)
create or replace function confirm_booking(booking_id_param uuid)
returns bookings as $$
declare
  v_booking bookings;
begin
  -- Update booking status
  update bookings
  set 
    status = 'confirmed',
    updated_at = now()
  where id = booking_id_param
  and technician_id = auth.uid()
  and status = 'pending_payment'
  and exists (
    select 1 from payments
    where payments.booking_id = booking_id_param
    and payments.status = 'paid'
  )
  returning * into v_booking;
  
  if v_booking.id is null then
    raise exception 'Booking not found, not authorized, or payment not completed';
  end if;
  
  return v_booking;
end;
$$ language plpgsql security definer;

-- 5. Function untuk update technician location (GPS tracking)
create or replace function update_technician_location(
  booking_id_param uuid,
  latitude numeric(10, 7),
  longitude numeric(10, 7)
)
returns bookings as $$
declare
  v_booking bookings;
begin
  update bookings
  set 
    technician_location_lat = latitude,
    technician_location_lng = longitude,
    location_updated_at = now()
  where id = booking_id_param
  and technician_id = auth.uid()
  and status in ('confirmed', 'in_progress')
  returning * into v_booking;
  
  if v_booking.id is null then
    raise exception 'Booking not found or not authorized';
  end if;
  
  return v_booking;
end;
$$ language plpgsql security definer;

-- 6. Function untuk teknisi arrived at location
create or replace function mark_technician_arrived(booking_id_param uuid)
returns bookings as $$
declare
  v_booking bookings;
begin
  update bookings
  set 
    arrival_time = now(),
    updated_at = now()
  where id = booking_id_param
  and technician_id = auth.uid()
  and status = 'confirmed'
  returning * into v_booking;
  
  if v_booking.id is null then
    raise exception 'Booking not found or not authorized';
  end if;
  
  return v_booking;
end;
$$ language plpgsql security definer;

-- 7. Function untuk start work
create or replace function start_booking_work(booking_id_param uuid)
returns bookings as $$
declare
  v_booking bookings;
begin
  update bookings
  set 
    status = 'in_progress',
    work_started_at = now(),
    started_at = now(),
    updated_at = now()
  where id = booking_id_param
  and technician_id = auth.uid()
  and status = 'confirmed'
  returning * into v_booking;
  
  if v_booking.id is null then
    raise exception 'Booking not found or not authorized';
  end if;
  
  return v_booking;
end;
$$ language plpgsql security definer;

-- 8. Function untuk complete booking
create or replace function complete_booking(
  booking_id_param uuid,
  work_notes_param text default null
)
returns bookings as $$
declare
  v_booking bookings;
begin
  update bookings
  set 
    status = 'completed',
    completed_at = now(),
    work_notes = coalesce(work_notes, '') || E'\n' || coalesce(work_notes_param, ''),
    updated_at = now()
  where id = booking_id_param
  and technician_id = auth.uid()
  and status = 'in_progress'
  returning * into v_booking;
  
  if v_booking.id is null then
    raise exception 'Booking not found or not authorized';
  end if;
  
  -- Update request status
  update service_requests
  set status = 'completed', updated_at = now()
  where id = v_booking.request_id;
  
  return v_booking;
end;
$$ language plpgsql security definer;

-- 9. Function untuk cancel booking
create or replace function cancel_booking(
  booking_id_param uuid,
  cancellation_reason_param text,
  cancelled_by_param text -- 'customer' or 'technician'
)
returns bookings as $$
declare
  v_booking bookings;
  v_is_authorized boolean := false;
begin
  -- Check authorization
  select 
    (customer_id = auth.uid() and cancelled_by_param = 'customer') or
    (technician_id = auth.uid() and cancelled_by_param = 'technician')
  into v_is_authorized
  from bookings
  where id = booking_id_param
  and status in ('pending_payment', 'confirmed');
  
  if not v_is_authorized then
    raise exception 'Not authorized to cancel or booking cannot be cancelled';
  end if;
  
  -- Cancel booking
  update bookings
  set 
    status = 'cancelled',
    cancellation_reason = cancellation_reason_param,
    cancelled_by = cancelled_by_param,
    cancelled_at = now(),
    updated_at = now()
  where id = booking_id_param
  returning * into v_booking;
  
  -- Update request status back to open (so other technicians can offer)
  update service_requests
  set status = 'open', updated_at = now()
  where id = v_booking.request_id;
  
  return v_booking;
end;
$$ language plpgsql security definer;

-- 10. Trigger untuk notify booking status changes
create or replace function notify_booking_status_change()
returns trigger as $$
begin
  if old.status is distinct from new.status then
    -- Notify customer
    perform pg_notify(
      'booking_status_' || new.customer_id::text,
      json_build_object(
        'booking_id', new.id,
        'status', new.status,
        'technician_id', new.technician_id
      )::text
    );
    
    -- Notify technician
    perform pg_notify(
      'booking_status_' || new.technician_id::text,
      json_build_object(
        'booking_id', new.id,
        'status', new.status,
        'customer_id', new.customer_id
      )::text
    );
  end if;
  
  return new;
end;
$$ language plpgsql;

create trigger on_booking_status_change
  after update on bookings
  for each row
  when (old.status is distinct from new.status)
  execute function notify_booking_status_change();

-- 11. Trigger untuk notify location updates (realtime tracking)
create or replace function notify_location_update()
returns trigger as $$
begin
  if old.technician_location_lat is distinct from new.technician_location_lat
     or old.technician_location_lng is distinct from new.technician_location_lng then
    perform pg_notify(
      'location_update_' || new.customer_id::text,
      json_build_object(
        'booking_id', new.id,
        'latitude', new.technician_location_lat,
        'longitude', new.technician_location_lng,
        'updated_at', new.location_updated_at
      )::text
    );
  end if;
  
  return new;
end;
$$ language plpgsql;

create trigger on_location_update
  after update on bookings
  for each row
  when (
    old.technician_location_lat is distinct from new.technician_location_lat
    or old.technician_location_lng is distinct from new.technician_location_lng
  )
  execute function notify_location_update();

-- 12. View untuk booking statistics
create or replace view booking_statistics as
select
  count(*) as total_bookings,
  count(*) filter (where status = 'pending_payment') as pending_payment,
  count(*) filter (where status = 'confirmed') as confirmed,
  count(*) filter (where status = 'in_progress') as in_progress,
  count(*) filter (where status = 'completed') as completed,
  count(*) filter (where status = 'cancelled') as cancelled,
  count(*) filter (where created_at >= current_date) as today_bookings,
  count(*) filter (where created_at >= current_date - interval '7 days') as week_bookings,
  count(*) filter (where completed_at >= current_date) as today_completed,
  avg(extract(epoch from (completed_at - started_at)) / 3600) 
    filter (where completed_at is not null and started_at is not null) as avg_work_duration_hours
from bookings;

grant select on booking_statistics to authenticated;

-- 13. View untuk technician performance
create or replace view technician_performance as
select
  b.technician_id,
  count(*) as total_bookings,
  count(*) filter (where b.status = 'completed') as completed_bookings,
  count(*) filter (where b.status = 'cancelled' and b.cancelled_by = 'technician') as cancelled_by_technician,
  round(
    count(*) filter (where b.status = 'completed')::numeric / 
    nullif(count(*)::numeric, 0) * 100,
    2
  ) as completion_rate_percent,
  avg(extract(epoch from (b.completed_at - b.started_at)) / 3600) 
    filter (where b.completed_at is not null and b.started_at is not null) as avg_work_duration_hours,
  avg(extract(epoch from (b.arrival_time - b.created_at)) / 60)
    filter (where b.arrival_time is not null) as avg_arrival_time_minutes
from bookings b
group by b.technician_id;

grant select on technician_performance to authenticated;

-- 14. Comments
comment on column bookings.technician_location_lat is 'Real-time GPS latitude teknisi';
comment on column bookings.technician_location_lng is 'Real-time GPS longitude teknisi';
comment on column bookings.arrival_time is 'Waktu teknisi arrived at location';
comment on column bookings.work_started_at is 'Waktu mulai pengerjaan';
comment on column bookings.work_notes is 'Catatan teknisi tentang pekerjaan';
comment on column bookings.customer_notes is 'Catatan/instruksi dari customer';
comment on function confirm_booking is 'Teknisi confirm booking after payment (pending_payment -> confirmed)';
comment on function update_technician_location is 'Update GPS location teknisi untuk real-time tracking';
comment on function start_booking_work is 'Mulai pengerjaan (confirmed -> in_progress)';
comment on function complete_booking is 'Selesaikan booking (in_progress -> completed)';
comment on function cancel_booking is 'Cancel booking by customer or technician';

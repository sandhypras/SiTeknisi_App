-- Offer Management System
-- TAHAP 3: Teknisi kirim penawaran, customer compare & accept

-- 1. Add additional fields ke service_offers
alter table service_offers 
  add column if not exists transport_fee numeric(12, 2) default 0,
  add column if not exists estimated_duration text, -- e.g., "2-3 jam"
  add column if not exists photo_urls text[], -- foto pendukung offer
  add column if not exists expires_at timestamptz;

-- Update constraint
alter table service_offers 
  add constraint service_offers_transport_check check (transport_fee >= 0);

-- 2. Enable RLS untuk service_offers
alter table service_offers enable row level security;

-- 3. RLS Policies untuk service_offers

-- Teknisi dapat create offer untuk open requests
create policy "Approved technicians can create offers"
on service_offers for insert
to authenticated
with check (
  technician_id = auth.uid()
  and exists (
    select 1 from profiles p
    join technician_applications ta on ta.technician_id = p.id
    where p.id = auth.uid()
    and p.role = 'technician'
    and ta.status = 'approved'
  )
  and exists (
    select 1 from service_requests
    where service_requests.id = service_offers.request_id
    and service_requests.status = 'open'
  )
);

-- Teknisi dapat view offer miliknya
create policy "Technicians can view own offers"
on service_offers for select
to authenticated
using (technician_id = auth.uid());

-- Teknisi dapat update offer miliknya (status pending only)
create policy "Technicians can update own pending offers"
on service_offers for update
to authenticated
using (
  technician_id = auth.uid()
  and status = 'pending'
)
with check (technician_id = auth.uid());

-- Customer dapat view offers untuk request miliknya
create policy "Customers can view offers for own requests"
on service_offers for select
to authenticated
using (
  exists (
    select 1 from service_requests
    where service_requests.id = service_offers.request_id
    and service_requests.customer_id = auth.uid()
  )
);

-- Admin dapat view semua offers
create policy "Admin can view all offers"
on service_offers for select
to authenticated
using (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'admin'
  )
);

-- 4. Function untuk accept offer dan auto-create booking
create or replace function accept_service_offer(offer_id_param uuid)
returns json as $$
declare
  v_offer service_offers;
  v_request service_requests;
  v_booking bookings;
  v_total_amount numeric(12, 2);
  v_platform_fee numeric(12, 2);
  v_technician_income numeric(12, 2);
  v_midtrans_order_id text;
begin
  -- Get offer dan validate
  select * into v_offer
  from service_offers
  where id = offer_id_param
  and status = 'pending';
  
  if not found then
    raise exception 'Offer not found or already processed';
  end if;
  
  -- Get request dan validate customer ownership
  select * into v_request
  from service_requests
  where id = v_offer.request_id
  and customer_id = auth.uid()
  and status = 'open';
  
  if not found then
    raise exception 'Request not found or not authorized';
  end if;
  
  -- Calculate amounts (platform fee 10%)
  v_total_amount := v_offer.offer_price + coalesce(v_offer.transport_fee, 0);
  v_platform_fee := v_total_amount * 0.10;
  v_technician_income := v_total_amount - v_platform_fee;
  
  -- Generate Midtrans order ID
  v_midtrans_order_id := 'STK-' || to_char(now(), 'YYYYMMDD') || '-' || 
                          substring(gen_random_uuid()::text, 1, 8);
  
  -- Update accepted offer
  update service_offers
  set status = 'accepted', updated_at = now()
  where id = offer_id_param;
  
  -- Reject other offers untuk request ini
  update service_offers
  set status = 'rejected', updated_at = now()
  where request_id = v_request.id
  and id != offer_id_param
  and status = 'pending';
  
  -- Update request status
  update service_requests
  set status = 'booked', updated_at = now()
  where id = v_request.id;
  
  -- Create booking
  insert into bookings (
    request_id,
    offer_id,
    customer_id,
    technician_id,
    status
  ) values (
    v_request.id,
    offer_id_param,
    v_request.customer_id,
    v_offer.technician_id,
    'pending_payment'
  ) returning * into v_booking;
  
  -- Create payment record
  insert into payments (
    booking_id,
    customer_id,
    gross_amount,
    platform_fee,
    technician_income,
    midtrans_order_id,
    status
  ) values (
    v_booking.id,
    v_request.customer_id,
    v_total_amount,
    v_platform_fee,
    v_technician_income,
    v_midtrans_order_id,
    'pending'
  );
  
  -- Return result
  return json_build_object(
    'success', true,
    'booking_id', v_booking.id,
    'midtrans_order_id', v_midtrans_order_id,
    'total_amount', v_total_amount,
    'platform_fee', v_platform_fee,
    'technician_income', v_technician_income
  );
end;
$$ language plpgsql security definer;

-- 5. Function untuk reject offer
create or replace function reject_service_offer(
  offer_id_param uuid,
  rejection_reason text default null
)
returns service_offers as $$
declare
  v_offer service_offers;
begin
  update service_offers
  set 
    status = 'rejected',
    message = coalesce(message || E'\n\n', '') || 
              'Rejected by customer: ' || coalesce(rejection_reason, 'No reason provided'),
    updated_at = now()
  where id = offer_id_param
  and exists (
    select 1 from service_requests
    where service_requests.id = service_offers.request_id
    and service_requests.customer_id = auth.uid()
  )
  and status = 'pending'
  returning * into v_offer;
  
  if v_offer.id is null then
    raise exception 'Offer not found or not authorized';
  end if;
  
  return v_offer;
end;
$$ language plpgsql security definer;

-- 6. Function untuk auto-expire offers
create or replace function expire_old_offers()
returns void as $$
begin
  update service_offers
  set status = 'expired', updated_at = now()
  where status = 'pending'
  and expires_at is not null
  and expires_at < now();
end;
$$ language plpgsql;

-- 7. Trigger untuk notify customer saat ada offer baru
create or replace function notify_new_offer()
returns trigger as $$
begin
  if new.status = 'pending' then
    perform pg_notify(
      'new_service_offer',
      json_build_object(
        'offer_id', new.id,
        'request_id', new.request_id,
        'technician_id', new.technician_id,
        'offer_price', new.offer_price,
        'transport_fee', new.transport_fee
      )::text
    );
  end if;
  return new;
end;
$$ language plpgsql;

create trigger on_new_service_offer
  after insert on service_offers
  for each row
  execute function notify_new_offer();

-- 8. Trigger untuk notify teknisi saat offer accepted/rejected
create or replace function notify_offer_status_change()
returns trigger as $$
begin
  if old.status = 'pending' and new.status in ('accepted', 'rejected') then
    perform pg_notify(
      'offer_status_changed',
      json_build_object(
        'offer_id', new.id,
        'request_id', new.request_id,
        'technician_id', new.technician_id,
        'status', new.status
      )::text
    );
  end if;
  return new;
end;
$$ language plpgsql;

create trigger on_offer_status_change
  after update on service_offers
  for each row
  when (old.status is distinct from new.status)
  execute function notify_offer_status_change();

-- 9. Trigger untuk update request status saat ada offer
create or replace function update_request_status_on_offer()
returns trigger as $$
begin
  if new.status = 'pending' then
    update service_requests
    set status = 'offered', updated_at = now()
    where id = new.request_id
    and status = 'open';
  end if;
  return new;
end;
$$ language plpgsql;

create trigger on_first_offer
  after insert on service_offers
  for each row
  execute function update_request_status_on_offer();

-- 10. View untuk offer statistics
create or replace view offer_statistics as
select
  so.technician_id,
  count(*) as total_offers,
  count(*) filter (where so.status = 'pending') as pending_offers,
  count(*) filter (where so.status = 'accepted') as accepted_offers,
  count(*) filter (where so.status = 'rejected') as rejected_offers,
  count(*) filter (where so.status = 'expired') as expired_offers,
  round(
    count(*) filter (where so.status = 'accepted')::numeric / 
    nullif(count(*) filter (where so.status in ('accepted', 'rejected'))::numeric, 0) * 100,
    2
  ) as acceptance_rate_percent,
  avg(so.offer_price) filter (where so.status = 'accepted') as avg_accepted_price
from service_offers so
group by so.technician_id;

grant select on offer_statistics to authenticated;

-- 11. Comments
comment on column service_offers.transport_fee is 'Biaya transport teknisi ke lokasi';
comment on column service_offers.estimated_duration is 'Estimasi durasi pengerjaan (e.g., 2-3 jam)';
comment on column service_offers.photo_urls is 'Foto pendukung penawaran (optional)';
comment on column service_offers.expires_at is 'Offer expire time (optional, for urgent requests)';
comment on function accept_service_offer is 'Accept offer, auto-create booking & payment, reject other offers';
comment on function reject_service_offer is 'Reject offer dengan reason';

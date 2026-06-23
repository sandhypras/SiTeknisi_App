-- Service Request System Enhancements
-- TAHAP 2: Additional fields dan RLS policies

-- 1. Add additional fields ke service_requests (jika belum ada)
alter table service_requests 
  add column if not exists photo_urls text[], -- support multiple photos
  add column if not exists budget_min numeric(12, 2),
  add column if not exists budget_max numeric(12, 2),
  add column if not exists urgency text default 'normal', -- normal, urgent
  add column if not exists notes text;

-- Update constraint untuk photo_url nullable (karena ada photo_urls array)
alter table service_requests 
  alter column photo_url drop not null;

-- 2. Enable RLS untuk service_requests
alter table service_requests enable row level security;

-- 3. RLS Policies untuk service_requests

-- Customer dapat create request
create policy "Customer can create own requests"
on service_requests for insert
to authenticated
with check (
  customer_id = auth.uid()
  and exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'customer'
  )
);

-- Customer dapat melihat request miliknya
create policy "Customer can view own requests"
on service_requests for select
to authenticated
using (
  customer_id = auth.uid()
);

-- Customer dapat update request miliknya (hanya status draft/open)
create policy "Customer can update own draft requests"
on service_requests for update
to authenticated
using (
  customer_id = auth.uid()
  and status in ('draft', 'open')
)
with check (
  customer_id = auth.uid()
);

-- Customer dapat delete request miliknya (hanya draft)
create policy "Customer can delete own draft requests"
on service_requests for delete
to authenticated
using (
  customer_id = auth.uid()
  and status = 'draft'
);

-- Teknisi approved dapat melihat open requests
create policy "Approved technicians can view open requests"
on service_requests for select
to authenticated
using (
  status = 'open'
  and exists (
    select 1 from profiles p
    join technician_applications ta on ta.technician_id = p.id
    where p.id = auth.uid()
    and p.role = 'technician'
    and ta.status = 'approved'
  )
);

-- Teknisi dapat melihat requests yang sudah mereka offer
create policy "Technicians can view requests they offered"
on service_requests for select
to authenticated
using (
  exists (
    select 1 from service_offers
    where service_offers.request_id = service_requests.id
    and service_offers.technician_id = auth.uid()
  )
);

-- Admin dapat melihat semua requests
create policy "Admin can view all requests"
on service_requests for select
to authenticated
using (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'admin'
  )
);

-- Admin dapat update semua requests
create policy "Admin can update all requests"
on service_requests for update
to authenticated
using (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'admin'
  )
);

-- 4. Function untuk auto-publish request (change draft -> open)
create or replace function publish_service_request(request_id uuid)
returns service_requests as $$
declare
  updated_request service_requests;
begin
  update service_requests
  set status = 'open', updated_at = now()
  where id = request_id
  and customer_id = auth.uid()
  and status = 'draft'
  returning * into updated_request;
  
  if updated_request.id is null then
    raise exception 'Request not found or not authorized';
  end if;
  
  return updated_request;
end;
$$ language plpgsql security definer;

-- 5. Function untuk cancel request
create or replace function cancel_service_request(request_id uuid, cancel_reason text default null)
returns service_requests as $$
declare
  updated_request service_requests;
begin
  update service_requests
  set 
    status = 'cancelled',
    notes = coalesce(notes || E'\n\n', '') || 'Cancelled: ' || coalesce(cancel_reason, 'No reason provided'),
    updated_at = now()
  where id = request_id
  and customer_id = auth.uid()
  and status in ('draft', 'open', 'offered')
  returning * into updated_request;
  
  if updated_request.id is null then
    raise exception 'Request not found, not authorized, or cannot be cancelled';
  end if;
  
  return updated_request;
end;
$$ language plpgsql security definer;

-- 6. Trigger untuk notify teknisi saat ada request baru
create or replace function notify_new_request()
returns trigger as $$
begin
  if new.status = 'open' and (old.status is null or old.status = 'draft') then
    perform pg_notify(
      'new_service_request',
      json_build_object(
        'request_id', new.id,
        'service_id', new.service_id,
        'customer_id', new.customer_id,
        'title', new.title,
        'latitude', new.latitude,
        'longitude', new.longitude
      )::text
    );
  end if;
  return new;
end;
$$ language plpgsql;

create trigger on_new_service_request
  after insert or update on service_requests
  for each row
  execute function notify_new_request();

-- 7. View untuk dashboard stats (admin & analytics)
create or replace view service_request_stats as
select
  count(*) filter (where status = 'open') as open_requests,
  count(*) filter (where status = 'offered') as offered_requests,
  count(*) filter (where status = 'booked') as booked_requests,
  count(*) filter (where status = 'in_progress') as in_progress_requests,
  count(*) filter (where status = 'completed') as completed_requests,
  count(*) filter (where status = 'cancelled') as cancelled_requests,
  count(*) filter (where created_at >= current_date) as today_requests,
  count(*) filter (where created_at >= current_date - interval '7 days') as week_requests
from service_requests;

-- Admin dapat akses view
grant select on service_request_stats to authenticated;

-- 8. Comments
comment on column service_requests.photo_urls is 'Array of photo URLs (support multiple photos)';
comment on column service_requests.budget_min is 'Minimum budget customer siap bayar (optional)';
comment on column service_requests.budget_max is 'Maximum budget customer siap bayar (optional)';
comment on column service_requests.urgency is 'normal or urgent - untuk prioritas';

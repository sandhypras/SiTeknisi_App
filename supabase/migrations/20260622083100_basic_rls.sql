-- SiTeknisi basic Row Level Security
-- Reference: docs/SYSTEM_ARCHITECTURE.md section 4, docs/PRD.md section 12.
--
-- Scope (MVP foundation): every table has RLS enabled and a baseline policy set.
-- Customers and technicians reach only their own rows; admins have full access.
-- Open service_requests are readable by technicians so they can send offers.

-- Helper: read the caller's role without triggering recursive RLS on profiles.
create or replace function public.current_user_role()
returns user_role
language sql
stable
security definer
set search_path = public
as $$
  select role from public.profiles where id = auth.uid();
$$;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(public.current_user_role() = 'admin', false);
$$;

-- Enable RLS ------------------------------------------------------------------

alter table profiles enable row level security;
alter table services enable row level security;
alter table technician_applications enable row level security;
alter table service_requests enable row level security;
alter table service_offers enable row level security;
alter table bookings enable row level security;
alter table payments enable row level security;
alter table invoices enable row level security;
alter table reviews enable row level security;

-- profiles --------------------------------------------------------------------

create policy "profiles_self_or_admin_select" on profiles
  for select using (id = auth.uid() or public.is_admin());

create policy "profiles_self_insert" on profiles
  for insert with check (id = auth.uid());

create policy "profiles_self_or_admin_update" on profiles
  for update using (id = auth.uid() or public.is_admin())
  with check (id = auth.uid() or public.is_admin());

-- services: public catalog, admin-managed ------------------------------------

create policy "services_read_all" on services
  for select using (true);

create policy "services_admin_write" on services
  for all using (public.is_admin()) with check (public.is_admin());

-- technician_applications: owner + admin -------------------------------------

create policy "applications_owner_or_admin_select" on technician_applications
  for select using (technician_id = auth.uid() or public.is_admin());

create policy "applications_owner_insert" on technician_applications
  for insert with check (technician_id = auth.uid());

create policy "applications_owner_update" on technician_applications
  for update using (technician_id = auth.uid())
  with check (technician_id = auth.uid());

create policy "applications_admin_update" on technician_applications
  for update using (public.is_admin()) with check (public.is_admin());

-- service_requests: customer owner, open requests visible to technicians -----

create policy "requests_customer_or_admin_select" on service_requests
  for select using (customer_id = auth.uid() or public.is_admin());

create policy "requests_technician_open_select" on service_requests
  for select using (
    public.current_user_role() = 'technician' and status = 'open'
  );

create policy "requests_customer_insert" on service_requests
  for insert with check (customer_id = auth.uid());

create policy "requests_customer_update" on service_requests
  for update using (customer_id = auth.uid())
  with check (customer_id = auth.uid());

-- service_offers: technician owner + the request's customer + admin ----------

create policy "offers_owner_or_admin_select" on service_offers
  for select using (technician_id = auth.uid() or public.is_admin());

create policy "offers_request_customer_select" on service_offers
  for select using (
    exists (
      select 1 from service_requests r
      where r.id = service_offers.request_id and r.customer_id = auth.uid()
    )
  );

create policy "offers_technician_insert" on service_offers
  for insert with check (technician_id = auth.uid());

create policy "offers_technician_update" on service_offers
  for update using (technician_id = auth.uid())
  with check (technician_id = auth.uid());

-- bookings: customer + technician parties + admin ----------------------------

create policy "bookings_party_or_admin_select" on bookings
  for select using (
    customer_id = auth.uid() or technician_id = auth.uid() or public.is_admin()
  );

create policy "bookings_customer_insert" on bookings
  for insert with check (customer_id = auth.uid());

create policy "bookings_party_update" on bookings
  for update using (
    customer_id = auth.uid() or technician_id = auth.uid()
  )
  with check (
    customer_id = auth.uid() or technician_id = auth.uid()
  );

-- payments: owning customer + admin ------------------------------------------
-- Status transitions are driven by the Midtrans webhook (service role), which
-- bypasses RLS; clients only read.

create policy "payments_customer_or_admin_select" on payments
  for select using (customer_id = auth.uid() or public.is_admin());

-- invoices: booking parties + admin ------------------------------------------

create policy "invoices_party_or_admin_select" on invoices
  for select using (
    public.is_admin() or exists (
      select 1 from bookings b
      where b.id = invoices.booking_id
        and (b.customer_id = auth.uid() or b.technician_id = auth.uid())
    )
  );

-- reviews: public read, customer authors -------------------------------------

create policy "reviews_read_all" on reviews
  for select using (true);

create policy "reviews_customer_insert" on reviews
  for insert with check (customer_id = auth.uid());

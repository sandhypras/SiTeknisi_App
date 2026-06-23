-- Row Level Security untuk Service Catalog
-- Admin: Full access CRUD
-- Customer & Technician: Read only active services

-- 1. Enable RLS
alter table service_categories enable row level security;
alter table services enable row level security;
alter table service_photos enable row level security;

-- 2. Policies untuk service_categories

-- Admin dapat melakukan semua operasi
create policy "Admin can manage service categories"
  on service_categories
  for all
  to authenticated
  using (
    exists (
      select 1 from profiles
      where profiles.id = auth.uid()
      and profiles.role = 'admin'
    )
  )
  with check (
    exists (
      select 1 from profiles
      where profiles.id = auth.uid()
      and profiles.role = 'admin'
    )
  );

-- Semua user yang authenticated dapat melihat kategori aktif
create policy "Anyone can view active categories"
  on service_categories
  for select
  to authenticated
  using (is_active = true);

-- 3. Policies untuk services

-- Admin dapat melakukan semua operasi
create policy "Admin can manage services"
  on services
  for all
  to authenticated
  using (
    exists (
      select 1 from profiles
      where profiles.id = auth.uid()
      and profiles.role = 'admin'
    )
  )
  with check (
    exists (
      select 1 from profiles
      where profiles.id = auth.uid()
      and profiles.role = 'admin'
    )
  );

-- Semua user dapat melihat layanan aktif
create policy "Anyone can view active services"
  on services
  for select
  to authenticated
  using (is_active = true);

-- 4. Policies untuk service_photos

-- Admin dapat manage foto layanan
create policy "Admin can manage service photos"
  on service_photos
  for all
  to authenticated
  using (
    exists (
      select 1 from profiles
      where profiles.id = auth.uid()
      and profiles.role = 'admin'
    )
  )
  with check (
    exists (
      select 1 from profiles
      where profiles.id = auth.uid()
      and profiles.role = 'admin'
    )
  );

-- Semua user dapat melihat foto layanan aktif
create policy "Anyone can view service photos"
  on service_photos
  for select
  to authenticated
  using (
    exists (
      select 1 from services
      where services.id = service_photos.service_id
      and services.is_active = true
    )
  );

-- 5. Grant permissions
grant usage on schema public to authenticated;
grant select on service_categories to authenticated;
grant select on services to authenticated;
grant select on service_photos to authenticated;

-- Admin role akan dapat insert/update/delete melalui RLS policies

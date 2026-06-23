-- SiTeknisi auth foundation completion
-- Reference: docs/SYSTEM_ARCHITECTURE.md section 4, docs/PRD.md section 6.
--
-- Scope (phase-one completion):
-- 1. Auto-create a `profiles` row on signup so RLS helpers resolve a role.
-- 2. Generic `updated_at` trigger so mutation timestamps stay correct.
-- 3. Storage buckets (PRD section 5) with owner-scoped RLS policies.

-- 1. handle_new_user --------------------------------------------------------
-- Reads role/full_name from the signup payload (`raw_user_meta_data`) when
-- present, defaults to customer. The insert is `security definer` so the
-- auth schema can write into the public profiles table regardless of RLS.

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  meta_role text;
  resolved_role user_role;
begin
  meta_role := lower(coalesce(new.raw_user_meta_data->>'role', ''));
  if meta_role in ('customer', 'technician', 'admin') then
    resolved_role := meta_role::user_role;
  else
    resolved_role := 'customer';
  end if;

  insert into public.profiles (id, full_name, role)
  values (
    new.id,
    coalesce(nullif(new.raw_user_meta_data->>'full_name', ''), 'Pengguna Baru'),
    resolved_role
  );

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- 2. updated_at maintenance -------------------------------------------------

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

do $$
declare
  t text;
begin
  foreach t in array array[
    'profiles',
    'services',
    'technician_applications',
    'service_requests',
    'service_offers',
    'bookings',
    'payments'
  ]
  loop
    execute format(
      'drop trigger if exists trg_%1$s_updated_at on public.%1$s;
       create trigger trg_%1$s_updated_at
         before update on public.%1$s
         for each row execute function public.set_updated_at();',
      t
    );
  end loop;
end;
$$;

-- 3. Storage buckets --------------------------------------------------------
-- Buckets from docs/SYSTEM_ARCHITECTURE.md section 5. Policies mirror the
-- application-level RLS already declared on the related tables.

insert into storage.buckets (id, name, public)
values
  ('request-photos', 'request-photos', false),
  ('technician-documents', 'technician-documents', false),
  ('avatars', 'avatars', true),
  ('service-icons', 'service-icons', true)
on conflict (id) do nothing;

-- request-photos: customer owner + admin
drop policy if exists "request_photos_owner_or_admin_select" on storage.objects;
create policy "request_photos_owner_or_admin_select" on storage.objects
  for select using (
    bucket_id = 'request-photos'
    and (
      owner = auth.uid()
      or public.is_admin()
      or exists (
        select 1 from public.service_requests r
        where r.photo_url = name
          and (r.customer_id = auth.uid() or public.is_admin())
      )
    )
  );

drop policy if exists "request_photos_owner_insert" on storage.objects;
create policy "request_photos_owner_insert" on storage.objects
  for insert with check (
    bucket_id = 'request-photos' and owner = auth.uid()
  );

drop policy if exists "request_photos_owner_update" on storage.objects;
create policy "request_photos_owner_update" on storage.objects
  for update using (
    bucket_id = 'request-photos' and owner = auth.uid()
  )
  with check (
    bucket_id = 'request-photos' and owner = auth.uid()
  );

drop policy if exists "request_photos_owner_delete" on storage.objects;
create policy "request_photos_owner_delete" on storage.objects
  for delete using (
    bucket_id = 'request-photos' and owner = auth.uid()
  );

-- technician-documents: technician owner + admin
drop policy if exists "tech_docs_owner_or_admin_select" on storage.objects;
create policy "tech_docs_owner_or_admin_select" on storage.objects
  for select using (
    bucket_id = 'technician-documents'
    and (owner = auth.uid() or public.is_admin())
  );

drop policy if exists "tech_docs_owner_insert" on storage.objects;
create policy "tech_docs_owner_insert" on storage.objects
  for insert with check (
    bucket_id = 'technician-documents' and owner = auth.uid()
  );

drop policy if exists "tech_docs_owner_update" on storage.objects;
create policy "tech_docs_owner_update" on storage.objects
  for update using (
    bucket_id = 'technician-documents' and owner = auth.uid()
  )
  with check (
    bucket_id = 'technician-documents' and owner = auth.uid()
  );

drop policy if exists "tech_docs_owner_delete" on storage.objects;
create policy "tech_docs_owner_delete" on storage.objects
  for delete using (
    bucket_id = 'technician-documents' and owner = auth.uid()
  );

-- avatars: public read, owner write
drop policy if exists "avatars_public_select" on storage.objects;
create policy "avatars_public_select" on storage.objects
  for select using (bucket_id = 'avatars');

drop policy if exists "avatars_owner_insert" on storage.objects;
create policy "avatars_owner_insert" on storage.objects
  for insert with check (bucket_id = 'avatars' and owner = auth.uid());

drop policy if exists "avatars_owner_update" on storage.objects;
create policy "avatars_owner_update" on storage.objects
  for update using (bucket_id = 'avatars' and owner = auth.uid())
  with check (bucket_id = 'avatars' and owner = auth.uid());

drop policy if exists "avatars_owner_delete" on storage.objects;
create policy "avatars_owner_delete" on storage.objects
  for delete using (bucket_id = 'avatars' and owner = auth.uid());

-- service-icons: public read, admin write
drop policy if exists "service_icons_public_select" on storage.objects;
create policy "service_icons_public_select" on storage.objects
  for select using (bucket_id = 'service-icons');

drop policy if exists "service_icons_admin_write" on storage.objects;
create policy "service_icons_admin_write" on storage.objects
  for all using (
    bucket_id = 'service-icons' and public.is_admin()
  )
  with check (
    bucket_id = 'service-icons' and public.is_admin()
  );

-- Supabase Storage Configuration
-- TAHAP 2: Storage buckets untuk foto request, dokumen teknisi, dan avatars

-- 1. Create storage buckets
insert into storage.buckets (id, name, public)
values 
  ('request-photos', 'request-photos', false),
  ('technician-documents', 'technician-documents', false),
  ('avatars', 'avatars', true);

-- 2. Storage policies untuk request-photos bucket

-- Customer dapat upload foto untuk request miliknya
create policy "Customer can upload request photos"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'request-photos'
  and (storage.foldername(name))[1] = auth.uid()::text
);

-- Customer dapat melihat foto request miliknya
create policy "Customer can view own request photos"
on storage.objects for select
to authenticated
using (
  bucket_id = 'request-photos'
  and (storage.foldername(name))[1] = auth.uid()::text
);

-- Teknisi dapat melihat foto dari request yang mereka offer
create policy "Technician can view request photos they offered"
on storage.objects for select
to authenticated
using (
  bucket_id = 'request-photos'
  and exists (
    select 1 from service_offers so
    join service_requests sr on sr.id = so.request_id
    where so.technician_id = auth.uid()
    and (storage.foldername(name))[1] = sr.customer_id::text
  )
);

-- Admin dapat melihat semua request photos
create policy "Admin can view all request photos"
on storage.objects for select
to authenticated
using (
  bucket_id = 'request-photos'
  and exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'admin'
  )
);

-- Customer dapat delete foto request miliknya
create policy "Customer can delete own request photos"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'request-photos'
  and (storage.foldername(name))[1] = auth.uid()::text
);

-- 3. Storage policies untuk technician-documents bucket

-- Teknisi dapat upload dokumen miliknya (KTP, sertifikat)
create policy "Technician can upload own documents"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'technician-documents'
  and (storage.foldername(name))[1] = auth.uid()::text
  and exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'technician'
  )
);

-- Teknisi dapat melihat dokumen miliknya
create policy "Technician can view own documents"
on storage.objects for select
to authenticated
using (
  bucket_id = 'technician-documents'
  and (storage.foldername(name))[1] = auth.uid()::text
);

-- Admin dapat melihat semua dokumen teknisi (untuk verifikasi)
create policy "Admin can view all technician documents"
on storage.objects for select
to authenticated
using (
  bucket_id = 'technician-documents'
  and exists (
    select 1 from profiles
    where profiles.id = auth.uid()
    and profiles.role = 'admin'
  )
);

-- 4. Storage policies untuk avatars bucket (public bucket)

-- Semua authenticated user dapat upload avatar
create policy "Users can upload own avatar"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

-- Semua user dapat melihat avatars (public bucket)
create policy "Anyone can view avatars"
on storage.objects for select
to authenticated
using (bucket_id = 'avatars');

-- User dapat update avatar miliknya
create policy "Users can update own avatar"
on storage.objects for update
to authenticated
using (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

-- User dapat delete avatar miliknya
create policy "Users can delete own avatar"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

-- 5. Comments
comment on table storage.buckets is 'Storage buckets untuk photos, documents, dan avatars';

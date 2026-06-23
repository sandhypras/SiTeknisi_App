-- Create Admin Account
-- Script untuk membuat akun admin pertama

-- 1. Insert admin user ke auth.users (manual via Supabase Dashboard)
-- Email: admin@siteknisi.com
-- Password: Admin123!@#

-- 2. Setelah user dibuat di auth, jalankan script ini untuk set role admin
-- Ganti 'YOUR_USER_ID' dengan ID dari auth.users

-- Insert atau update profile dengan role admin
insert into profiles (id, full_name, phone, role, avatar_url)
values (
  'YOUR_USER_ID', -- Ganti dengan actual UUID dari auth.users
  'Admin SiTeknisi',
  '081234567890',
  'admin',
  null
)
on conflict (id) 
do update set 
  role = 'admin',
  full_name = 'Admin SiTeknisi',
  updated_at = now();

-- Verify admin account
select 
  p.id,
  p.full_name,
  p.role,
  u.email,
  p.created_at
from profiles p
join auth.users u on u.id = p.id
where p.role = 'admin';

-- ALTERNATIVE: Create admin via RPC function
create or replace function create_admin_user(
  user_email text,
  user_password text,
  user_full_name text,
  user_phone text default null
)
returns json as $$
declare
  new_user_id uuid;
  result json;
begin
  -- Note: This function needs to be called with service role key
  -- Cannot create auth users from regular SQL
  
  -- For now, admin must be created manually via:
  -- 1. Supabase Dashboard > Authentication > Users > Add User
  -- 2. Then update profile role to 'admin'
  
  raise exception 'Please create admin user via Supabase Dashboard first, then update role';
end;
$$ language plpgsql security definer;

-- Instructions for creating admin:
comment on function create_admin_user is 
'CARA MEMBUAT ADMIN:
1. Buka Supabase Dashboard
2. Go to Authentication > Users
3. Klik "Add User" atau "Invite"
4. Email: admin@siteknisi.com
5. Password: Admin123!@# (atau sesuai kebijakan)
6. Klik Create/Invite
7. Copy UUID user yang baru dibuat
8. Jalankan query:
   UPDATE profiles SET role = ''admin'' WHERE id = ''paste-uuid-here'';
9. Verify: SELECT * FROM profiles WHERE role = ''admin'';
';

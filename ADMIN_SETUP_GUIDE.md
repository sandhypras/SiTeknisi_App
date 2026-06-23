# Setup Admin Dashboard - Step by Step

## 🚀 LANGKAH 1: CREATE ADMIN ACCOUNT

### A. Via Supabase Dashboard (RECOMMENDED)

1. **Buka Supabase Dashboard**
   - URL: https://supabase.com/dashboard
   - Pilih project: `Siteknisi_App`

2. **Create Admin User**
   ```
   Navigate to: Authentication > Users > Add User
   
   Fill in:
   - Email: admin@siteknisi.com
   - Password: Admin123!@#
   - Auto Confirm User: ✅ (centang ini)
   
   Click: Create User
   ```

3. **Copy User ID**
   - Setelah user dibuat, copy UUID dari kolom `id`
   - Contoh: `a1b2c3d4-e5f6-7890-abcd-ef1234567890`

4. **Set Role Admin**
   - Go to: Table Editor > profiles
   - Atau buka SQL Editor dan jalankan:
   
   ```sql
   -- Ganti YOUR_USER_ID dengan UUID yang di-copy
   INSERT INTO profiles (id, full_name, phone, role)
   VALUES (
     'YOUR_USER_ID',
     'Admin SiTeknisi',
     '081234567890',
     'admin'
   )
   ON CONFLICT (id) 
   DO UPDATE SET 
     role = 'admin',
     full_name = 'Admin SiTeknisi',
     updated_at = now();
   ```

5. **Verify Admin**
   ```sql
   SELECT 
     p.id,
     p.full_name,
     p.role,
     u.email
   FROM profiles p
   JOIN auth.users u ON u.id = p.id
   WHERE p.role = 'admin';
   ```

### B. Default Admin Credentials
```
Email: admin@siteknisi.com
Password: Admin123!@#
Role: admin
```

---

## 🗄️ LANGKAH 2: RUN DATABASE MIGRATIONS

1. **Check Current Migrations**
   ```bash
   cd d:\siteknisi_apps
   ```

2. **Apply Migrations** (Pilih salah satu)

   **Option A: Via Supabase CLI** (jika sudah setup)
   ```bash
   supabase db push
   ```

   **Option B: Via Supabase Dashboard SQL Editor**
   - Copy & paste isi file migration satu per satu:
   
   ```
   1. supabase/migrations/20260622083000_initial_schema.sql
   2. supabase/migrations/20260622083100_basic_rls.sql
   3. supabase/migrations/20260622083200_auth_foundation.sql
   4. supabase/migrations/20260623000000_service_categories_and_products.sql
   5. supabase/migrations/20260623000100_service_catalog_rls.sql
   6. supabase/migrations/20260623010000_storage_buckets.sql
   7. supabase/migrations/20260623010100_service_request_system.sql
   8. supabase/migrations/20260623020000_offer_management_system.sql
   9. supabase/migrations/20260623030000_booking_tracking_system.sql
   ```

3. **Verify Tables Created**
   ```sql
   SELECT table_name 
   FROM information_schema.tables 
   WHERE table_schema = 'public'
   ORDER BY table_name;
   ```

   **Expected tables:**
   - profiles
   - service_categories (3 rows)
   - services (6 rows)
   - service_photos
   - service_requests
   - service_offers
   - bookings
   - payments
   - invoices
   - reviews
   - technician_applications

---

## 💻 LANGKAH 3: RUN ADMIN DASHBOARD

### A. Setup Environment Variables

1. **Check Supabase Config**
   ```bash
   cd d:\siteknisi_apps
   type .env
   ```

2. **Pastikan variabel ini ada:**
   ```
   SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co
   SUPABASE_PUBLISHABLE_KEY=eyJhbGci...
   ```

### B. Install Dependencies (jika belum)
```bash
flutter pub get
flutter clean
```

### C. Run Dashboard (Windows)

**Option 1: Via Batch File**
```bash
.\run_admin_dashboard.bat
```

**Option 2: Via Flutter Command**
```bash
flutter run -d windows ^
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

**Option 3: Run on Chrome**
```bash
flutter run -d chrome ^
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

### D. Login ke Admin Dashboard
```
Email: admin@siteknisi.com
Password: Admin123!@#
```

---

## 📊 LANGKAH 4: TEST ADMIN FEATURES

### A. Service Catalog Management
1. Navigate to: Services (di sidebar)
2. Test CRUD:
   - ✅ View categories & services
   - ✅ Create new service
   - ✅ Update base price
   - ✅ Activate/deactivate service

### B. Technician Applications
1. Navigate to: Technicians
2. Test:
   - ✅ View pending applications
   - ✅ Approve/reject applications
   - ✅ View technician documents (KTP)

### C. Bookings Monitor
1. Navigate to: Bookings
2. View:
   - ✅ Active bookings
   - ✅ Booking status
   - ✅ Payment status

### D. Statistics Dashboard
1. Navigate to: Dashboard
2. View:
   - ✅ Total bookings
   - ✅ Revenue stats
   - ✅ Platform fees
   - ✅ Active technicians

---

## 🔧 TROUBLESHOOTING

### Issue: "Email not confirmed"
**Fix:**
```sql
-- Di Supabase SQL Editor
UPDATE auth.users 
SET email_confirmed_at = now() 
WHERE email = 'admin@siteknisi.com';
```

### Issue: "RLS policy violation"
**Fix:**
```sql
-- Verify admin role
SELECT * FROM profiles WHERE role = 'admin';

-- If not admin, update:
UPDATE profiles 
SET role = 'admin' 
WHERE id = 'YOUR_USER_ID';
```

### Issue: Build failed (Windows)
**Fix:**
```bash
flutter clean
flutter pub get
flutter run -d windows
```

### Issue: "Table does not exist"
**Fix:** Run migrations lagi (LANGKAH 2)

---

## 📝 NEXT STEPS

1. ✅ Create admin account
2. ✅ Run migrations
3. ✅ Test admin dashboard
4. 🚀 Deploy backend (TAHAP 5-7)
5. 📱 Test full customer → technician flow

---

## 🔐 SECURITY NOTES

**PRODUCTION:**
- Ganti password admin yang lebih kuat
- Enable 2FA untuk admin
- Rotasi credentials regular
- Monitor admin activity logs
- Setup email verification
- Configure RLS policies ketat

**DEVELOPMENT:**
- Default password: `Admin123!@#`
- Auto-confirm user: ✅
- RLS enabled: ✅
- Storage policies: ✅

# Admin Dashboard - Running Guide

## 🚀 Cara Menjalankan Admin Dashboard

### Windows (Batch)
```bash
run_admin_supabase.bat
```

### Windows (PowerShell)
```bash
.\run_admin_supabase.ps1
```

### Manual Command
```bash
flutter run -d chrome \
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzMjU2ODMsImV4cCI6MjA1MTkwMTY4M30.yn10nCyasi6Y0-kLhQO9xH_cQ-5TaHfN7L_SdMeORAo \
  --dart-define=APP_MODE=admin \
  --web-port=8080
```

## 🔐 Login Admin

**URL**: http://localhost:8080

**Default Credentials**:
- Email: `admin@siteknisi.id`
- Password: `admin123` (atau sesuai yang didaftarkan di Supabase)

## 📊 Fitur Admin Dashboard

### 1. Dashboard Overview
- Total pengguna
- Booking aktif  
- Menunggu verifikasi teknisi
- Total pembayaran

### 2. Manajemen Data
- **Users**: Kelola customer, teknisi, admin
- **Verifikasi Teknisi**: Approve/reject pengajuan teknisi
- **Services**: CRUD layanan marketplace
- **Bookings**: Monitor status booking
- **Payments**: Audit transaksi
- **Invoices**: Kelola invoice
- **Reports**: Analisis performa
- **Settings**: Konfigurasi platform

## 🗄️ Database Connection

Admin dashboard terhubung ke:
- **Supabase URL**: https://rnofcprjnlvfvgwdynmc.supabase.co
- **Tables Used**:
  - `profiles` - Data user
  - `technician_profiles` - Data teknisi
  - `services` - Data layanan
  - `service_requests` - Data booking

## 📝 Repository yang Digunakan

1. **AdminUsersRepository**
   - `getUsers()` - List semua user
   - `updateUserStatus()` - Update status aktif/nonaktif
   - `deleteUser()` - Hapus user

2. **AdminTechniciansRepository**
   - `getTechnicians()` - List pengajuan teknisi
   - `updateTechnicianStatus()` - Approve/reject teknisi

3. **AdminServicesRepository**
   - `getServices()` - List layanan
   - `createService()` - Tambah layanan baru
   - `updateService()` - Update layanan
   - `deleteService()` - Hapus layanan

4. **AdminBookingsRepository**
   - `getBookings()` - List booking dengan filter

## ⚠️ Troubleshooting

### Error: "Supabase not initialized"
Pastikan menjalankan dengan `--dart-define` flags atau gunakan script yang disediakan.

### Error: "Invalid credentials"
Buat akun admin terlebih dahulu di Supabase:
1. Buka Supabase Dashboard
2. Authentication > Users > Add User
3. Set role = 'admin' di table profiles

### Dashboard kosong (no data)
Database masih kosong. Gunakan:
- Seed data dari migrations
- Tambah data manual lewat dashboard
- Import data sample

## 🔄 Development Workflow

1. **Run dashboard**:
   ```bash
   run_admin_supabase.bat
   ```

2. **Login dengan akun admin**

3. **Test fitur CRUD**:
   - Tambah layanan baru
   - Verifikasi teknisi
   - Monitor booking
   - Update status

4. **Check database changes** di Supabase Dashboard

## 📚 Related Files

- `lib/features/admin/data/admin_providers.dart` - Riverpod providers
- `lib/features/admin/data/admin_*_repository.dart` - Repository classes
- `lib/features/admin/presentation/screens/admin_dashboard_screen.dart` - UI

## 🌐 URLs

- **Admin Dashboard**: http://localhost:8080
- **Customer App**: http://localhost:8080 (tanpa APP_MODE=admin)
- **Supabase Dashboard**: https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc

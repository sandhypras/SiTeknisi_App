# 🧪 Branch: feature/integrated-testing

Branch ini menggabungkan **semua fitur yang sudah selesai** untuk diuji secara terintegrasi.

---

## 📦 Fitur yang Diintegrasikan

### ✅ 1. Customer Service Request (Phase 1)
- Form pengajuan service request
- Upload foto kerusakan (max 3 foto)
- Validasi input form
- Integrasi Supabase database & storage
- Mapping service ID dummy ke UUID database

**Status**: ✅ Backend Complete, ⏳ Perlu Testing

---

### ✅ 2. Admin Dashboard Repositories
- AdminUsersRepository - Kelola user
- AdminTechniciansRepository - Verifikasi teknisi  
- AdminServicesRepository - CRUD layanan
- AdminBookingsRepository - Monitor booking

**Status**: ✅ Repository Complete, ⏳ Perlu Integrasi ke UI

---

## 🚀 Cara Testing

### Test 1: Customer Service Request
```bash
test_customer_service_request.bat
```
**URL**: http://localhost:8081

**Flow**:
1. Register/Login sebagai customer
2. Klik "Pesan Layanan"
3. Pilih layanan (contoh: Servis Printer)
4. Isi form lengkap
5. Upload 1-3 foto
6. Submit
7. Cek database di Supabase Dashboard

---

### Test 2: Admin Dashboard
```bash
test_admin_dashboard.bat
```
**URL**: http://localhost:8082

**Flow**:
1. Login sebagai admin (`admin@siteknisi.id`)
2. Test menu Services:
   - List layanan
   - Tambah layanan baru
   - Edit layanan
   - Hapus layanan
3. Test menu Verifikasi Teknisi:
   - List pengajuan
   - Approve teknisi
   - Reject teknisi
4. Test menu Bookings:
   - List booking
   - Filter by status

---

## 📊 Test Cases Detail

Lihat file **INTEGRATED_TESTING.md** untuk:
- Test cases lengkap dengan expected result
- Known issues
- Testing checklist
- Troubleshooting guide

---

## 📁 Struktur File

```
lib/
├── core/
│   └── utils/
│       └── storage_service.dart          # Upload foto ke Supabase Storage
├── features/
    ├── customer/
    │   ├── data/
    │   │   ├── service_request_repository.dart   # CRUD service requests
    │   │   └── service_mapper.dart               # Map dummy ID ke UUID
    │   └── presentation/
    │       ├── providers/
    │       │   └── service_request_providers.dart
    │       └── screens/booking/
    │           └── create_service_request_screen.dart
    └── admin/
        └── data/
            ├── admin_users_repository.dart
            ├── admin_technicians_repository.dart
            ├── admin_services_repository.dart
            ├── admin_bookings_repository.dart
            └── admin_providers.dart

supabase/
└── migrations/
    └── 20260622090000_seed_services.sql   # Seed 6 services
```

---

## 🗄️ Database Schema

### Tables Used
- ✅ `profiles` - User data
- ✅ `services` - Katalog layanan (6 services)
- ✅ `service_requests` - Pengajuan customer
- ✅ `technician_profiles` - Data teknisi

### Storage Buckets
- ✅ `request-photos` - Foto kerusakan (private)
- ✅ `technician-documents` - Dokumen teknisi (private)
- ✅ `avatars` - Avatar user (public)
- ✅ `service-icons` - Icon layanan (public)

---

## ✅ Testing Checklist

### Customer Features
- [ ] Register customer baru
- [ ] Login customer
- [ ] Browse layanan
- [ ] Pilih layanan "Servis Printer"
- [ ] Isi form service request
- [ ] Upload 1 foto
- [ ] Upload 3 foto (max)
- [ ] Coba upload foto ke-4 (should error)
- [ ] Submit dengan semua field kosong (should error)
- [ ] Submit dengan data valid (should success)
- [ ] Cek data di Supabase Dashboard table `service_requests`
- [ ] Cek foto di bucket `request-photos`

### Admin Features  
- [ ] Login admin
- [ ] View dashboard overview
- [ ] CRUD Services - Tambah layanan baru
- [ ] CRUD Services - Edit layanan
- [ ] CRUD Services - Hapus layanan
- [ ] CRUD Services - Cek data di database
- [ ] Verifikasi Teknisi - List pending
- [ ] Verifikasi Teknisi - Approve
- [ ] Verifikasi Teknisi - Reject
- [ ] Monitor Bookings - List all
- [ ] Monitor Bookings - Filter by "Menunggu"
- [ ] Monitor Bookings - Filter by "Selesai"

---

## 🐛 Known Issues

1. **IconData Error**: `customer_dummy_data.dart` masih gunakan String untuk icon, perlu diubah ke IconData
2. **Port Conflict**: Jika port 8081/8082 sudah digunakan, matikan proses dengan:
   ```bash
   netstat -ano | findstr :8081
   taskkill /F /PID <PID>
   ```
3. **Chrome Connection Error**: Kadang gagal connect, close semua Chrome window dan retry

---

## 📝 Test Results Template

Setelah testing, isi hasil di bawah:

### Customer Service Request
- [ ] ✅ Register/Login: 
- [ ] ✅ Form validation: 
- [ ] ✅ Photo upload: 
- [ ] ✅ Database save: 
- [ ] ✅ Storage upload: 

**Bugs Found**: 
1. 
2. 

---

### Admin Dashboard
- [ ] ✅ Login admin: 
- [ ] ✅ CRUD Services: 
- [ ] ✅ Verifikasi Teknisi: 
- [ ] ✅ Monitor Bookings: 

**Bugs Found**: 
1. 
2. 

---

## 🔄 Next Steps

Setelah testing selesai dan semua bug fixed:

1. ✅ Review test results
2. 🔧 Fix bugs yang ditemukan
3. ✅ Update documentation
4. 🎯 Merge to `dev` branch
5. 🚀 Deploy to staging
6. 📋 Start Phase 2: Technician features

---

## 📚 Related Docs

- `INTEGRATED_TESTING.md` - Test cases detail
- `TESTING_GUIDE_PHASE1.md` - Testing guide Phase 1
- `ADMIN_DASHBOARD_GUIDE.md` - Admin dashboard guide
- `TROUBLESHOOTING.md` - Troubleshooting common issues

---

## 📞 Support

Jika ada masalah saat testing:
1. Check browser console (F12)
2. Check Flutter debug console
3. Check Supabase Dashboard logs
4. Lihat `TROUBLESHOOTING.md`

# Integrated Testing Branch

Branch ini menggabungkan semua fitur yang sudah selesai dan siap untuk diuji.

## 📦 Fitur yang Diintegrasikan

### 1. ✅ Customer Service Request (Phase 1)
**Branch**: `feature/customer-service-request`

**Fitur**:
- Form pengajuan service request
- Upload foto kerusakan (max 3 foto)
- Validasi input form
- Integrasi dengan database Supabase
- Mapping service ID dari dummy ke database UUID

**Files**:
- `lib/features/customer/data/service_request_repository.dart`
- `lib/features/customer/data/service_mapper.dart`
- `lib/core/utils/storage_service.dart`
- `lib/features/customer/presentation/screens/booking/create_service_request_screen.dart`
- `lib/features/customer/presentation/providers/service_request_providers.dart`

**Database**:
- Table: `service_requests`
- Table: `services` (dengan seed data)
- Bucket: `request-photos`

---

### 2. ✅ Admin Dashboard Repositories
**Branch**: `feature/admin-dashboard-supabase`

**Fitur**:
- AdminUsersRepository - Kelola user
- AdminTechniciansRepository - Verifikasi teknisi
- AdminServicesRepository - CRUD layanan
- AdminBookingsRepository - Monitor booking

**Files**:
- `lib/features/admin/data/admin_users_repository.dart`
- `lib/features/admin/data/admin_technicians_repository.dart`
- `lib/features/admin/data/admin_services_repository.dart`
- `lib/features/admin/data/admin_bookings_repository.dart`
- `lib/features/admin/data/admin_providers.dart`

---

## 🧪 Cara Testing

### Setup
```bash
# Clone dan checkout branch ini
git checkout feature/integrated-testing

# Install dependencies
flutter pub get

# Jalankan migrations (jika belum)
cd supabase
supabase db push
cd ..
```

### Test Customer Service Request
```bash
# Jalankan app
run_with_supabase.bat

# Flow testing:
1. Login sebagai customer
2. Buka menu "Pesan Layanan"
3. Pilih layanan (contoh: Servis Printer)
4. Isi form:
   - Deskripsi masalah
   - Alamat lengkap
   - Tanggal & waktu
   - Upload foto (optional)
5. Submit
6. Cek database di Supabase Dashboard
```

### Test Admin Dashboard
```bash
# Jalankan admin dashboard
run_admin_supabase.bat

# Flow testing:
1. Login sebagai admin
2. Test CRUD Services:
   - Tambah layanan baru
   - Edit layanan existing
   - Hapus layanan
3. Test Verifikasi Teknisi:
   - List pengajuan
   - Approve/Reject
4. Test Monitor Booking:
   - List semua booking
   - Filter by status
```

---

## 📊 Test Cases

### Customer Service Request

#### TC-01: Submit Service Request (Happy Path)
**Steps**:
1. Login sebagai customer
2. Pilih "Servis Printer"
3. Isi semua field dengan valid
4. Upload 2 foto
5. Submit

**Expected**:
- Success message muncul
- Data tersimpan di `service_requests`
- Foto tersimpan di bucket `request-photos`
- Service ID mapped ke UUID database

#### TC-02: Form Validation
**Steps**:
1. Submit form kosong

**Expected**:
- Error "Deskripsi wajib diisi"
- Error "Alamat wajib diisi"
- Form tidak submit

#### TC-03: Upload Photo
**Steps**:
1. Upload 3 foto valid (JPG/PNG, < 5MB)
2. Coba upload foto ke-4

**Expected**:
- 3 foto pertama berhasil
- Error "Maksimal 3 foto"

---

### Admin Dashboard

#### TC-04: CRUD Services
**Steps**:
1. Login admin
2. Buka "Layanan"
3. Tambah layanan baru
4. Edit layanan
5. Hapus layanan

**Expected**:
- Operasi CRUD berhasil
- Data sinkron dengan database
- Success notification muncul

#### TC-05: Verifikasi Teknisi
**Steps**:
1. Login admin
2. Buka "Verifikasi Teknisi"
3. Approve pengajuan teknisi

**Expected**:
- Status berubah di database
- Notification muncul
- List ter-update

---

## 🐛 Known Issues

1. **IconData type error**: Customer dummy data masih gunakan String untuk icon, perlu diubah ke IconData
2. **Port conflict**: Port 8080 sering bentrok, gunakan port 8081
3. **Chrome connection**: Kadang gagal connect, close Chrome dan retry

---

## 📝 Testing Checklist

### Customer Features
- [ ] Register customer baru
- [ ] Login customer
- [ ] Lihat list layanan
- [ ] Buat service request
- [ ] Upload foto kerusakan
- [ ] Validasi form
- [ ] Logout

### Admin Features
- [ ] Login admin
- [ ] View dashboard overview
- [ ] List users
- [ ] List technicians
- [ ] Approve technician
- [ ] Reject technician
- [ ] CRUD services
- [ ] Monitor bookings
- [ ] Filter by status
- [ ] Logout

---

## 🔄 Next Steps After Testing

1. **Fix bugs** yang ditemukan
2. **Merge ke dev** jika semua test pass
3. **Create PR** ke main untuk production
4. **Update documentation** dengan hasil testing
5. **Lanjut ke Phase 2**: Technician features

---

## 📞 Support

Jika ada issue saat testing:
1. Check `TROUBLESHOOTING.md`
2. Check Supabase logs
3. Check browser console
4. Check Flutter debug console

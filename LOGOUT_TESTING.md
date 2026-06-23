# ✅ LOGOUT FUNCTIONALITY - Testing Guide

## 🎯 Yang Sudah Difungsikan:

### Customer Profile - Logout Button
✅ Tombol "Keluar dari akun" di Customer Profile sudah berfungsi dengan:
- Real Supabase signOut (jika mode Supabase)
- Mock logout (jika mode Mock)
- Loading indicator saat proses logout
- Success/error feedback
- Redirect ke Splash screen setelah logout

---

## 🧪 Cara Test Logout:

### **Step 1: Login/Register Dulu**

1. Jalankan app dengan Supabase:
   ```powershell
   flutter run -d chrome --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4 --dart-define=APP_MODE=mobile
   ```

2. Register atau Login dengan:
   - Email: `test@example.com`
   - Password: `password123`

3. Setelah berhasil login, akan masuk ke Customer Home

---

### **Step 2: Buka Profile**

1. Klik icon **Profile** di bottom navigation (icon paling kanan)
2. Scroll ke bawah
3. Cari tombol merah: **"Keluar dari akun"**

---

### **Step 3: Test Logout**

1. Klik tombol **"Keluar dari akun"**
2. Akan muncul dialog konfirmasi:
   ```
   Keluar dari akun?
   Anda perlu masuk kembali untuk melihat booking dan invoice.
   ```
3. Klik **"Keluar"**

---

### **Expected Behavior:**

#### ✅ Loading State:
```
Snackbar: "Keluar dari akun..." (dengan loading spinner)
```

#### ✅ Success:
```
Snackbar: "Berhasil keluar dari akun" (hijau)
App redirect ke Splash screen
```

#### ❌ Jika Error:
```
Snackbar: "Gagal logout: [error message]" (merah)
Tetap di halaman profile
```

---

### **Step 4: Verifikasi Logout Berhasil**

Setelah logout:

1. ✅ App harus kembali ke **Splash screen**
2. ✅ Coba akses halaman yang butuh login (misal: Profile)
3. ✅ Harus redirect ke **Login screen**
4. ✅ Di Supabase Dashboard > Authentication > Users:
   - User masih ada (tidak terhapus)
   - Tapi session sudah cleared

---

## 🔍 Technical Details

### Logout Flow:

```
1. User klik "Keluar dari akun"
   ↓
2. Tampilkan dialog konfirmasi
   ↓
3. User klik "Keluar"
   ↓
4. Show loading snackbar
   ↓
5. Call authRepository.signOut()
   ↓
6. Clear Supabase session
   ↓
7. Show success message
   ↓
8. Navigate to Splash screen
   ↓
9. Router guard detects no user
   ↓
10. Redirect to Login if accessing protected routes
```

---

## 📱 Testing Scenarios

### ✅ Scenario 1: Supabase Mode - Customer
- Login dengan email/password
- Buka Profile
- Logout
- Expected: Session cleared, redirect ke Splash

### ✅ Scenario 2: Mock Mode - Customer
- Jalankan tanpa `--dart-define`
- Browse sebagai guest
- Expected: Logout button tidak muncul (guest tidak perlu logout)

### ✅ Scenario 3: After Logout - Access Protected Route
- Logout dari customer profile
- Coba akses `/customer/profile` langsung
- Expected: Redirect ke `/login?returnUrl=/customer/profile`

### ✅ Scenario 4: After Logout - Login Again
- Logout
- Login lagi dengan akun yang sama
- Expected: Berhasil login, data profil tetap ada

---

## 🐛 Known Issues & Limitations

### ⚠️ Technician Logout:
- Belum diimplementasi
- Jika login sebagai technician, logout belum ada di dashboard technician

### ⚠️ Admin Logout:
- Belum diimplementasi
- Admin dashboard belum ada tombol logout

---

## 🔧 Troubleshooting

### Error: "Gagal logout"
**Penyebab:** Network issue atau Supabase error

**Solusi:**
1. Cek internet connection
2. Coba lagi
3. Jika masih error, restart app

### Logout Berhasil tapi Tetap Login
**Penyebab:** Router guard tidak detect perubahan auth state

**Solusi:**
1. Hard refresh (Ctrl+Shift+R di Chrome)
2. Restart app
3. Clear cache: `flutter clean && flutter run ...`

### Session Tidak Clear
**Penyebab:** Supabase client cache issue

**Solusi:**
1. Close tab/window
2. Open new tab
3. Jalankan app ulang

---

## 📊 Verification Checklist

Setelah test logout, verifikasi:

- [ ] Snackbar "Keluar dari akun..." muncul
- [ ] Snackbar "Berhasil keluar dari akun" muncul
- [ ] App redirect ke Splash screen
- [ ] Bottom navigation hilang (tidak ada di splash)
- [ ] Coba akses Profile → redirect ke Login
- [ ] Login lagi berhasil dengan akun yang sama
- [ ] Console tidak ada error message

---

## 🎯 Next Steps

Setelah logout berfungsi di Customer Profile:

1. ⏳ Implement logout di Technician Dashboard
2. ⏳ Implement logout di Admin Dashboard
3. ⏳ Add "Force logout all sessions" feature
4. ⏳ Add logout confirmation with "Remember me" option

---

## 📚 Related Files

- `customer_profile_screen.dart` - Logout button & logic
- `auth_repository.dart` - signOut() method
- `app_router.dart` - Auth guard & redirect logic
- `auth_providers.dart` - Auth state management

---

**Test sekarang: Jalankan app, login, dan test logout!**

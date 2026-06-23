# 🚀 SUPABASE INTEGRATION - QUICK START

## ✅ Status Integrasi

- [x] Supabase Project: **Siteknisi_App** (rnofcprjnlvfvgwdynmc)
- [x] Region: Sydney (Oceania)
- [x] Database migrations: **Semua sudah ter-apply** (3 migrations)
- [x] Credentials: **Sudah dikonfigurasi** di `.vscode/launch.json`
- [x] Auth trigger: `handle_new_user` - **Aktif**

---

## 🎯 Cara Jalankan dengan Supabase

### Opsi 1: Dari VS Code (Recommended)
1. Tekan `F5`
2. Pilih **"Supabase Mode"**
3. App akan connect ke Supabase cloud

### Opsi 2: Dari Command Line
```bash
flutter run --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

---

## 🧪 Test Koneksi

Setelah app jalan, cek console output:

```
=== SUPABASE CONFIG CHECK ===
URL: https://rnofcprjnlvfvgwdynmc.supabase.co
Key: eyJhbGciOiJIUzI1NiIsI...
Configured: true  <-- Harus TRUE
============================
```

---

## 📝 Test Register

1. Buka app
2. Klik **"Daftar"** atau **"Buat Akun"**
3. Isi form:
   - Nama: `Test User`
   - HP: `08123456789`
   - Email: `test@example.com` (gunakan email unique)
   - Password: `password123`
4. Klik **"Buat Akun"**

### Expected Result:
✅ **Berhasil:** Muncul snackbar "Akun berhasil dibuat. Silakan masuk."

❌ **Gagal:** Lihat error message:
- "Email sudah terdaftar" → Gunakan email lain
- "Password tidak memenuhi syarat" → Min 6 karakter
- "Format email tidak valid" → Cek format email
- Error lain → Screenshot dan kirim ke developer

---

## 🔍 Verifikasi di Supabase Dashboard

1. Buka [Supabase Dashboard](https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc)
2. Pergi ke **Authentication > Users**
3. User baru harus muncul dengan:
   - Email yang didaftarkan
   - Status: Active (jika email confirmation OFF) atau Waiting for Verification

4. Pergi ke **Database > Table Editor > profiles**
5. Harus ada row baru dengan:
   - `id` = User ID dari auth
   - `full_name` = "Test User"
   - `role` = "customer" atau "technician"
   - `phone` = "08123456789"

---

## 🎛️ Supabase Project Settings

### Email Confirmations: OFF
Auth sudah dikonfigurasi dengan `enable_confirmations = false` di `config.toml`.

Artinya: User langsung bisa login tanpa verifikasi email.

Untuk mengubah:
1. Edit `supabase/config.toml`
2. Set `enable_confirmations = true`
3. Run `supabase db push`

### RLS (Row Level Security)
RLS policies sudah aktif dari migration `20260622083100_basic_rls.sql`.

Cek di Dashboard > Database > Policies untuk melihat semua rules.

---

## 🚨 Troubleshooting

### "invalid api key"
→ Credentials salah. Cek `.vscode/launch.json` atau run dengan command line yang benar.

### "Terjadi kesalahan autentikasi"
→ Cek console log untuk error detail. Kemungkinan:
- Network issue
- Trigger `handle_new_user` gagal
- Email sudah terdaftar

### "Email sudah terdaftar"
→ Gunakan email lain atau hapus user dari Dashboard > Authentication > Users

### App masih dalam Mock Mode
→ Pastikan jalankan dengan "Supabase Mode" atau dengan `--dart-define`

---

## 📚 Resources

- [Supabase Dashboard](https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc)
- [API Documentation](https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc/api)
- [Database Schema](https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc/database/tables)
- [SQL Editor](https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc/sql/new)

---

## 🔐 Security Notes

⚠️ **JANGAN commit credentials ke Git!**

File `.vscode/launch.json` sudah berisi API key. Pastikan ada di `.gitignore`.

Untuk production, gunakan environment variables atau Flutter build config.

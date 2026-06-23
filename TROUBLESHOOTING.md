# SETUP & TROUBLESHOOTING GUIDE

## ⚠️ Error "invalid api key"

### Penyebab:
Anda menjalankan app dengan `--dart-define` tapi kredensial Supabase salah atau tidak lengkap.

### Solusi:

**OPSI 1: Jalankan Mock Mode (Tanpa Supabase)**
```bash
# Stop app yang sedang jalan (Ctrl+C)
# Clean build
flutter clean
flutter pub get

# Jalankan TANPA --dart-define
flutter run

# Atau dari VS Code: tekan F5, pilih "Mock Mode (No Supabase)"
```

**OPSI 2: Fix Kredensial Supabase**
1. Buka [Supabase Dashboard](https://supabase.com/dashboard)
2. Pilih project Anda
3. Pergi ke Settings > API
4. Copy:
   - **Project URL** (contoh: https://xxxxx.supabase.co)
   - **anon/public key** (string panjang dimulai dengan eyJ...)

5. Edit `.vscode/launch.json`, ganti:
   ```json
   "args": [
     "--dart-define=SUPABASE_URL=https://xxxxx.supabase.co",
     "--dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOi..."
   ]
   ```

6. Run dari VS Code (F5) > pilih "Supabase Mode"

---

## ⚠️ Error "Terjadi kesalahan autentikasi ketika buat akun"

### Penyebab:
1. **Supabase belum dikonfigurasi** - App jalan dalam mode mock
2. **Trigger database belum dijalankan** - Profile tidak otomatis dibuat
3. **Kredensial Supabase salah**

---

## ✅ SOLUSI 1: Jalankan dalam Mock Mode (Tanpa Backend)

Jika Anda **belum setup Supabase** atau ingin **test UI saja**, pastikan:

```bash
# Jalankan tanpa --dart-define
flutter run

# Atau explicit untuk Windows
flutter run -d windows
```

**Expected behavior:** 
- Register akan menampilkan snackbar "Mock register berhasil. Integrasi Supabase belum aktif."
- Login langsung ke customer home tanpa validasi real

**Jika masih error**, cek debug log saat startup:
```
=== SUPABASE CONFIG CHECK ===
URL: KOSONG
Key: KOSONG
Configured: false
============================
```

---

## ✅ SOLUSI 2: Setup Supabase (Backend Real)

### Langkah 1: Buat Project Supabase
1. Buka [https://supabase.com](https://supabase.com)
2. Create new project
3. Catat **Project URL** dan **anon/public key**

### Langkah 2: Jalankan Migrasi Database
```bash
cd supabase

# Login ke Supabase CLI
supabase login

# Link ke project Anda
supabase link --project-ref <your-project-ref>

# Push migrations
supabase db push
```

### Langkah 3: Verifikasi Trigger
Buka **Supabase Dashboard > SQL Editor**, jalankan:
```sql
SELECT proname FROM pg_proc WHERE proname = 'handle_new_user';
```
Harus return 1 row.

### Langkah 4: Run dengan Credentials
```bash
flutter run \
  --dart-define=SUPABASE_URL=https://xxxxx.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGc...

# Windows (cmd):
flutter run --dart-define=SUPABASE_URL=https://xxxxx.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGc...
```

### Langkah 5: (Opsional) Simpan ke Launch Config
Buat `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "siteknisi_apps (Mock)",
      "request": "launch",
      "type": "dart"
    },
    {
      "name": "siteknisi_apps (Supabase)",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=SUPABASE_URL=https://xxxxx.supabase.co",
        "--dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGc..."
      ]
    }
  ]
}
```

---

## 🔍 Debug Checklist

Jalankan app dan cek console/debug log:

1. **Saat startup:**
   ```
   === SUPABASE CONFIG CHECK ===
   URL: https://xxxxx.supabase.co  <-- Harus ada jika pakai Supabase
   Key: eyJhbGc...                 <-- Harus ada jika pakai Supabase
   Configured: true                <-- true = pakai Supabase
   ============================
   ```

2. **Saat register error:**
   - Buka Debug Console
   - Lihat error message lengkap
   - Jika ada "database error" atau "saving new user" → trigger belum jalan
   - Jika ada "email already registered" → email sudah dipakai
   - Jika ada "invalid email" → format email salah
   - Jika ada "password" → password kurang dari 6 karakter

---

## 🛠️ Quick Fixes

### Error: "Mock register berhasil" muncul tapi tetap error
**Solusi:** Ada cached state, restart app:
```bash
flutter clean
flutter pub get
flutter run
```

### Error: "Gagal menyimpan profil akun di server"
**Solusi:** Trigger database belum jalan, run migrasi ulang:
```bash
supabase db reset
```

### Error: "Email sudah terdaftar"
**Solusi:** Gunakan email lain atau hapus user dari Supabase Dashboard > Authentication > Users

---

## 📞 Need Help?
Jalankan app dengan debug on, screenshot console output, dan share error messagenya.

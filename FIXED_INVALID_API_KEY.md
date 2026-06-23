# 🎯 FIXED: Invalid API Key Error

## Masalah
Error "invalid api key" terjadi karena app dijalankan **TANPA credentials Supabase**.

## ✅ Solusi

### STOP app yang sedang jalan dulu (jika ada):
- Tekan `Ctrl+C` di terminal
- Atau close emulator/app

### Kemudian jalankan DENGAN CARA INI:

#### **CARA 1: Double-click file ini (TERMUDAH)**
```
run_with_supabase.bat
```

#### **CARA 2: Dari VS Code**
1. Tekan `F5`
2. Pilih **"Supabase Mode"** (BUKAN Mock Mode)

---

## 🔍 Verifikasi

Setelah app start, **WAJIB** cek console output:

### ✅ BENAR (Supabase Active):
```
==================================================
SUPABASE CONFIG CHECK
==================================================
URL: ✓ https://rnofcprjnlvfvgwdynmc.supabase.co
Key: ✓ eyJhbGciOiJIUzI1NiIsInR5cCI6...
Configured: ✓ TRUE

✓ Supabase Integration Active
✓ Ready for production mode
==================================================
```

### ❌ SALAH (Mock Mode):
```
==================================================
SUPABASE CONFIG CHECK
==================================================
URL: ❌ KOSONG
Key: ❌ KOSONG
Configured: ❌ FALSE

⚠️  APP RUNNING IN MOCK MODE (No Backend)
==================================================
```

Jika muncul "MOCK MODE" = credentials tidak ter-load, **ulangi lagi** dengan `run_with_supabase.bat`

---

## 🧪 Test Register

Setelah **YAKIN** muncul "Supabase Integration Active":

1. Buka app
2. Klik "Daftar"
3. Isi form dengan data valid
4. Submit
5. Expected: **"Akun berhasil dibuat. Silakan masuk."**

---

## 🐛 Masih Error?

### Jika masih "invalid api key":
```bash
# 1. Stop app
# 2. Clean build
flutter clean
flutter pub get

# 3. Jalankan ulang
run_with_supabase.bat
```

### Jika ada error lain:
- Screenshot console output
- Screenshot error message di app
- Baca [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

## 📝 File-File Penting

- `START_HERE.md` - Panduan lengkap cara run
- `SUPABASE_INTEGRATION.md` - Setup & konfigurasi
- `TROUBLESHOOTING.md` - Error fixes
- `run_with_supabase.bat` - **USE THIS FILE**
- `diagnostic.bat` - Check system status

---

**INGAT:** 
- ✅ Gunakan `run_with_supabase.bat`
- ❌ JANGAN gunakan `flutter run` biasa
- ❌ JANGAN pilih "Mock Mode"

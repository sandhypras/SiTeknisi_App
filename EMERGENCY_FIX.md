# 🚨 EMERGENCY FIX: Invalid API Key (401 Error)

## ❌ Error Yang Anda Alami:

```
❌ AuthException during signup:
  Status: 401
  Message: Invalid API key
```

---

## ✅ SOLUSI PASTI (Ikuti Step by Step):

### **Step 1: STOP App yang Sedang Jalan**

Tekan `Ctrl+C` berkali-kali sampai terminal stop.

Atau close terminal/VS Code sekalian.

---

### **Step 2: Jalankan Fix Script**

Double-click file ini:
```
fix_invalid_api_key.bat
```

Tunggu sampai selesai (akan clean cache).

---

### **Step 3: Jalankan dengan Script VERIFIED**

Double-click file ini:
```
run_supabase_verified.bat
```

⚠️ **JANGAN** gunakan `flutter run` biasa!
⚠️ **JANGAN** double-click app dari explorer!

---

### **Step 4: WAJIB Cek Console Output**

Setelah app mulai build, **HARUS** muncul:

```
==================================================
SUPABASE CONFIG CHECK
==================================================
URL: ✓ https://rnofcprjnlvfvgwdynmc.supabase.co
Key: ✓ eyJhbGciOiJIUzI1NiIsInR5cCI6...
Key Length: 255 chars ✓
Key Format: ✓ Valid JWT format
Configured: ✓ TRUE

✓ Supabase Integration Active
✓ Ready for production mode
==================================================
```

### ❌ Jika Muncul Ini = SALAH:
```
URL: ❌ KOSONG
Key: ❌ KOSONG
⚠️  APP RUNNING IN MOCK MODE
```

**Jika muncul MOCK MODE:**
1. Stop app (Ctrl+C)
2. Jalankan `run_supabase_verified.bat` lagi
3. Pastikan tidak ada error saat build

---

### **Step 5: Test Register**

**HANYA** lakukan ini setelah yakin console menunjukkan "Supabase Integration Active".

1. Klik "Daftar"
2. Isi form:
   - Nama: Test User
   - HP: 08123456789
   - Email: sandhyprasetyo41+test@gmail.com (tambah +test untuk unique)
   - Password: password123
3. Submit

**Expected:**
```
✅ "Akun berhasil dibuat. Silakan masuk."
```

**Jika masih "Invalid API key":**
Screenshot console output dan lanjut ke "Troubleshooting Advanced"

---

## 🔍 Kenapa Terjadi?

Error 401 "Invalid API key" terjadi karena salah satu ini:

1. ❌ App dijalankan dengan `flutter run` biasa (tanpa --dart-define)
2. ❌ Menjalankan dari VS Code tapi salah pilih config (pilih Mock Mode)
3. ❌ Ada credentials lama yang ter-cache
4. ❌ Double-click executable yang sudah di-build sebelumnya

---

## 🛠️ Troubleshooting Advanced

### Jika Masih Error Setelah Ikuti Semua Step:

#### Check 1: Pastikan tidak ada proses Flutter lain
```bash
tasklist | findstr flutter
tasklist | findstr dart
```

Jika ada, kill semua:
```bash
taskkill /F /IM dart.exe
taskkill /F /IM flutter.exe
```

#### Check 2: Verifikasi API Key dari Supabase
```bash
verify_api_key.bat
```

Compare output dengan key di `run_supabase_verified.bat`.

#### Check 3: Full Clean
```bash
flutter clean
del /S /Q .dart_tool
del /S /Q build
flutter pub get
```

Lalu run ulang dengan `run_supabase_verified.bat`.

#### Check 4: Run Manual dengan Copy-Paste

Copy command ini PERSIS (full line):

```cmd
flutter run --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

Paste ke terminal dan enter.

---

## 📝 Diagnostic Checklist

Setelah run `run_supabase_verified.bat`, console output **HARUS** menunjukkan:

- [ ] URL: ✓ https://rnofcprjnlvfvgwdynmc.supabase.co
- [ ] Key: ✓ eyJhbGciOiJIUzI1NiIsInR5cCI6...
- [ ] Key Length: 255 chars ✓
- [ ] Key Format: ✓ Valid JWT format
- [ ] Configured: ✓ TRUE
- [ ] ✓ Supabase Integration Active

Jika **SEMUA** checklist ✓ tapi register masih error:
- Screenshot full console output
- Screenshot error message di app
- Kirim ke developer

---

## 🔐 Alternative: Regenerate API Key

Jika semua cara gagal, kemungkinan API key bermasalah di sisi Supabase.

1. Login ke [Supabase Dashboard](https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc)
2. Settings > API
3. Cek apakah "anon/public" key masih sama dengan yang di file
4. Jika beda, update semua file dengan key baru

---

## 🆘 Last Resort

Jika SEMUA cara gagal:

1. Stop semua app
2. Restart computer
3. Jalankan `fix_invalid_api_key.bat`
4. Jalankan `run_supabase_verified.bat`
5. Cek console output

---

**Files to use:**
- `run_supabase_verified.bat` ← **USE THIS**
- `fix_invalid_api_key.bat` ← Run if error persists
- `verify_api_key.bat` ← Verify keys match

**DON'T use:**
- ❌ `flutter run` (without --dart-define)
- ❌ VS Code "Mock Mode"
- ❌ Any other command

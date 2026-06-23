# ⚠️ PENTING: Cara Menjalankan App dengan Supabase

## Error "invalid api key"? Baca ini!

Error ini muncul karena app **HARUS dijalankan dengan credentials Supabase**, tapi Anda menjalankannya tanpa credentials.

---

## 🚀 Cara Jalankan dengan Supabase

### 📱 Android/Mobile
**File:** `run_android_supabase.bat`

1. Start Android emulator atau connect physical device
2. Double-click: `run_android_supabase.bat`
3. Atau baca: [RUN_ON_MOBILE.md](RUN_ON_MOBILE.md)

### 🪟 Windows Desktop
**File:** `run_with_supabase.bat`

### Opsi 1: Batch File (PALING MUDAH)**

Double-click file ini:
```
run_with_supabase.bat
```

**JANGAN** jalankan dengan `flutter run` biasa!

---

### **Opsi 2: VS Code**

1. Buka VS Code
2. Tekan `F5` (atau klik Run > Start Debugging)
3. Pilih **"Supabase Mode"** dari dropdown
4. **JANGAN** pilih "Mock Mode"

---

### **Opsi 3: Command Line Manual**

Copy-paste command ini (FULL):

```cmd
flutter run --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

---

## 🔍 Cara Cek Apakah Sudah Benar

Setelah app start, lihat console/terminal. Harus ada:

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

**Jika muncul "MOCK MODE"** = Salah! Credentials tidak ter-load.

---

## ❌ JANGAN Jalankan Seperti Ini:

❌ `flutter run` (tanpa --dart-define)
❌ Pilih "Mock Mode" di VS Code
❌ `run_mock.bat`

Semua cara di atas akan menggunakan **mock mode** (dummy data tanpa backend).

---

## 🧪 Test Register

Setelah yakin Supabase active (cek console output):

1. Klik **"Daftar"**
2. Isi form:
   - Nama: Test User
   - HP: 08123456789
   - Email: test123@example.com (gunakan email unique)
   - Password: password123
3. Submit
4. **Expected:** "Akun berhasil dibuat. Silakan masuk."

**Jika masih error "invalid api key":**
1. Stop app (Ctrl+C)
2. Jalankan `flutter clean`
3. Jalankan ulang dengan `run_with_supabase.bat`

---

## 📚 Dokumentasi Lengkap

- [SUPABASE_INTEGRATION.md](SUPABASE_INTEGRATION.md) - Setup guide
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Error fixes
- [INTEGRATION_CHANGELOG.md](INTEGRATION_CHANGELOG.md) - What was done

---

## 🆘 Masih Error?

Run diagnostic:
```
diagnostic.bat
```

Atau hubungi developer dengan screenshot console output.

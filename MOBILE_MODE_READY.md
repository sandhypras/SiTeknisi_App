# ✅ READY: Menjalankan di Android/Mobile Mode

## 📱 Devices Tersedia di System Anda:

```
✓ Windows (desktop)
✓ Chrome (web)
✓ Edge (web)
```

**Note:** Android emulator belum running. Jika ingin test di Android:

1. Buka Android Studio
2. Device Manager > Start Emulator
3. Atau connect physical Android device via USB

---

## 🚀 Cara Menjalankan (Pilih Salah Satu):

### 1️⃣ Windows Desktop (Recommended untuk Development)
```bash
run_with_supabase.bat
```

### 2️⃣ Chrome/Web
```bash
flutter run -d chrome ^
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

### 3️⃣ Android (Jika emulator sudah running)
```bash
run_android_supabase.bat
```

---

## 🎯 Recommended: VS Code (Paling Mudah)

1. Tekan `F5`
2. Pilih platform:
   - **"Supabase Mode - Windows"** ← Untuk development
   - **"Supabase Mode - Chrome"** ← Untuk web testing
   - **"Supabase Mode - Android"** ← Untuk mobile testing

3. Done! App akan start dengan Supabase active.

---

## 🔍 Cek Log Console

**WAJIB** verifikasi setelah app start:

```
==================================================
SUPABASE CONFIG CHECK
==================================================
URL: ✓ https://rnofcprjnlvfvgwdynmc.supabase.co
Configured: ✓ TRUE

✓ Supabase Integration Active
✓ Ready for production mode
==================================================
```

---

## 🧪 Test Register

Setelah verifikasi Supabase active:

1. Pilih "Daftar"
2. Isi:
   - Nama: Test User
   - HP: 08123456789
   - Email: test@example.com (unique email)
   - Password: password123
3. Submit

**Expected Result:**
```
✅ "Akun berhasil dibuat. Silakan masuk."
```

**Bukan:**
```
❌ "invalid api key"
❌ "Mock register berhasil"
```

---

## 📚 Documentation Files

- `QUICK_REFERENCE.md` - Quick commands
- `RUN_ON_MOBILE.md` - Detailed mobile guide
- `START_HERE.md` - Getting started
- `SUPABASE_INTEGRATION.md` - Integration details

---

## 🎮 Available Batch Files

| File | Purpose |
|------|---------|
| `run_with_supabase.bat` | Run on Windows with Supabase |
| `run_android_supabase.bat` | Run on Android with Supabase |
| `run_mock.bat` | Run without backend (mock data) |
| `list_devices.bat` | Show available devices |
| `diagnostic.bat` | Check system configuration |

---

## 🐛 Troubleshooting

### "invalid api key" di Android
→ Pastikan gunakan `run_android_supabase.bat` atau VS Code "Supabase Mode - Android"

### "No devices found" untuk Android
→ Start Android emulator di Android Studio atau connect physical device

### App lambat di Chrome
→ Gunakan Windows Desktop mode untuk development (lebih cepat)

---

## ✅ Next Steps

1. ✅ **Pilih platform** (Windows recommended)
2. ✅ **Run dengan file .bat yang sesuai**
3. ✅ **Verifikasi Supabase active di console**
4. ✅ **Test register**
5. 🎉 **Success!**

---

**Questions?** Baca [TROUBLESHOOTING.md](TROUBLESHOOTING.md) atau [RUN_ON_MOBILE.md](RUN_ON_MOBILE.md)

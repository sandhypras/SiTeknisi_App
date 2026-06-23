# 📱 Cara Menjalankan di Android/iOS/Chrome (Apps Mode)

## 🎯 Quick Start

### **Cek Device yang Tersedia**
```bash
# Lihat semua device yang connected
list_devices.bat
```

Output akan seperti:
```
Windows (desktop)      • windows   • Microsoft Windows
Chrome (web)           • chrome    • Google Chrome
Android SDK (android)  • emulator-5554 • Android emulator
```

---

## 📱 Android

### **Opsi 1: Batch File (Termudah)**
1. Pastikan Android emulator atau device sudah running
2. Double-click:
   ```
   run_android_supabase.bat
   ```

### **Opsi 2: VS Code**
1. Pastikan Android emulator atau device sudah running
2. Tekan `F5`
3. Pilih **"Supabase Mode - Android"**

### **Opsi 3: Command Line**
```bash
flutter run -d android \
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

### **Setup Android Emulator (jika belum ada)**
1. Buka Android Studio
2. Tools > Device Manager
3. Create Virtual Device
4. Pilih device (misal: Pixel 5)
5. Pilih system image (misal: API 33)
6. Finish > Start emulator

---

## 🌐 Chrome (Web)

### **Opsi 1: VS Code**
1. Tekan `F5`
2. Pilih **"Supabase Mode - Chrome"**

### **Opsi 2: Command Line**
```bash
flutter run -d chrome \
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

---

## 🪟 Windows Desktop

### **Opsi 1: Batch File**
```
run_with_supabase.bat
```

### **Opsi 2: VS Code**
1. Tekan `F5`
2. Pilih **"Supabase Mode - Windows"**

---

## 🍎 iOS (Mac Only)

**Note:** iOS development hanya bisa di macOS.

```bash
flutter run -d ios \
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

---

## 🔍 Verifikasi Koneksi

Setelah app start di device apapun, **WAJIB cek console/log**:

### ✅ BENAR (Supabase Active):
```
==================================================
SUPABASE CONFIG CHECK
==================================================
URL: ✓ https://rnofcprjnlvfvgwdynmc.supabase.co
Configured: ✓ TRUE

✓ Supabase Integration Active
==================================================
```

### ❌ SALAH (Mock Mode):
```
URL: ❌ KOSONG
Configured: ❌ FALSE
⚠️  APP RUNNING IN MOCK MODE
```

**Jika muncul MOCK MODE** = ulangi dengan command yang benar!

---

## 📱 Cara Lihat Log di Android

### **Dari VS Code:**
Log otomatis muncul di Debug Console

### **Dari Command Line:**
Log otomatis muncul di terminal

### **Atau gunakan Android Studio:**
1. Buka Android Studio
2. View > Tool Windows > Logcat
3. Filter: `flutter`
4. Cari output "SUPABASE CONFIG CHECK"

---

## 🧪 Test Register di Mobile

1. Pastikan console log menunjukkan "Supabase Integration Active"
2. Buka app di mobile device
3. Tap "Daftar"
4. Isi form:
   - Nama: Test Mobile
   - HP: 08123456789
   - Email: mobile123@example.com
   - Password: password123
5. Tap "Buat Akun"
6. Expected: **"Akun berhasil dibuat. Silakan masuk."**

---

## 🐛 Troubleshooting

### Error: "No devices found"
**Solusi:**
```bash
# Cek device
flutter devices

# Jika kosong, start emulator atau connect physical device
```

### Error: "invalid api key" di Android
**Penyebab:** App di-run tanpa `--dart-define`

**Solusi:**
1. Stop app
2. Gunakan `run_android_supabase.bat`
3. Atau gunakan VS Code dengan "Supabase Mode - Android"

### Error: "Gradle build failed"
**Solusi:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
# Run ulang
```

### App lambat di emulator
**Solusi:**
- Gunakan emulator dengan hardware acceleration
- Atau test di physical device (lebih cepat)

### Chrome CORS error
**Solusi:**
- Supabase sudah configure CORS otomatis
- Jika masih error, cek Supabase Dashboard > Settings > API > CORS

---

## 📊 Perbandingan Platform

| Platform | Kecepatan | Hot Reload | Recommended For |
|----------|-----------|------------|-----------------|
| Windows Desktop | ⚡⚡⚡ | ✅ Sangat cepat | Development |
| Android Emulator | ⚡⚡ | ✅ Cepat | Testing |
| Physical Device | ⚡⚡⚡ | ✅ Cepat | Real Testing |
| Chrome | ⚡⚡ | ✅ Cepat | Web Testing |
| iOS | ⚡⚡ | ✅ Cepat | iOS Testing |

---

## 🎯 Recommended Workflow

### Development:
1. Kode di Windows Desktop (tercepat)
2. Hot reload untuk test changes

### Testing:
1. Build di Android emulator
2. Test UI/UX di mobile form factor
3. Test di physical device untuk performance real

### Production:
```bash
# Android APK
flutter build apk --release \
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJ...

# APK location: build/app/outputs/flutter-apk/app-release.apk
```

---

## 📚 Files Reference

- `run_android_supabase.bat` - Run Android dengan Supabase
- `run_with_supabase.bat` - Run Windows dengan Supabase
- `list_devices.bat` - Cek devices yang tersedia
- `.vscode/launch.json` - VS Code configurations

---

## 🆘 Need Help?

1. Run `list_devices.bat` - Screenshot output
2. Run app - Screenshot console log
3. Screenshot error (jika ada)
4. Baca [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

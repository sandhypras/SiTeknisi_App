# 🎯 QUICK REFERENCE - Menjalankan App

## 📱 Pilih Platform

| Platform | File to Run | VS Code Config |
|----------|-------------|----------------|
| 📱 **Android** | `run_android_supabase.bat` | "Supabase Mode - Android" |
| 🪟 **Windows** | `run_with_supabase.bat` | "Supabase Mode - Windows" |
| 🌐 **Chrome** | Manual (see below) | "Supabase Mode - Chrome" |
| 🎭 **Mock Mode** | `run_mock.bat` | "Mock Mode (No Supabase)" |

---

## ⚡ Super Quick Start

### Android:
```bash
run_android_supabase.bat
```

### Windows:
```bash
run_with_supabase.bat
```

### Cek Devices:
```bash
list_devices.bat
```

---

## 🔍 Verifikasi (WAJIB CEK!)

Setelah app start, **HARUS** muncul di console:

```
✓ Supabase Integration Active  <-- HARUS INI!
```

**Jika muncul "MOCK MODE"** = SALAH! Ulangi dengan file yang benar.

---

## 🧪 Test Register

1. Email: `test@example.com`
2. Password: `password123`
3. Expected: ✅ "Akun berhasil dibuat"

---

## 📚 Full Docs

- [RUN_ON_MOBILE.md](RUN_ON_MOBILE.md) - Mobile/Android/iOS
- [START_HERE.md](START_HERE.md) - General guide
- [SUPABASE_INTEGRATION.md](SUPABASE_INTEGRATION.md) - Setup details
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Fix errors

---

## 🆘 Common Issues

### "invalid api key"
→ Jalankan dengan `run_android_supabase.bat` atau `run_with_supabase.bat`

### "No devices found"
→ Jalankan `list_devices.bat` untuk cek

### App masih Mock Mode
→ Stop app, run ulang dengan file .bat yang benar

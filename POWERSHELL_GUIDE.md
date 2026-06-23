# 🚀 CARA JALANKAN di PowerShell

## ⚠️ Anda Menggunakan PowerShell

Di PowerShell, cara menjalankan batch file berbeda:

### ❌ SALAH:
```powershell
run_supabase_verified.bat
```

### ✅ BENAR (Pilih Salah Satu):

#### **Opsi 1: Gunakan PowerShell Script (RECOMMENDED)**

1. **Fix dulu:**
   ```powershell
   .\fix_api_key.ps1
   ```

2. **Lalu jalankan:**
   ```powershell
   .\run_supabase.ps1
   ```

---

#### **Opsi 2: Jalankan Batch File dengan cara PowerShell**

```powershell
.\run_supabase_verified.bat
```
(Perhatikan `.\` di depan!)

---

#### **Opsi 3: Buka Command Prompt, bukan PowerShell**

1. Tekan `Win + R`
2. Ketik: `cmd`
3. Enter
4. Di Command Prompt:
   ```cmd
   cd d:\siteknisi_apps
   run_supabase_verified.bat
   ```

---

#### **Opsi 4: Copy-Paste Command Langsung**

Langsung copy-paste command ini ke PowerShell:

```powershell
flutter run --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

---

## 🎯 RECOMMENDED: Gunakan PowerShell Scripts

### **Step 1: Fix (sekali saja)**
```powershell
.\fix_api_key.ps1
```

### **Step 2: Run**
```powershell
.\run_supabase.ps1
```

### **Step 3: Cek Console**
HARUS muncul:
```
✓ Supabase Integration Active
```

---

## 🔒 Jika Ada Error "Execution Policy"

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Lalu jalankan ulang `.\run_supabase.ps1`

---

## 📱 Untuk Android

```powershell
.\run_android_supabase.bat
```

Atau gunakan script PS1:
```powershell
flutter run -d android --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

---

## 🎮 Summary

| File | Cara Run di PowerShell |
|------|------------------------|
| `fix_api_key.ps1` | `.\fix_api_key.ps1` |
| `run_supabase.ps1` | `.\run_supabase.ps1` |
| Any `.bat` file | `.\filename.bat` |

---

## ✅ Quick Start (Copy-Paste Ready)

1. **Clean & Fix:**
   ```powershell
   .\fix_api_key.ps1
   ```

2. **Run App:**
   ```powershell
   .\run_supabase.ps1
   ```

3. **Check Console:**
   Look for: `✓ Supabase Integration Active`

4. **Test Register:**
   - Email: `test@example.com`
   - Password: `password123`

---

**Sekarang jalankan: `.\run_supabase.ps1`**

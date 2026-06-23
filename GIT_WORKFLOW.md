# 🔄 GIT WORKFLOW GUIDE - Push & Pull Changes

## 📍 Status Saat Ini

Branch: `dev`
Ahead of origin: 7 commits
Modified files: 15
New files: 29

---

## 🚀 PUSH PERUBAHAN KE BRANCH DEV

### Step 1: Review Perubahan

```bash
git status
```

### Step 2: Add Semua Perubahan

```bash
# Add semua file yang modified dan new
git add .

# Atau add specific files
git add lib/ docs/ *.md *.bat *.ps1
```

### Step 3: Commit dengan Message yang Jelas

```bash
git commit -m "feat: integrate Supabase auth, add logout, create documentation

- Implement Supabase authentication (register, login, logout)
- Add customer profile logout functionality
- Fix routing for mobile/web mode
- Create comprehensive documentation (TROUBLESHOOTING, INTEGRATION_CHANGELOG, etc)
- Add PowerShell and batch scripts for easy running
- Create feature checklist and implementation roadmap
- Update .gitignore to protect API keys
"
```

### Step 4: Push ke Branch Dev

```bash
git push origin dev
```

**Jika ada conflict:**
```bash
# Pull dulu, resolve conflict, lalu push
git pull origin dev --rebase
# Fix conflicts if any
git add .
git rebase --continue
git push origin dev
```

---

## 📥 CARA TEMAN PULL PERUBAHAN TERBARU

### Opsi 1: Clone Fresh (Jika Belum Ada Repo)

```bash
# Clone repository
git clone <repository-url>

# Masuk ke folder
cd siteknisi_apps

# Checkout ke branch dev
git checkout dev

# Install dependencies
flutter pub get
```

---

### Opsi 2: Pull Update (Jika Sudah Ada Repo)

#### A. Pull di Branch yang Sama

```bash
# Pastikan di branch dev
git checkout dev

# Pull perubahan terbaru
git pull origin dev

# Install dependencies baru (jika ada)
flutter pub get

# Clean build cache
flutter clean
```

#### B. Pull dengan Stash (Jika Ada Local Changes)

```bash
# Simpan perubahan lokal dulu
git stash

# Pull perubahan terbaru
git pull origin dev

# Kembalikan perubahan lokal
git stash pop

# Resolve conflicts if any
```

#### C. Pull dengan Merge

```bash
# Pull dan merge otomatis
git pull origin dev

# Jika ada conflict, resolve manual
# Edit file yang conflict
# Lalu:
git add <resolved-files>
git commit -m "merge: resolve conflicts"
```

---

## 🔍 CEK STATUS SETELAH PULL

```bash
# Cek status
git status

# Cek log commits
git log --oneline -10

# Cek branch
git branch -a
```

---

## ⚙️ SETUP AWAL UNTUK TEMAN

Setelah pull perubahan terbaru, teman Anda harus:

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Cek Devices Available

```bash
flutter devices
```

### 3. Run App

#### Mock Mode (Tanpa Supabase):
```bash
run_mock.bat
```

#### Supabase Mode:
```bash
run_with_supabase.bat
```

#### Android Mode:
```bash
run_android_supabase.bat
```

### 4. Baca Dokumentasi

- `START_HERE.md` - Quick start guide
- `TROUBLESHOOTING.md` - Troubleshooting
- `SUPABASE_INTEGRATION.md` - Supabase setup
- `FEATURE_CHECKLIST.md` - Feature status
- `IMPLEMENTATION_ROADMAP.md` - Development roadmap

---

## 📋 CHECKLIST UNTUK TEMAN

Setelah pull:

- [ ] `git pull origin dev` berhasil
- [ ] `flutter pub get` berhasil
- [ ] `flutter devices` show devices
- [ ] Baca `START_HERE.md`
- [ ] Run dengan `run_with_supabase.bat` atau `run_mock.bat`
- [ ] App jalan tanpa error
- [ ] Cek console untuk "Supabase Integration Active" atau "Mock Mode"
- [ ] Test register/login

---

## 🔐 SHARING CREDENTIALS

**JANGAN commit credentials ke Git!**

Cara berbagi credentials dengan teman:

### Opsi 1: Share via Secure Channel

Kirim via WhatsApp/Discord/Slack (private):
```
SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co
SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
```

Teman copy ke file `.env` (yang di-gitignore):
```bash
# Create .env file
echo SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co > .env
echo SUPABASE_PUBLISHABLE_KEY=eyJ... >> .env
```

### Opsi 2: Share .vscode/launch.json

File ini sudah ada credentials, tapi di-gitignore.
Kirim file secara private ke teman.

### Opsi 3: Share Batch Files

Karena batch files sudah ada credentials, teman bisa langsung run:
```bash
run_with_supabase.bat
```

---

## 🐛 TROUBLESHOOTING UNTUK TEMAN

### Error: "merge conflict"

```bash
# Cek file yang conflict
git status

# Edit file manually, cari:
<<<<<<< HEAD
=======
>>>>>>> origin/dev

# Setelah fix:
git add .
git commit -m "fix: resolve merge conflict"
```

### Error: "Your local changes would be overwritten"

```bash
# Opsi 1: Stash dulu
git stash
git pull origin dev
git stash pop

# Opsi 2: Commit dulu
git add .
git commit -m "wip: local changes"
git pull origin dev
```

### Error: "flutter pub get failed"

```bash
# Clean dulu
flutter clean
rm -rf .dart_tool/
flutter pub get
```

### Error: "invalid api key"

Baca file: `EMERGENCY_FIX.md` atau `TROUBLESHOOTING.md`

---

## 📊 WORKFLOW SUMMARY

### Anda (Push):
1. `git add .`
2. `git commit -m "message"`
3. `git push origin dev`

### Teman (Pull):
1. `git checkout dev`
2. `git pull origin dev`
3. `flutter pub get`
4. `run_with_supabase.bat`

---

## 🔄 BEST PRACTICES

### Before Push:
- [ ] Test app locally
- [ ] Run `flutter analyze`
- [ ] Check no sensitive data in files
- [ ] Write clear commit message

### Before Pull:
- [ ] Commit or stash local changes
- [ ] Backup important files
- [ ] Note current working branch

### After Pull:
- [ ] Run `flutter pub get`
- [ ] Run `flutter clean` if errors
- [ ] Test app
- [ ] Read changelog/documentation

---

## 📞 COMMUNICATION WITH TEAM

Setelah push, beritahu teman:

```
✅ PUSHED TO DEV BRANCH

Changes:
- Supabase auth integration
- Customer logout functionality
- Documentation & troubleshooting guides
- Run scripts (.bat & .ps1 files)

To update:
1. git pull origin dev
2. flutter pub get
3. Read START_HERE.md
4. Run: run_with_supabase.bat

Supabase credentials: (kirim private)
```

---

**Ready to push? Run:**
```bash
git add .
git commit -m "feat: supabase integration and documentation"
git push origin dev
```

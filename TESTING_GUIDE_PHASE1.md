# 🧪 TESTING GUIDE - Phase 1: Service Request

## ✅ Backend Ready

### Database Status:
- ✅ Services table seeded with 6 services
- ✅ service_requests table ready
- ✅ Storage bucket `request-photos` configured
- ✅ RLS policies active
- ✅ ServiceMapper implemented for ID mapping

---

## 🎯 Test Scenarios

### Test 1: Complete Service Request Flow (Happy Path)

#### Prerequisites:
```bash
git checkout feature/customer-service-request
git pull origin feature/customer-service-request
flutter pub get
flutter clean
run_with_supabase.bat
```

#### Steps:
1. **Launch App**
   - Should see Splash screen
   - Auto-navigate to Customer Home

2. **Register/Login**
   - If not logged in, click "Daftar"
   - Email: `test_phase1@example.com`
   - Password: `password123`
   - Name: Test User Phase 1
   - Phone: 08123456789
   - Submit registration
   - Should see "Akun berhasil dibuat"
   - Login with same credentials

3. **Browse Services**
   - Should see 3 categories: Printer, Komputer, Laptop
   - Click "Printer" category
   - Should see 2 services:
     - Servis Printer (Rp 150.000)
     - Perawatan Printer (Rp 120.000)

4. **Select Service**
   - Click "Servis Printer"
   - Should see service detail screen
   - Click "Request Servis" button

5. **Fill Service Request Form**
   - **Lokasi Servis:** `Jl. Sudirman No. 123, Jakarta Selatan`
   - **Jadwal Kunjungan:** `Besok, 10:00 AM` (optional)
   - **Deskripsi Masalah:** `Printer tidak bisa menarik kertas, hasil cetak buram dan ada suara aneh dari dalam`
   - **Foto Kerusakan:** Upload image (optional but recommended)

6. **Submit Request**
   - Click "Kirim Request"
   - Should show loading indicator
   - If photo selected, should upload to Storage
   - Should create record in database
   - Should show success message: "Permintaan servis berhasil dibuat!"
   - Should navigate to success screen

#### Expected Results:
✅ No errors in console
✅ Success message displayed
✅ Navigation to success screen works

#### Verify in Database:
1. Open Supabase Dashboard:
   https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc/editor

2. Go to Table Editor > `service_requests`

3. Check latest record:
   ```sql
   SELECT 
     sr.id,
     sr.title,
     sr.description,
     sr.address,
     sr.status,
     sr.photo_url,
     sr.created_at,
     p.full_name as customer_name,
     s.name as service_name
   FROM service_requests sr
   JOIN profiles p ON p.id = sr.customer_id
   JOIN services s ON s.id = sr.service_id
   ORDER BY sr.created_at DESC
   LIMIT 1;
   ```

   Expected:
   - ✅ customer_id = your user ID
   - ✅ service_id = UUID (not string)
   - ✅ title = "Servis Printer"
   - ✅ description = your input
   - ✅ address = your location
   - ✅ status = 'open'
   - ✅ photo_url = Storage URL (if uploaded)
   - ✅ created_at = now

4. If photo uploaded, check Storage:
   - Go to Storage > `request-photos`
   - Should see: `{user_id}/{timestamp}.jpg`
   - Click file > Should preview image

---

### Test 2: Form Validation

#### Test 2a: Empty Location
1. Fill form but leave Location empty
2. Click "Kirim Request"
3. Expected: ❌ "Lokasi servis harus diisi"

#### Test 2b: Empty Description
1. Fill Location only
2. Click "Kirim Request"
3. Expected: ❌ "Deskripsi masalah harus diisi"

#### Test 2c: Short Description
1. Fill Location: "Jl. Test"
2. Fill Description: "rusak" (< 10 chars)
3. Click "Kirim Request"
4. Expected: ❌ "Deskripsi minimal 10 karakter"

#### Test 2d: All Valid
1. Fill all required fields correctly
2. Click "Kirim Request"
3. Expected: ✅ Submit successful

---

### Test 3: Photo Upload

#### Test 3a: Small Image (< 5MB)
1. Select image from gallery
2. Should show preview
3. Submit form
4. Expected: ✅ Upload successful, URL in database

#### Test 3b: Without Photo
1. Don't select any photo
2. Submit form
3. Expected: ✅ Submit successful, photo_url = null

#### Test 3c: Large Image (> 5MB) - Manual Test
1. Select very large image
2. Expected: Should handle gracefully (may take time)

---

### Test 4: Authentication Guard

#### Test 4a: Guest User
1. Logout if logged in
2. Browse to service detail
3. Click "Request Servis"
4. Fill form and submit
5. Expected: Should prompt to login first
6. After login, should return to form

---

### Test 5: Error Scenarios

#### Test 5a: Network Error
1. Disconnect internet
2. Fill form and submit
3. Expected: ❌ Error message about network

#### Test 5b: Invalid Service ID
1. Manually navigate to: `/customer/request/invalid-id`
2. Fill form and submit
3. Expected: ❌ "Layanan tidak ditemukan di database"

#### Test 5c: Database Error (Simulate)
1. Temporarily remove Supabase URL from config
2. Fill form and submit
3. Expected: ❌ Error message

---

## 📊 Test Results Template

Copy and fill this:

```markdown
## Test Execution Report
Date: __________
Tester: __________
Branch: feature/customer-service-request
Commit: e142820

### Test 1: Happy Path
- [ ] App launched successfully
- [ ] Registration/Login works
- [ ] Service browsing works
- [ ] Form displays correctly
- [ ] All fields editable
- [ ] Photo upload works
- [ ] Submit successful
- [ ] Data in database ✓
- [ ] Photo in storage ✓
- [ ] Navigation works

**Issues Found:** _________

### Test 2: Form Validation
- [ ] Empty location shows error
- [ ] Empty description shows error
- [ ] Short description shows error
- [ ] Valid submission works

**Issues Found:** _________

### Test 3: Photo Upload
- [ ] Photo selection works
- [ ] Preview displays
- [ ] Upload to storage works
- [ ] Without photo works

**Issues Found:** _________

### Test 4: Authentication
- [ ] Guest prompted to login
- [ ] Return after login works

**Issues Found:** _________

### Test 5: Error Handling
- [ ] Network error handled
- [ ] Invalid service handled
- [ ] User-friendly messages

**Issues Found:** _________

## Summary
**PASS: ___ / 24**
**FAIL: ___ / 24**

**Overall Status:** [ ] PASS [ ] FAIL

**Notes:**
___________________
```

---

## 🐛 Known Issues to Watch

1. **Service ID Mapping**
   - If services not seeded, will show error
   - Solution: Run `supabase db push` to apply migration

2. **Storage Upload Timeout**
   - Large images may timeout
   - Solution: Implement image compression

3. **Date/Time Picker**
   - Currently just text input
   - TODO: Implement proper date picker

4. **Location Picker**
   - Currently just text input
   - TODO: Implement map picker

---

## 🔍 Debugging Tips

### Check Console Logs:
```
📝 Creating service request...
✅ Service request created: {uuid}
```

### If Error "Layanan tidak ditemukan":
```bash
# Check if services seeded
supabase db query "SELECT * FROM services;"

# Should return 6 services
# If empty, run:
supabase db push
```

### If Error "User not authenticated":
- Check console for "SUPABASE CONFIG CHECK"
- Should show "Configured: ✓ TRUE"
- If FALSE, restart with run_with_supabase.bat

### If Upload Fails:
```bash
# Check storage bucket exists
# Dashboard > Storage > request-photos should exist

# Check RLS policies
# Dashboard > Storage > request-photos > Policies
# Should have insert policy for authenticated users
```

---

## ✅ Success Criteria

Phase 1 is considered COMPLETE when:

- [x] Backend setup (services seeded)
- [ ] Happy path test passes
- [ ] Form validation works
- [ ] Photo upload works
- [ ] Data persists in database
- [ ] No console errors
- [ ] User gets clear feedback
- [ ] Error cases handled gracefully

---

## 📸 Screenshots to Capture

For documentation:
1. Service list screen
2. Create request form (filled)
3. Photo upload preview
4. Loading state
5. Success message
6. Database record in Supabase
7. Uploaded photo in Storage

---

## 🚀 After Testing

### If All Tests Pass:
```bash
# Update commit
git add .
git commit -m "test: phase 1 complete, all tests passing"
git push origin feature/customer-service-request

# Create Pull Request
# Or merge to dev
git checkout dev
git merge feature/customer-service-request
git push origin dev
```

### If Tests Fail:
1. Document issues found
2. Create GitHub issues
3. Fix bugs
4. Re-test
5. Update test results

---

**START TESTING NOW!**

Run: `run_with_supabase.bat` and follow Test 1 steps.

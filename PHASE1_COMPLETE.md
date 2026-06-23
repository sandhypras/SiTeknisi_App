# ✅ FASE 1 COMPLETE: Customer Service Request

Branch: `feature/customer-service-request`
Commit: `0104bb3`

---

## 🎯 What Was Implemented

### 1. Service Request Repository ✅
**File:** `lib/features/customer/data/service_request_repository.dart`

Features:
- ✅ Create service request with all fields
- ✅ Get request by ID
- ✅ Get all requests by customer
- ✅ Update request status
- ✅ Delete request
- ✅ Get open requests (for technician view)

Model:
- ServiceRequest with complete fields
- fromJson/toJson methods
- ServiceRequestException for errors

### 2. Storage Service ✅
**File:** `lib/core/utils/storage_service.dart`

Features:
- ✅ Upload request photo to `request-photos` bucket
- ✅ Upload technician documents
- ✅ Delete files from storage
- ✅ Content-type detection
- ✅ Image validation (size & extension)

### 3. Riverpod Providers ✅
**File:** `lib/features/customer/presentation/providers/service_request_providers.dart`

Providers:
- ✅ serviceRequestRepositoryProvider
- ✅ storageServiceProvider
- ✅ serviceRequestLoadingProvider
- ✅ serviceRequestErrorProvider
- ✅ customerServiceRequestsProvider (FutureProvider)

### 4. Create Service Request Screen ✅
**File:** `lib/features/customer/presentation/screens/booking/create_service_request_screen.dart`

Updates:
- ✅ Form with GlobalKey for validation
- ✅ TextEditingControllers for all fields
- ✅ Field validation (location, description required)
- ✅ Photo upload integration
- ✅ Database save on submit
- ✅ Loading state during submission
- ✅ Error handling with user-friendly messages
- ✅ Success navigation to RequestSuccessScreen

---

## 🧪 How to Test

### Prerequisites:
1. Run app with Supabase:
   ```bash
   run_with_supabase.bat
   ```

2. Login/Register sebagai customer

### Test Steps:

#### 1. Navigate to Create Request
- Open app
- Browse service categories
- Select a service (misal: "Servis Printer")
- Click "Request Servis"

#### 2. Fill Form
- **Lokasi Servis:** Jl. Merdeka No. 12, Bandung
- **Jadwal Kunjungan:** Hari ini, 14:00 (optional)
- **Deskripsi Masalah:** Printer tidak menarik kertas, hasil cetak buram
- **Foto:** Upload foto kerusakan (optional)

#### 3. Submit Request
- Click "Kirim Request"
- Should show loading indicator
- Should upload photo (if provided)
- Should save to database
- Should show success message
- Should navigate to success screen

#### 4. Verify in Database
1. Open Supabase Dashboard:
   https://supabase.com/dashboard/project/rnofcprjnlvfvgwdynmc/editor

2. Go to Table Editor > `service_requests`

3. Check latest record:
   - ✅ customer_id = your user ID
   - ✅ service_id = selected service
   - ✅ title = service title
   - ✅ description = your input
   - ✅ address = your location
   - ✅ photo_url = Storage URL (if uploaded)
   - ✅ status = 'open'
   - ✅ created_at = now

4. If photo uploaded, check Storage:
   - Go to Storage > `request-photos`
   - Should see uploaded photo with path: `{user_id}/{timestamp}.jpg`

---

## ✅ Success Criteria

### Form Validation:
- [ ] Empty location shows error "Lokasi servis harus diisi"
- [ ] Empty description shows error "Deskripsi masalah harus diisi"
- [ ] Description < 10 chars shows error "Deskripsi minimal 10 karakter"
- [ ] Cannot submit with validation errors

### Photo Upload:
- [ ] Can select photo from gallery/camera
- [ ] Preview shows selected photo
- [ ] Photo uploads to Storage
- [ ] photoUrl saved to database
- [ ] Large files (>5MB) show error

### Database Save:
- [ ] Request saved with correct customer_id
- [ ] All form fields saved correctly
- [ ] Status set to 'open'
- [ ] Timestamps auto-populated

### User Feedback:
- [ ] Loading indicator during submit
- [ ] Success message after save
- [ ] Error message if fails
- [ ] Navigation to success screen

---

## 🐛 Known Issues & Limitations

### Not Implemented Yet:
- ⏳ Schedule date/time picker (currently just text input)
- ⏳ Location picker with map
- ⏳ Success screen doesn't show request details yet
- ⏳ Request listing in customer profile
- ⏳ Real-time updates

### Edge Cases to Test:
- Network timeout during upload
- Very large image files
- Invalid image formats
- Concurrent requests

---

## 📊 Database Schema

```sql
-- service_requests table
CREATE TABLE service_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL REFERENCES profiles(id),
  service_id UUID NOT NULL REFERENCES services(id),
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  address TEXT NOT NULL,
  latitude NUMERIC(10, 7),
  longitude NUMERIC(10, 7),
  photo_url TEXT,
  preferred_schedule TIMESTAMPTZ,
  status request_status NOT NULL DEFAULT 'open',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### Status Values:
- `draft` - Not submitted yet
- `open` - Waiting for offers
- `offered` - Has offers from technicians
- `booked` - Accepted an offer
- `in_progress` - Technician working
- `completed` - Work finished
- `cancelled` - Cancelled by customer

---

## 🔐 Security

### RLS Policies:
From migration `20260622083100_basic_rls.sql`:

```sql
-- Customers can insert their own requests
CREATE POLICY requests_customer_insert 
ON service_requests FOR INSERT 
WITH CHECK (auth.uid() = customer_id);

-- Customers can read their own requests
CREATE POLICY requests_customer_select 
ON service_requests FOR SELECT 
USING (auth.uid() = customer_id);

-- Technicians can read open requests
CREATE POLICY requests_technician_select 
ON service_requests FOR SELECT 
USING (is_technician() AND status = 'open');
```

### Storage Policies:
From migration `20260622083200_auth_foundation.sql`:

```sql
-- request-photos bucket policies:
- Owner can upload (customer)
- Owner or admin can view
- Owner can delete
```

---

## 🚀 Next Steps

### Immediate (Same Branch):
1. Update RequestSuccessScreen to show request ID & details
2. Add request listing in customer profile/activity
3. Add ability to view request details

### Future Phases:
4. Phase 2: Technician can view requests & send offers
5. Phase 3: Customer view offers & accept
6. Phase 4: Booking & payment
7. Phase 5: Status tracking & reviews

---

## 📝 Testing Checklist

Before merging to dev:

- [ ] Test without photo upload
- [ ] Test with photo upload (< 5MB)
- [ ] Test with large photo (should show error)
- [ ] Test form validation (all cases)
- [ ] Test with guest user (should prompt login)
- [ ] Test with logged in customer
- [ ] Verify data in Supabase Dashboard
- [ ] Verify photo in Storage
- [ ] Test error scenarios
- [ ] Check console for errors

---

## 🔄 Merge to Dev

When ready:

```bash
# Push feature branch
git push origin feature/customer-service-request

# Create Pull Request on GitHub
# Or merge locally:
git checkout dev
git merge feature/customer-service-request
git push origin dev
```

---

**Status: ✅ READY FOR TESTING**

Test the feature and report any bugs before merging!

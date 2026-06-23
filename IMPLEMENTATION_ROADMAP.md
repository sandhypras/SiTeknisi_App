# 🗺️ IMPLEMENTATION ROADMAP

## Progress Saat Ini: 27.5% Complete

Berdasarkan PRD, berikut roadmap lengkap untuk mencapai MVP fungsional.

---

## 📍 Current Status

### ✅ Yang Sudah Selesai:
- Authentication (Register, Login, Logout)
- Customer UI (Home, Categories, Services, Request Form)
- Technician UI (Join, Application Form)
- Database Schema & Migrations
- Supabase Integration Setup
- Router & Navigation
- Design System

### ⚠️ Yang Masih Kurang:
- **Database CRUD operations** (service_requests, offers, bookings, payments, invoices)
- **File upload ke Storage**
- **Payment integration (Midtrans)**
- **Admin dashboard**
- **Realtime updates**

---

## 🎯 FASE 1: Customer Service Request (Week 1-2)

**Goal:** Customer bisa submit service request dan tersimpan di database.

### Tasks:
1. **Create Service Request Repository**
   - [ ] `lib/features/customer/data/service_request_repository.dart`
   - [ ] CRUD methods (create, read, update, delete)
   - [ ] Error handling

2. **Image Upload to Storage**
   - [ ] `lib/core/utils/storage_service.dart`
   - [ ] Upload ke bucket `request-photos`
   - [ ] Get public URL
   - [ ] Delete file

3. **Connect Form to Database**
   - [ ] Update `create_service_request_screen.dart`
   - [ ] Add form validation
   - [ ] Save to `service_requests` table
   - [ ] Upload foto kerusakan
   - [ ] Show loading state

4. **Success Screen Integration**
   - [ ] Update `RequestSuccessScreen`
   - [ ] Show request ID & details
   - [ ] Navigate to request tracking

### Deliverable:
✅ Customer dapat submit request dan data tersimpan di database
✅ Foto terupload ke Storage

**Estimasi:** 3-5 hari

---

## 🎯 FASE 2: Technician Application & Verification (Week 2-3)

**Goal:** Teknisi bisa submit aplikasi dan Admin bisa verifikasi.

### Tasks:
1. **Technician Application Repository**
   - [ ] `lib/features/technician/data/technician_application_repository.dart`
   - [ ] Submit application method
   - [ ] Get application status
   - [ ] Update profile

2. **Document Upload**
   - [ ] Upload KTP ke `technician-documents`
   - [ ] Upload foto profil ke `avatars`
   - [ ] Preview before upload

3. **Connect Application Form**
   - [ ] Update technician form screens
   - [ ] Save to `technician_applications`
   - [ ] Show verification status

4. **Admin Login & Dashboard**
   - [ ] Admin login screen
   - [ ] Admin dashboard overview
   - [ ] List pending applications
   - [ ] View application details (KTP, foto, data)

5. **Admin Verification**
   - [ ] Approve/reject application
   - [ ] Update `technician_applications.status`
   - [ ] Send notification to Teknisi

### Deliverable:
✅ Teknisi bisa submit aplikasi dengan dokumen
✅ Admin bisa login dan verifikasi aplikasi

**Estimasi:** 4-6 hari

---

## 🎯 FASE 3: Technician Dashboard & Offers (Week 3-4)

**Goal:** Teknisi bisa lihat service requests dan kirim offers.

### Tasks:
1. **Service Request Repository (Read)**
   - [ ] Get all open requests
   - [ ] Filter by location/category
   - [ ] Get request details

2. **Technician Dashboard**
   - [ ] List available service requests
   - [ ] Filter & search
   - [ ] View request detail

3. **Service Offer Repository**
   - [ ] Create offer method
   - [ ] Get offers by technician
   - [ ] Update offer status

4. **Create Offer Form**
   - [ ] Offer form screen
   - [ ] Input price & message
   - [ ] Submit offer to database
   - [ ] Success confirmation

### Deliverable:
✅ Teknisi bisa lihat service requests
✅ Teknisi bisa kirim offers dengan harga

**Estimasi:** 3-4 hari

---

## 🎯 FASE 4: Customer View & Accept Offers (Week 4-5)

**Goal:** Customer bisa lihat offers dan pilih teknisi.

### Tasks:
1. **Offers List for Customer**
   - [ ] Get offers by request_id
   - [ ] Sort by price/rating
   - [ ] Show technician details

2. **Offer Comparison Screen**
   - [ ] Compare multiple offers
   - [ ] Show price, rating, reviews
   - [ ] Technician profile link

3. **Accept Offer & Create Booking**
   - [ ] Booking repository
   - [ ] Accept offer button
   - [ ] Create booking record
   - [ ] Update request status to 'booked'
   - [ ] Update offer status to 'accepted'

### Deliverable:
✅ Customer bisa lihat offers dari teknisi
✅ Customer bisa accept offer dan booking terbuat

**Estimasi:** 3-4 hari

---

## 🎯 FASE 5: Payment Integration (Week 5-6)

**Goal:** Customer bisa bayar via Midtrans dan invoice otomatis.

### Tasks:
1. **Midtrans Setup**
   - [ ] Register Midtrans account (sandbox)
   - [ ] Get Server Key & Client Key
   - [ ] Add Midtrans Flutter SDK

2. **Payment Repository**
   - [ ] Create payment record
   - [ ] Create Midtrans transaction
   - [ ] Get payment token

3. **Payment Screen**
   - [ ] Show booking summary
   - [ ] Show total amount
   - [ ] Open Midtrans payment page
   - [ ] Handle payment result

4. **Payment Callback Handler**
   - [ ] Supabase Edge Function for webhook
   - [ ] Verify Midtrans signature
   - [ ] Update payment status
   - [ ] Update booking status

5. **Invoice Auto-Generate**
   - [ ] Create invoice after payment success
   - [ ] Generate invoice number
   - [ ] Calculate commission (10%)
   - [ ] Save to `invoices` table

6. **Invoice View**
   - [ ] Invoice detail screen
   - [ ] Show all payment details
   - [ ] Download/share invoice (PDF)

### Deliverable:
✅ Customer bisa bayar via Midtrans
✅ Invoice otomatis dibuat setelah payment
✅ Komisi platform dihitung

**Estimasi:** 5-7 hari

---

## 🎯 FASE 6: Status Tracking & Updates (Week 6-7)

**Goal:** Teknisi update status, Customer bisa tracking.

### Tasks:
1. **Update Booking Status**
   - [ ] Teknisi update status to 'in_progress'
   - [ ] Teknisi update status to 'completed'
   - [ ] Upload foto hasil pekerjaan (optional)

2. **Booking Tracking Screen**
   - [ ] Show current status
   - [ ] Timeline view
   - [ ] Technician contact info

3. **Realtime Updates**
   - [ ] Subscribe to booking changes
   - [ ] Show notification when status changes
   - [ ] Auto-refresh status

4. **Push Notifications (Optional)**
   - [ ] Firebase setup
   - [ ] Send notification on status change
   - [ ] Send notification on new offer

### Deliverable:
✅ Status booking bisa diupdate teknisi
✅ Customer bisa tracking realtime

**Estimasi:** 3-4 hari

---

## 🎯 FASE 7: History & Review (Week 7-8)

**Goal:** Customer bisa lihat history dan kasih review.

### Tasks:
1. **Booking History**
   - [ ] Get bookings by customer
   - [ ] Filter by status
   - [ ] View booking details

2. **Invoice History**
   - [ ] Get invoices by customer
   - [ ] View invoice details
   - [ ] Download invoice

3. **Rating & Review**
   - [ ] Review form screen
   - [ ] Submit rating (1-5 stars)
   - [ ] Submit review text
   - [ ] Save to `reviews` table

4. **Display Reviews**
   - [ ] Show reviews on technician profile
   - [ ] Calculate average rating
   - [ ] Show review count

### Deliverable:
✅ Customer bisa lihat history booking & invoice
✅ Customer bisa kasih rating & review

**Estimasi:** 3-4 hari

---

## 🎯 FASE 8: Admin Monitoring & Management (Week 8-9)

**Goal:** Admin bisa monitor semua aktivitas platform.

### Tasks:
1. **Admin Dashboard Statistics**
   - [ ] Total users (customer, technician, pending)
   - [ ] Total bookings (by status)
   - [ ] Total revenue
   - [ ] Charts & graphs

2. **Service Management**
   - [ ] CRUD kategori layanan
   - [ ] Upload icon layanan
   - [ ] Set base price

3. **Monitoring Screens**
   - [ ] List all service requests
   - [ ] List all bookings
   - [ ] List all payments
   - [ ] List all invoices
   - [ ] List all reviews

4. **User Management**
   - [ ] List all users
   - [ ] Filter by role
   - [ ] View user details
   - [ ] Ban/suspend user (optional)

### Deliverable:
✅ Admin dashboard lengkap dengan statistics
✅ Admin bisa kelola layanan
✅ Admin bisa monitor semua aktivitas

**Estimasi:** 5-7 hari

---

## 🎯 FASE 9: Polish & Testing (Week 9-10)

**Goal:** Bug fixes, UX improvements, testing.

### Tasks:
1. **Bug Fixes**
   - [ ] Fix reported bugs
   - [ ] Handle edge cases
   - [ ] Error handling improvements

2. **UX Improvements**
   - [ ] Loading states
   - [ ] Empty states
   - [ ] Error states
   - [ ] Animations & transitions

3. **Testing**
   - [ ] Unit tests for repositories
   - [ ] Integration tests for flows
   - [ ] Manual testing all features

4. **Documentation**
   - [ ] User guide
   - [ ] Admin guide
   - [ ] Technician guide
   - [ ] API documentation

### Deliverable:
✅ App siap untuk UAS
✅ Documentation lengkap

**Estimasi:** 5-7 hari

---

## 📊 TOTAL TIMELINE

| Fase | Duration | Deliverable |
|------|----------|-------------|
| Fase 1 | 3-5 days | Customer submit request |
| Fase 2 | 4-6 days | Technician application & verification |
| Fase 3 | 3-4 days | Technician dashboard & offers |
| Fase 4 | 3-4 days | Customer view & accept offers |
| Fase 5 | 5-7 days | Payment & invoice |
| Fase 6 | 3-4 days | Status tracking |
| Fase 7 | 3-4 days | History & review |
| Fase 8 | 5-7 days | Admin monitoring |
| Fase 9 | 5-7 days | Polish & testing |

**Total Estimasi: 34-48 hari (5-7 minggu)**

---

## 🚀 START NOW

**Apakah Anda ingin mulai dari:**

### Option A: Fase 1 (Customer Service Request)
Implementasi lengkap customer bisa submit request dengan foto ke database.

### Option B: Fase 2 (Technician Application)
Implementasi technician submit aplikasi dan admin verifikasi.

### Option C: Custom Priority
Pilih fitur spesifik yang ingin diimplementasi dulu.

**Mana yang ingin dimulai?**

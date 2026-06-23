# Backend Implementation Progress

Branch: `feature/backend-service-request`

## ✅ TAHAP 1: Service Catalog Management (SELESAI)

### Database Schema
- ✅ `service_categories` table - kategori layanan (Printer, Komputer, Laptop)
- ✅ `services` table dengan relasi ke category
- ✅ `service_photos` table - untuk multiple photos
- ✅ Seed data: 3 categories + 6 services dari dummy data
- ✅ Indexes untuk performa query
- ✅ Auto-update timestamp triggers

### Row Level Security (RLS)
- ✅ Admin: Full CRUD access untuk categories & services
- ✅ Customer & Technician: Read-only access untuk active items
- ✅ RLS policies untuk semua tabel

### Dart Models & Repository
- ✅ `ServiceCategory` model dengan color & icon helpers
- ✅ `Service` model dengan features array
- ✅ `ServiceRepository` dengan CRUD methods
- ✅ Realtime subscriptions untuk auto-refresh

### Riverpod Providers
- ✅ `serviceCategoriesProvider` - fetch active categories
- ✅ `activeServicesProvider` - fetch active services
- ✅ `servicesByCategoryProvider` - filter by category
- ✅ Admin providers: create/update/delete categories & services
- ✅ Parameter classes untuk type-safe operations

---

## ✅ TAHAP 2: Service Request System (SELESAI)

## ✅ TAHAP 2: Service Request System (SELESAI)

### Supabase Storage
- ✅ 3 buckets: `request-photos`, `technician-documents`, `avatars`
- ✅ Storage RLS policies:
  - Customer: upload/view own photos
  - Technician: view photos dari request yang di-offer
  - Admin: view all
- ✅ Folder structure: `{user_id}/file_name`

### Database Enhancements
- ✅ Enhanced `service_requests` table:
  - `photo_urls[]` - support multiple photos
  - `budget_min/max` - customer budget range
  - `urgency` - normal/urgent
  - `notes` - catatan tambahan
- ✅ RLS policies untuk service_requests:
  - Customer: CRUD own requests
  - Technician: view open + offered requests
  - Admin: view all
- ✅ Functions:
  - `publish_service_request()` - draft → open
  - `cancel_service_request()` - cancel with reason
- ✅ Trigger: `notify_new_request()` - pg_notify untuk realtime
- ✅ View: `service_request_stats` - dashboard analytics

### Dart Models & Repository
- ✅ `ServiceRequest` model dengan enums
- ✅ `RequestStatus` enum (draft, open, offered, etc)
- ✅ `RequestUrgency` enum (normal, urgent)
- ✅ `ServiceRequestRepository`:
  - ✅ Create request + multi-photo upload
  - ✅ Add photos to existing request
  - ✅ Get requests (my, open, offered, all)
  - ✅ Update, publish, cancel, delete
  - ✅ Realtime subscriptions
  - ✅ Distance filter (Haversine formula)

### Riverpod Providers
- ✅ Read providers:
  - `myRequestsProvider` - customer requests
  - `openRequestsProvider` - untuk teknisi (with filters)
  - `requestsIOfferedProvider` - requests teknisi offered
  - `requestByIdProvider` - single request
  - `allRequestsProvider` - admin view
- ✅ Action providers:
  - `createRequestProvider` - create + upload photos
  - `addPhotosToRequestProvider` - add more photos
  - `updateRequestProvider` - update draft/open
  - `publishRequestProvider` - publish draft
  - `cancelRequestProvider` - cancel request
  - `deleteRequestProvider` - delete draft

### Files Created
```
supabase/migrations/
  - 20260623010000_storage_buckets.sql
  - 20260623010100_service_request_system.sql

lib/features/service_request/
  - domain/models.dart
  - data/service_request_repository.dart
  - presentation/providers/service_request_providers.dart
```

---

## ✅ TAHAP 3: Offer Management System (SELESAI)

### Database Enhancements
- ✅ Enhanced `service_offers` table:
  - `transport_fee` - biaya transport teknisi
  - `estimated_duration` - estimasi durasi pengerjaan
  - `photo_urls[]` - foto pendukung offer
  - `expires_at` - auto-expire untuk urgent requests
- ✅ RLS policies:
  - Teknisi: create/update own offers (pending only)
  - Customer: view offers untuk own requests
  - Admin: view all offers
- ✅ Functions:
  - `accept_service_offer()` - accept offer, auto-create booking & payment, reject others
  - `reject_service_offer()` - reject dengan reason
  - `expire_old_offers()` - background job untuk expire
- ✅ Triggers:
  - `notify_new_offer()` - notify customer saat offer baru
  - `notify_offer_status_change()` - notify teknisi saat accepted/rejected
  - `update_request_status_on_offer()` - update request status open → offered
- ✅ View: `offer_statistics` - acceptance rate, avg price per teknisi

### Auto-Booking Logic
- ✅ Accept offer → auto-create booking + payment record
- ✅ Calculate platform fee (10%)
- ✅ Generate Midtrans order ID: `STK-YYYYMMDD-{UUID}`
- ✅ Reject other pending offers automatically
- ✅ Update request status → 'booked'

### Dart Models & Repository
- ✅ `ServiceOffer` model dengan helpers (totalAmount, isExpired)
- ✅ `OfferStatus` enum (pending, accepted, rejected, expired)
- ✅ `AcceptOfferResult` model - response dari accept
- ✅ `OfferWithTechnician` model - offer + profile untuk comparison
- ✅ `OfferRepository`:
  - ✅ Create offer + photo upload
  - ✅ Get offers (by request, technician, all)
  - ✅ Update pending offers
  - ✅ Accept/reject offers
  - ✅ Expire old offers
  - ✅ Realtime subscriptions
  - ✅ Technician statistics

### Riverpod Providers
- ✅ Read providers:
  - `offersForRequestProvider` - offers untuk request
  - `offersWithTechnicianProvider` - with profile untuk comparison
  - `myOffersProvider` - teknisi's offers
  - `offerByIdProvider` - single offer
  - `allOffersProvider` - admin view
  - `technicianOfferStatsProvider` - statistics
- ✅ Action providers:
  - `createOfferProvider` - teknisi create offer
  - `updateOfferProvider` - update pending offer
  - `acceptOfferProvider` - customer accept (returns booking info)
  - `rejectOfferProvider` - customer reject
  - `deleteOfferProvider` - teknisi delete
  - `expireOldOffersProvider` - background task

### Files Created
```
supabase/migrations/
  - 20260623020000_offer_management_system.sql

lib/features/offer/
  - domain/models.dart
  - data/offer_repository.dart
  - presentation/providers/offer_providers.dart
```

---

## ✅ TAHAP 4: Booking & Tracking System (SELESAI)

### Database Enhancements
- ✅ Enhanced `bookings` table:
  - `technician_location_lat/lng` - GPS tracking
  - `location_updated_at` - timestamp tracking
  - `arrival_time` - waktu arrived
  - `work_started_at` - waktu mulai kerja
  - `work_notes` - catatan teknisi
  - `customer_notes` - instruksi customer
  - `cancellation_reason` - alasan cancel
  - `cancelled_by` - customer/technician
- ✅ RLS policies:
  - Customer: view own bookings, update notes
  - Technician: view own bookings, update status/location/notes
  - Admin: view & update all
- ✅ Functions:
  - `confirm_booking()` - teknisi confirm (pending_payment → confirmed)
  - `update_technician_location()` - GPS tracking realtime
  - `mark_technician_arrived()` - set arrival time
  - `start_booking_work()` - mulai pengerjaan (confirmed → in_progress)
  - `complete_booking()` - selesaikan (in_progress → completed)
  - `cancel_booking()` - cancel by customer/technician
- ✅ Triggers:
  - `notify_booking_status_change()` - notify customer & technician
  - `notify_location_update()` - realtime GPS untuk customer
- ✅ Views:
  - `booking_statistics` - total, status breakdown, avg duration
  - `technician_performance` - completion rate, avg work time, avg arrival time

### Booking Lifecycle
```
pending_payment → confirmed → in_progress → completed
       ↓              ↓             ↓
   cancelled     cancelled     cancelled
```

### GPS Tracking
- ✅ Real-time location updates setiap X seconds
- ✅ Location stale detection (>5 minutes)
- ✅ ETA calculation dengan Haversine distance
- ✅ Customer dapat track teknisi on map

### Dart Models & Repository
- ✅ `Booking` model dengan helpers:
  - `hasArrived`, `isWorkInProgress`, `isActive`
  - `workDuration`, `arrivalDuration`
- ✅ `BookingStatus` enum dengan display names
- ✅ `TechnicianLocation` model dengan stale detection
- ✅ `BookingDetail` model - booking + joined data
- ✅ `BookingRepository`:
  - ✅ Get bookings (customer, technician, active, all)
  - ✅ Status lifecycle methods (confirm, arrived, start, complete, cancel)
  - ✅ GPS tracking (update location)
  - ✅ Notes management (customer & work notes)
  - ✅ Realtime subscriptions (status & location)
  - ✅ Statistics & performance metrics

### Riverpod Providers
- ✅ Read providers:
  - `bookingByIdProvider` - single booking
  - `bookingDetailProvider` - with joined data
  - `myBookingsProvider` - customer bookings
  - `technicianBookingsProvider` - technician bookings
  - `activeBookingsProvider` - for tracking
  - `bookingStatisticsProvider` - admin dashboard
  - `technicianPerformanceProvider` - performance metrics
- ✅ Action providers:
  - `confirmBookingProvider` - confirm after payment
  - `markArrivedProvider` - set arrival
  - `startWorkProvider` - mulai kerja
  - `completeBookingProvider` - selesaikan
  - `cancelBookingProvider` - cancel booking
  - `updateTechnicianLocationProvider` - GPS tracking
  - `updateCustomerNotesProvider` - instruksi
  - `updateWorkNotesProvider` - catatan kerja

### Files Created
```
supabase/migrations/
  - 20260623030000_booking_tracking_system.sql

lib/features/booking/
  - domain/models.dart
  - data/booking_repository.dart
  - presentation/providers/booking_providers.dart
```

---

## 🚧 TAHAP 5: Payment Integration (NEXT)

### Yang Akan Dibuat:
1. **Offer Repository**
   - Teknisi kirim penawaran dengan harga custom
   - Upload foto pendukung offer (optional)
   - View offers untuk customer
   - Compare multiple offers
   - Accept/reject offer

2. **Auto-create Booking**
   - Saat customer accept offer → auto create booking
   - Update request status → 'booked'
   - Update offer status → 'accepted'
   - Reject other offers → 'rejected'

3. **Realtime Notifications**
   - Customer notif saat ada offer baru
   - Teknisi notif saat offer accepted/rejected

---

## 📋 TAHAP 4-7 (Planned)

### Tahap 4: Booking & Tracking System
- Booking lifecycle management
- Status tracking (pending → in_progress → completed)
- GPS location tracking
- Realtime status updates

### Tahap 5: Payment Integration
- Supabase Edge Functions untuk Midtrans
- Payment creation flow
- Webhook handler
- Payment status updates

### Tahap 6: Invoice Generation
- Auto-generate invoice setelah payment
- Platform fee calculation (10%)
- Invoice number generator
- PDF generation (optional)

### Tahap 7: Review System
- Customer submit review & rating
- Display reviews di technician profile
- Average rating calculation

---

## 🔧 Cara Test TAHAP 1

### 1. Run Migration
```bash
# Di terminal, masuk ke folder project
cd d:\siteknisi_apps

# Run Supabase migrations (jika sudah setup local)
supabase db push

# Atau apply manual di Supabase Dashboard > SQL Editor
```

### 2. Test di Flutter App
```dart
// Di customer home screen, ganti dummy data dengan:
final categories = ref.watch(serviceCategoriesProvider);

categories.when(
  data: (data) => ListView.builder(...),
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
)
```

### 3. Test Admin CRUD (Console)
```dart
// Create category
final createCategory = ref.read(createCategoryProvider);
await createCategory(CreateCategoryParams(
  name: 'Networking',
  description: 'Router, WiFi, LAN setup',
  iconName: 'wifi_rounded',
  colorHex: '#8B5CF6',
));

// Update service
final updateService = ref.read(updateServiceProvider);
await updateService(UpdateServiceParams(
  id: 'service-id',
  basePrice: 160000,
  isActive: false,
));
```

---

## 📝 Notes
- Migration files menggunakan timestamp prefix untuk ordering
- RLS policies menjamin data security per role
- Riverpod providers auto-invalidate untuk fresh data
- Semua operations async dengan proper error handling

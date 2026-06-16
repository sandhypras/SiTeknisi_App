# Information Architecture

Dokumen ini mendefinisikan struktur navigasi SiTeknisi untuk Customer App, Technician App, dan Admin Web.

## 1. Customer App - Guest

```text
Guest
├── Splash
├── Onboarding
├── Home
│   ├── Search Service
│   ├── Popular Services
│   └── Join As Technician Entry
├── Services
│   ├── Service Categories
│   └── Service Detail
└── Authentication
    ├── Login
    └── Register
```

### Navigation Notes

- Guest dapat melihat layanan dan detail layanan.
- Guest harus login sebelum membuat request service.
- CTA utama untuk Guest adalah `Login untuk Pesan Servis`.

## 2. Customer App - Authenticated

```text
Authenticated Customer
├── Home
│   ├── Service Categories
│   ├── Active Booking Summary
│   └── Recommended Services
├── Booking
│   ├── Create Service Request
│   ├── Upload Damage Photo
│   ├── Technician Offer List
│   ├── Offer Detail
│   └── Booking Tracking
├── Payment
│   ├── Payment Method
│   ├── Payment Status
│   └── Payment Success
├── History
│   ├── Booking History
│   ├── Invoice
│   └── Review
└── Profile
    ├── Profile Detail
    ├── Join As Technician
    ├── Technician Application Form
    └── Logout
```

### Bottom Navigation

| Tab | Purpose |
|---|---|
| Home | Mulai request dan melihat layanan |
| Booking | Melihat booking aktif dan tracking |
| History | Riwayat booking, invoice, review |
| Profile | Data akun dan entry join Teknisi |

## 3. Technician App

```text
Technician
├── Dashboard
│   ├── Verification Status
│   ├── Active Jobs
│   ├── New Requests
│   └── Earnings Summary
├── Requests
│   ├── Incoming Requests
│   ├── Request Detail
│   └── Create Offer
├── Offers
│   ├── Sent Offers
│   └── Offer Status Detail
├── Earnings
│   ├── Earnings Summary
│   ├── Job History
│   └── Bank Account
└── Profile
    ├── Technician Profile
    ├── Application Status
    ├── Skills and Experience
    └── Logout
```

### Bottom Navigation

| Tab | Purpose |
|---|---|
| Dashboard | Ringkasan kerja dan status |
| Requests | Request terbuka dan create offer |
| Offers | Offer terkirim dan status |
| Earnings | Pendapatan dan rekening |
| Profile | Profil Teknisi |

## 4. Admin Web

```text
Admin Web
├── Login
├── Dashboard
│   ├── KPI Summary
│   ├── Recent Bookings
│   ├── Payment Overview
│   └── Pending Verifications
├── Users
│   ├── Customer List
│   ├── Technician List
│   └── User Detail
├── Technicians
│   ├── Technician Verification
│   ├── Technician Detail
│   ├── Approve Application
│   └── Reject Application
├── Services
│   ├── Service List
│   ├── Create Service
│   └── Edit Service
├── Bookings
│   ├── Booking Monitoring
│   └── Booking Detail
├── Payments
│   ├── Payment Monitoring
│   └── Payment Detail
├── Invoices
│   ├── Invoice Monitoring
│   └── Invoice Detail
├── Reports
│   ├── Transaction Summary
│   ├── Technician Performance
│   └── Service Demand
└── Settings
    ├── Platform Commission
    ├── Admin Profile
    └── General Configuration
```

### Sidebar Navigation

Admin Web menggunakan sidebar kiri dengan menu:

- Dashboard
- Users
- Technicians
- Services
- Bookings
- Payments
- Invoices
- Reports
- Settings

## 5. Cross-role Objects

| Object | Customer | Technician | Admin |
|---|---|---|---|
| Service | Browse | Referensi request | Manage |
| Request | Create dan view own | View open | Monitor |
| Offer | Compare dan accept | Create dan track | Monitor |
| Booking | Track own | Update status | Monitor |
| Payment | Pay dan view status | View related income | Monitor |
| Invoice | View own | View related income | Monitor |
| Review | Create | View received | Monitor |


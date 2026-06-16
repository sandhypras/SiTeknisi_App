# SiTeknisi Documentation

Folder ini berisi dokumentasi proyek SiTeknisi - Marketplace Jasa Servis Elektronik.

## Deskripsi Project

SiTeknisi adalah platform marketplace jasa servis elektronik yang menghubungkan Customer dengan Teknisi. Customer dapat membuat permintaan servis, menerima penawaran harga, melakukan pembayaran melalui Midtrans, mendapatkan invoice otomatis, dan memberi review. Teknisi dapat menerima request, mengirim offer, memperbarui status pekerjaan, dan melihat pendapatan. Admin dapat memverifikasi Teknisi serta memonitor booking dan pembayaran.

## Tech Stack

- Flutter Mobile untuk Customer dan Teknisi.
- Flutter Web untuk Admin Website.
- Supabase Auth untuk authentication.
- Supabase PostgreSQL untuk database.
- Supabase Storage untuk upload foto dan dokumen.
- Supabase Realtime untuk update status.
- Midtrans untuk payment gateway.
- Google Maps API dan Geolocator untuk lokasi.
- Riverpod untuk state management.
- Go Router untuk routing.

## Folder Structure

```text
docs/
├── PRD.md
├── USER_FLOW.md
├── PROJECT_PLAN.md
├── TEAM_ASSIGNMENT.md
├── ERD.md
├── DATABASE_SCHEMA.md
├── API_SPECIFICATION.md
├── SYSTEM_ARCHITECTURE.md
├── DESIGN_SYSTEM.md
├── MVP_SCOPE.md
└── README.md
```

## Dokumen

| Dokumen | Isi |
|---|---|
| `PRD.md` | Product Requirements Document |
| `USER_FLOW.md` | Alur Customer, Teknisi, dan Admin |
| `PROJECT_PLAN.md` | Roadmap pengembangan 6 minggu |
| `TEAM_ASSIGNMENT.md` | Pembagian tugas tim 3 orang |
| `ERD.md` | Entity Relationship Diagram |
| `DATABASE_SCHEMA.md` | Schema PostgreSQL dan constraint |
| `API_SPECIFICATION.md` | Kontrak REST API |
| `SYSTEM_ARCHITECTURE.md` | Arsitektur sistem |
| `DESIGN_SYSTEM.md` | Warna, typography, spacing, component guideline |
| `MVP_SCOPE.md` | Fitur wajib untuk MVP UAS |

## Setup Project

Langkah setup awal yang direkomendasikan:

1. Clone repository.
2. Install Flutter SDK.
3. Jalankan `flutter pub get`.
4. Buat project Supabase.
5. Buat tabel database sesuai `DATABASE_SCHEMA.md`.
6. Konfigurasi Supabase Auth, Storage, Realtime, dan RLS.
7. Konfigurasi Midtrans sandbox.
8. Siapkan environment variable untuk Supabase dan Midtrans.

## Run Project

Mobile:

```bash
flutter run
```

Web Admin:

```bash
flutter run -d chrome
```

Build Android:

```bash
flutter build apk
```

Build Web:

```bash
flutter build web
```

## Contributors

| Anggota | Peran |
|---|---|
| Anggota 1 | Customer Mobile |
| Anggota 2 | Backend & Supabase |
| Anggota 3 | Technician App & Admin Website |

## Status Dokumentasi

Dokumentasi ini dibuat sebagai fondasi sebelum pengembangan Flutter dimulai. Fokus utama adalah memastikan scope, alur sistem, struktur data, API, arsitektur, design system, dan pembagian kerja sudah jelas.


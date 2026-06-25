# SiTeknisi App

SiTeknisi adalah aplikasi marketplace jasa servis elektronik untuk menghubungkan customer dengan teknisi. Customer dapat mencari layanan, membuat request servis, membandingkan penawaran, melakukan pembayaran, melihat invoice, dan memberi review. Teknisi dapat melihat request, membuat offer, mengelola pekerjaan, dan memantau pendapatan. Admin web disiapkan untuk verifikasi teknisi serta monitoring booking, pembayaran, dan invoice.

## Tech Stack

- Flutter untuk mobile app customer dan teknisi.
- Flutter Web untuk admin dashboard.
- Riverpod untuk state management.
- Go Router untuk navigasi.
- Supabase untuk auth, database, storage, dan realtime.
- Midtrans untuk payment gateway.

## Struktur Utama

```text
lib/
  core/             # config, router, theme, constants
  features/         # auth, customer, technician, admin
  shared/widgets/   # komponen UI reusable
assets/images/      # logo, banner, kategori, teknisi, promosi
docs/               # PRD, ERD, API spec, desain, flow, arsitektur
```

## Menjalankan Project

Install dependency:

```bash
flutter pub get
```

Jalankan mode prototype/mock tanpa backend:

```bash
flutter run
```

Jalankan dengan Supabase:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://<project-ref>.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=<publishable-key>
```

Jalankan admin web:

```bash
flutter run -d chrome --dart-define=APP_MODE=admin
```

Build Android:

```bash
flutter build apk
```

## Status Saat Ini

- `flutter analyze` sudah bersih.
- UI utama customer, teknisi, auth, dan admin sudah tersedia.
- Dokumentasi produk dan desain tersedia di folder `docs/`.
- Aplikasi masih dapat berjalan dalam mode mock ketika Supabase belum dikonfigurasi.

## Yang Masih Kurang

Prioritas tinggi:

- Belum ada folder `test/` atau `integration_test/`, jadi belum ada automated test untuk flow login, booking, payment, invoice, dan routing.
- Belum ada migration/seed Supabase di repo. Schema sudah terdokumentasi di `docs/DATABASE_SCHEMA.md`, tetapi belum menjadi file migration yang bisa dijalankan ulang.
- Payment Midtrans masih berupa simulasi UI. Perlu backend/Edge Function untuk create transaction dan webhook notification.
- Banyak layar customer/technician masih memakai dummy data. Perlu repository data nyata yang terhubung ke Supabase.
- Belum ada GitHub Actions/CI untuk menjalankan `flutter analyze` dan test otomatis setiap push.

Prioritas menengah:

- Upload foto request, KTP, dan foto profil belum terhubung ke Supabase Storage.
- Realtime status booking, offer, payment, dan invoice belum terhubung ke Supabase Realtime.
- Admin dashboard masih perlu data live, filter, audit detail, dan proteksi role admin.
- Perlu konfigurasi RLS Supabase yang diuji untuk customer, teknisi, dan admin.

## Dokumen Penting

- [PRD](docs/PRD.md)
- [MVP Scope](docs/MVP_SCOPE.md)
- [Database Schema](docs/DATABASE_SCHEMA.md)
- [API Specification](docs/API_SPECIFICATION.md)
- [System Architecture](docs/SYSTEM_ARCHITECTURE.md)
- [Design System](docs/DESIGN_SYSTEM.md)
- [User Flow](docs/USER_FLOW.md)


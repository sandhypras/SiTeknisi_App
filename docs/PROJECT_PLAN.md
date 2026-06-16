# Project Plan

Roadmap proyek SiTeknisi dirancang untuk durasi 6 minggu dengan fokus menyelesaikan MVP UAS secara bertahap.

## Ringkasan Timeline

| Minggu | Fokus | Output Utama |
|---|---|---|
| Minggu 1 | Setup Project | Struktur Flutter, Supabase, dokumentasi awal |
| Minggu 2 | Authentication | Login, register, role, session |
| Minggu 3 | Customer Module | Home, request service, offer, payment flow |
| Minggu 4 | Technician Module | Dashboard Teknisi, offer, status update |
| Minggu 5 | Admin Website | Verifikasi Teknisi, monitoring booking dan payment |
| Minggu 6 | Testing & Deployment | Testing, bug fixing, deployment, final demo |

## Minggu 1 - Setup Project

### Tujuan

Menyiapkan fondasi teknis dan dokumentasi agar tim dapat bekerja paralel.

### Task

- Finalisasi dokumentasi proyek di folder `docs/`.
- Setup Flutter project.
- Setup struktur folder aplikasi.
- Setup dependency awal seperti Riverpod, Go Router, Supabase Flutter, dan package pendukung.
- Buat project Supabase.
- Buat environment configuration.
- Desain database awal.
- Setup repository GitHub.

### Output

- Repository siap digunakan.
- Struktur aplikasi disepakati.
- Dokumen PRD, ERD, schema, API, dan design system tersedia.
- Supabase project aktif.

## Minggu 2 - Authentication

### Tujuan

Membangun autentikasi dan role dasar untuk Customer, Teknisi, dan Admin.

### Task

- Implementasi register dan login.
- Setup Supabase Auth.
- Buat tabel `profiles`.
- Implementasi role `customer`, `technician`, dan `admin`.
- Implementasi protected route.
- Implementasi logout.
- Setup Row Level Security dasar.

### Output

- User dapat register dan login.
- Role tersimpan di database.
- Navigasi menyesuaikan role.

## Minggu 3 - Customer Module

### Tujuan

Membangun alur utama Customer dari home sampai pembayaran.

### Task

- Home Customer.
- Daftar kategori layanan.
- Form request service.
- Upload foto perangkat ke Supabase Storage.
- Menampilkan status request.
- Menampilkan daftar offer Teknisi.
- Memilih offer.
- Membuat booking.
- Membuat payment request Midtrans.
- Menampilkan invoice setelah payment sukses.

### Output

- Customer dapat membuat request service.
- Customer dapat memilih offer.
- Customer dapat melakukan payment flow.
- Customer dapat melihat invoice.

## Minggu 4 - Technician Module

### Tujuan

Membangun alur Teknisi untuk menerima permintaan, mengirim offer, dan memperbarui status.

### Task

- Form pengajuan Teknisi.
- Upload dokumen KTP dan foto profil.
- Dashboard Teknisi.
- Daftar request service yang tersedia.
- Form kirim offer.
- Daftar booking Teknisi.
- Update status pengerjaan.
- Ringkasan pendapatan sederhana.
- Data rekening Teknisi.

### Output

- Teknisi dapat mengajukan verifikasi.
- Teknisi approved dapat mengirim offer.
- Teknisi dapat memperbarui status pekerjaan.

## Minggu 5 - Admin Website

### Tujuan

Membangun web admin untuk verifikasi Teknisi dan monitoring transaksi.

### Task

- Login Admin.
- Dashboard ringkasan data.
- Halaman verifikasi Teknisi.
- Approve dan reject pengajuan Teknisi.
- Halaman monitoring booking.
- Halaman monitoring pembayaran.
- Halaman invoice.
- Halaman layanan.

### Output

- Admin dapat memverifikasi Teknisi.
- Admin dapat memonitor booking dan pembayaran.
- Admin dapat melihat invoice.

## Minggu 6 - Testing & Deployment

### Tujuan

Memastikan MVP stabil untuk presentasi UAS.

### Task

- Testing alur Customer end-to-end.
- Testing alur Teknisi end-to-end.
- Testing alur Admin end-to-end.
- Testing Midtrans sandbox.
- Testing Supabase RLS.
- Bug fixing.
- Build Android.
- Build Flutter Web Admin.
- Deployment web admin.
- Persiapan demo dan dokumentasi final.

### Output

- MVP siap demo.
- APK atau build Android tersedia.
- Web Admin dapat diakses.
- Dokumentasi final siap dikumpulkan.


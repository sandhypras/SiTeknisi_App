# Team Assignment

Tim SiTeknisi terdiri dari 3 orang. Pembagian tugas dibuat berdasarkan modul utama agar pengembangan dapat berjalan paralel.

## Struktur Tim

| Anggota | Tanggung Jawab Utama | Modul |
|---|---|---|
| Anggota 1 | Customer Mobile | Flutter Mobile Customer |
| Anggota 2 | Backend & Supabase | Database, Auth, API, Storage, Realtime, Midtrans |
| Anggota 3 | Technician App & Admin Website | Teknisi Mobile dan Flutter Web Admin |

## Anggota 1 - Customer Mobile

### Tanggung Jawab

Mengembangkan seluruh pengalaman Customer di aplikasi mobile.

### Task Breakdown

- Membuat struktur halaman Customer.
- Implementasi onboarding atau guest home sederhana.
- Implementasi login dan register UI.
- Membuat halaman home Customer.
- Menampilkan daftar kategori layanan.
- Membuat halaman detail layanan.
- Membuat form request service.
- Integrasi upload foto perangkat.
- Menampilkan status request service.
- Menampilkan daftar offer dari Teknisi.
- Membuat halaman detail offer.
- Implementasi pilihan offer.
- Membuat halaman payment status.
- Menampilkan invoice.
- Membuat halaman riwayat booking.
- Membuat form rating dan review.
- Testing alur Customer end-to-end.

### Deliverable

- Customer app flow dari login sampai invoice.
- UI Customer sesuai design system.
- Integrasi Customer dengan Supabase.

## Anggota 2 - Backend & Supabase

### Tanggung Jawab

Mengelola backend, database, security, dan integrasi layanan eksternal.

### Task Breakdown

- Setup project Supabase.
- Membuat tabel PostgreSQL.
- Membuat enum status.
- Membuat relasi dan constraint.
- Setup Supabase Auth.
- Membuat trigger profile setelah user register jika diperlukan.
- Setup Row Level Security.
- Membuat policy untuk Customer, Teknisi, dan Admin.
- Setup Supabase Storage bucket untuk dokumen dan foto request.
- Setup Realtime untuk request, offer, booking, dan payment.
- Menyusun API contract.
- Integrasi Midtrans sandbox.
- Membuat endpoint atau edge function untuk create payment.
- Membuat endpoint atau edge function untuk payment notification.
- Membuat invoice number generator.
- Testing payment callback.
- Menyediakan seed data layanan.

### Deliverable

- Database siap digunakan.
- RLS dasar aktif.
- Payment Midtrans sandbox berjalan.
- Storage dan Realtime siap digunakan.

## Anggota 3 - Technician App & Admin Website

### Tanggung Jawab

Mengembangkan modul Teknisi dan Admin Web.

### Task Breakdown Teknisi

- Membuat form pengajuan Teknisi.
- Integrasi upload KTP dan foto profil.
- Membuat halaman status verifikasi.
- Membuat dashboard Teknisi.
- Menampilkan daftar request service terbuka.
- Membuat form kirim offer.
- Menampilkan booking yang diterima.
- Membuat update status pekerjaan.
- Membuat halaman profil Teknisi.
- Membuat halaman data rekening.
- Membuat ringkasan pendapatan.
- Testing alur Teknisi end-to-end.

### Task Breakdown Admin Website

- Membuat layout dashboard Admin.
- Implementasi login Admin.
- Membuat halaman ringkasan data.
- Membuat halaman pengajuan Teknisi.
- Implementasi approve dan reject Teknisi.
- Membuat halaman daftar pengguna.
- Membuat halaman layanan.
- Membuat halaman monitoring booking.
- Membuat halaman monitoring pembayaran.
- Membuat halaman invoice.
- Testing alur Admin end-to-end.

### Deliverable

- Modul Teknisi berjalan.
- Admin Website berjalan.
- Verifikasi Teknisi dan monitoring transaksi tersedia.

## Koordinasi Tim

- Gunakan branch Git sesuai modul.
- Pull request wajib direview minimal oleh 1 anggota lain.
- Update progress harian melalui task board.
- Setiap integrasi besar wajib diuji bersama.
- Database changes harus dikomunikasikan sebelum di-merge.

## Definition of Done

Sebuah task dianggap selesai jika:

- Fitur berjalan sesuai user flow.
- Tidak ada error utama pada console.
- UI mengikuti design system.
- Data berhasil tersimpan di Supabase.
- Role dan akses data sesuai kebutuhan.
- Minimal sudah diuji manual oleh pembuat fitur.


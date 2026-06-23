# Product Requirements Document

## 1. Ringkasan Produk

SiTeknisi adalah marketplace jasa servis elektronik yang menghubungkan Customer dengan Teknisi elektronik terdekat. Customer dapat memilih kategori layanan, membuat permintaan servis, menerima penawaran harga dari Teknisi, melakukan pembayaran melalui Midtrans, mendapatkan invoice otomatis, serta memberi rating dan review setelah pekerjaan selesai.

Platform terdiri dari:

- Flutter Mobile App untuk Customer.
- Flutter Mobile App atau role-based interface untuk Teknisi.
- Flutter Web Admin untuk pengelolaan operasional.
- Supabase sebagai backend, database, authentication, storage, dan realtime service.
- Midtrans sebagai payment gateway.

## 2. Latar Belakang

Pencarian teknisi elektronik saat ini masih banyak dilakukan melalui Google, media sosial, WhatsApp, atau rekomendasi teman. Proses tersebut menimbulkan beberapa masalah:

- Sulit menemukan teknisi terpercaya.
- Customer tidak mudah membandingkan harga.
- Tidak ada sistem booking dan tracking status pengerjaan.
- Tidak ada riwayat servis yang terdokumentasi.
- Pembayaran dan invoice belum terorganisir.
- Teknisi kesulitan mendapatkan pelanggan baru secara konsisten.

SiTeknisi dirancang untuk menyelesaikan masalah tersebut melalui sistem marketplace yang lebih transparan, terukur, dan mudah digunakan.

## 3. Tujuan Produk

### Tujuan Bisnis

- Mempermudah Customer menemukan teknisi servis elektronik.
- Membantu Teknisi mendapatkan permintaan servis dari pelanggan.
- Menyediakan proses penawaran harga yang transparan.
- Mengintegrasikan pembayaran digital dan invoice otomatis.
- Menyediakan dashboard monitoring untuk Admin.
- Membuka peluang pendapatan platform melalui komisi transaksi.

### Tujuan Akademik

- Mengimplementasikan Flutter Mobile dan Flutter Web.
- Menggunakan Supabase Auth, PostgreSQL, Storage, Realtime, dan Row Level Security.
- Menerapkan integrasi Midtrans untuk pembayaran.
- Mendesain alur marketplace berbasis role Customer, Teknisi, dan Admin.
- Menyusun dokumentasi proyek yang siap digunakan untuk pengembangan UAS.

## 4. Target Pengguna

### Customer

Pengguna yang membutuhkan jasa diagnosis, perawatan, atau perbaikan perangkat teknologi, dengan fokus layanan pada printer, komputer desktop, dan laptop beserta perangkat pendukungnya.

### Teknisi

Penyedia jasa servis elektronik yang ingin menerima permintaan pekerjaan, mengirim penawaran harga, memperbarui status pekerjaan, dan melihat pendapatan.

### Admin

Pengelola platform yang bertanggung jawab memverifikasi Teknisi, mengelola layanan, memonitor booking, pembayaran, invoice, dan aktivitas pengguna.

## 5. User Story

### Customer

- Sebagai Customer, saya ingin login agar dapat membuat permintaan servis.
- Sebagai Customer, saya ingin melihat kategori layanan agar dapat memilih jenis servis yang sesuai.
- Sebagai Customer, saya ingin mengirim deskripsi masalah dan foto perangkat agar Teknisi dapat memberi estimasi harga.
- Sebagai Customer, saya ingin menerima beberapa penawaran harga agar dapat memilih Teknisi terbaik.
- Sebagai Customer, saya ingin membayar melalui aplikasi agar transaksi lebih aman dan tercatat.
- Sebagai Customer, saya ingin mendapatkan invoice otomatis setelah membayar.
- Sebagai Customer, saya ingin memberi rating dan review setelah servis selesai.

### Teknisi

- Sebagai Teknisi, saya ingin mendaftar dan mengirim data verifikasi agar dapat bergabung ke platform.
- Sebagai Teknisi, saya ingin melihat permintaan servis yang relevan dengan keahlian saya.
- Sebagai Teknisi, saya ingin mengirim penawaran harga kepada Customer.
- Sebagai Teknisi, saya ingin memperbarui status pengerjaan agar Customer dapat memantau progres.
- Sebagai Teknisi, saya ingin melihat pendapatan dan komisi platform.
- Sebagai Teknisi, saya ingin menyimpan data rekening untuk kebutuhan pencairan pendapatan.

### Admin

- Sebagai Admin, saya ingin login ke dashboard agar dapat mengelola platform.
- Sebagai Admin, saya ingin memverifikasi pengajuan Teknisi agar kualitas layanan terjaga.
- Sebagai Admin, saya ingin memonitor booking dan pembayaran.
- Sebagai Admin, saya ingin melihat invoice transaksi.
- Sebagai Admin, saya ingin mengelola kategori layanan.

## 6. Fitur Customer

- Guest Mode untuk melihat layanan tanpa login.
- Register dan Login menggunakan Supabase Auth.
- Home dengan daftar kategori layanan.
- Detail layanan.
- Request Service berisi kategori, lokasi, deskripsi masalah, jadwal, dan foto.
- Daftar penawaran Teknisi.
- Pilih penawaran Teknisi.
- Pembayaran melalui Midtrans.
- Invoice otomatis.
- Riwayat booking.
- Status tracking pengerjaan.
- Rating dan review.

## 7. Fitur Teknisi

- Register akun Teknisi.
- Pengajuan verifikasi Teknisi.
- Dashboard permintaan servis.
- Kirim offer atau penawaran harga.
- Melihat booking yang diterima.
- Update status pengerjaan.
- Profil Teknisi.
- Data rekening Teknisi.
- Ringkasan pendapatan.

## 8. Fitur Admin Website

- Login Admin.
- Dashboard ringkasan platform.
- Manajemen pengguna.
- Verifikasi pengajuan Teknisi.
- Manajemen Teknisi.
- Manajemen layanan.
- Monitoring service request.
- Monitoring booking.
- Monitoring pembayaran.
- Monitoring invoice.
- Monitoring review.

## 9. Sistem Pembayaran Midtrans

Midtrans digunakan sebagai payment gateway untuk memproses pembayaran Customer secara online.

Alur pembayaran:

1. Customer memilih offer dari Teknisi.
2. Sistem membuat booking.
3. Sistem membuat payment record dengan status `pending`.
4. Backend membuat transaksi Midtrans.
5. Customer menyelesaikan pembayaran melalui halaman Midtrans.
6. Midtrans mengirim callback atau webhook ke backend.
7. Sistem memperbarui status payment menjadi `paid`, `failed`, atau `expired`.
8. Jika pembayaran sukses, invoice otomatis dibuat.

Metode pembayaran yang ditargetkan:

- Virtual Account.
- QRIS.
- E-wallet.
- Bank transfer.

## 10. Invoice Otomatis

Invoice dibuat otomatis setelah pembayaran berhasil. Invoice menjadi bukti transaksi antara Customer, Teknisi, dan platform.

Data invoice:

- Nomor invoice.
- Customer.
- Teknisi.
- Layanan.
- Booking.
- Total pembayaran.
- Komisi platform.
- Pendapatan Teknisi.
- Metode pembayaran.
- Status pembayaran.
- Tanggal transaksi.

Format nomor invoice:

```text
INV/SITEKNISI/YYYYMMDD/0001
```

## 11. Komisi Platform

Platform mengambil komisi dari setiap transaksi berhasil.

Contoh:

- Total servis: Rp200.000
- Komisi platform: 10 persen
- Nilai komisi: Rp20.000
- Pendapatan Teknisi: Rp180.000

Besaran komisi awal untuk MVP:

- Default commission rate: 10 persen.
- Komisi dihitung saat payment berhasil.
- Nilai komisi disimpan di tabel `payments` dan `invoices`.

## 12. Data Rekening Teknisi

Data rekening digunakan untuk kebutuhan pencairan pendapatan Teknisi.

Data yang disimpan:

- Nama bank.
- Nomor rekening.
- Nama pemilik rekening.
- Status verifikasi rekening.

Catatan keamanan:

- Data rekening hanya dapat dilihat oleh pemilik akun Teknisi dan Admin.
- Akses data wajib dilindungi dengan Supabase Row Level Security.

## 13. Kebutuhan Fungsional

### Customer

- Sistem dapat melakukan register dan login Customer.
- Sistem dapat menampilkan daftar layanan.
- Sistem dapat membuat permintaan servis.
- Sistem dapat menampilkan penawaran dari Teknisi.
- Sistem dapat membuat booking dari offer yang dipilih.
- Sistem dapat memproses pembayaran melalui Midtrans.
- Sistem dapat membuat invoice otomatis.
- Sistem dapat menyimpan rating dan review.

### Teknisi

- Sistem dapat menerima pendaftaran Teknisi.
- Sistem dapat menyimpan dokumen verifikasi Teknisi.
- Sistem dapat menampilkan permintaan servis.
- Sistem dapat menyimpan offer dari Teknisi.
- Sistem dapat memperbarui status pekerjaan.
- Sistem dapat menampilkan ringkasan pendapatan.
- Sistem dapat menyimpan data rekening Teknisi.

### Admin

- Sistem dapat melakukan login Admin.
- Sistem dapat memverifikasi pengajuan Teknisi.
- Sistem dapat mengelola layanan.
- Sistem dapat memonitor booking.
- Sistem dapat memonitor pembayaran.
- Sistem dapat melihat invoice.
- Sistem dapat memonitor review.

## 14. Kebutuhan Non Fungsional

- Aplikasi mobile berjalan pada Android.
- Admin website berjalan responsive di browser desktop.
- Response time target kurang dari 3 detik untuk operasi utama.
- Authentication menggunakan Supabase Auth.
- Authorization menggunakan JWT dan Row Level Security.
- Database menggunakan PostgreSQL.
- Realtime update menggunakan Supabase Realtime.
- File dokumen dan foto menggunakan Supabase Storage.
- UI mengikuti Material 3 dan design system proyek.
- Sistem harus mudah dikembangkan oleh tim kecil.
- Data transaksi harus konsisten dan dapat diaudit.
- Integrasi payment harus menggunakan callback/webhook yang aman.

## 15. MVP Scope

MVP untuk UAS berfokus pada alur utama marketplace:

- Customer dapat login, melihat home, membuat request service, membayar, dan menerima invoice.
- Teknisi dapat melihat dashboard, mengirim offer, dan memperbarui status pekerjaan.
- Admin dapat login, memverifikasi Teknisi, dan memonitor booking serta pembayaran.
- Supabase Auth, Database, Storage, Realtime, dan Midtrans digunakan sebagai integrasi utama.

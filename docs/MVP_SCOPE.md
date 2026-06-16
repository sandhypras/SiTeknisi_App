# MVP Scope

Dokumen ini mendefinisikan fitur minimum yang wajib selesai untuk UAS.

## 1. Tujuan MVP

MVP SiTeknisi harus membuktikan alur utama marketplace jasa servis elektronik:

1. Customer membuat request service.
2. Teknisi mengirim offer.
3. Customer memilih offer dan melakukan pembayaran.
4. Sistem membuat invoice.
5. Admin dapat memverifikasi Teknisi dan memonitor transaksi.

## 2. Customer Scope

### Wajib Selesai

- Login.
- Register.
- Home.
- Daftar layanan.
- Request Service.
- Upload foto masalah.
- Melihat offer Teknisi.
- Memilih offer.
- Payment via Midtrans sandbox.
- Invoice.
- Riwayat booking sederhana.

### Tidak Wajib untuk MVP

- Chat real-time.
- Voucher atau promo.
- Favorite Teknisi.
- Multi-address management.
- Refund otomatis.

## 3. Technician Scope

### Wajib Selesai

- Dashboard Teknisi.
- Pengajuan verifikasi Teknisi.
- Melihat request service terbuka.
- Membuat offer.
- Melihat booking diterima.
- Status update pekerjaan.
- Data rekening sederhana.

### Tidak Wajib untuk MVP

- Kalender jadwal lengkap.
- Withdraw otomatis.
- Statistik pendapatan detail.
- Sertifikasi Teknisi.
- Chat real-time.

## 4. Admin Scope

### Wajib Selesai

- Login Admin.
- Dashboard Admin.
- Verification pengajuan Teknisi.
- Monitoring service request.
- Monitoring booking.
- Monitoring pembayaran.
- Monitoring invoice.
- Manajemen layanan sederhana.

### Tidak Wajib untuk MVP

- Export laporan PDF atau Excel.
- Role management detail.
- Audit log lengkap.
- Sistem komplain.
- Refund management lengkap.

## 5. Backend Scope

### Wajib Selesai

- Supabase Auth.
- Database PostgreSQL.
- Row Level Security dasar.
- Supabase Storage untuk upload dokumen dan foto request.
- Supabase Realtime untuk status request, offer, dan booking.
- Midtrans sandbox untuk payment.
- Invoice otomatis setelah payment sukses.

### Tidak Wajib untuk MVP

- Backend service terpisah penuh.
- Notification push.
- SMS OTP.
- Email transactional.
- Fraud detection.

## 6. Acceptance Criteria

MVP dianggap selesai jika:

- Customer dapat login dan membuat request service.
- Teknisi approved dapat mengirim offer.
- Customer dapat memilih offer.
- Customer dapat menjalankan pembayaran sandbox.
- Payment sukses menghasilkan invoice.
- Teknisi dapat memperbarui status pekerjaan.
- Admin dapat approve atau reject Teknisi.
- Admin dapat memonitor booking dan payment.
- Semua data utama tersimpan di Supabase.

## 7. Demo Scenario UAS

1. Admin login dan membuat layanan.
2. Teknisi register dan mengajukan verifikasi.
3. Admin approve Teknisi.
4. Customer login.
5. Customer membuat request service.
6. Teknisi melihat request dan mengirim offer.
7. Customer memilih offer.
8. Customer melakukan pembayaran Midtrans sandbox.
9. Invoice muncul otomatis.
10. Teknisi update status sampai completed.
11. Admin melihat booking dan pembayaran di dashboard.


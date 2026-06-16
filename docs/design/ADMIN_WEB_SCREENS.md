# Admin Web Screens

Dokumen ini merinci halaman Flutter Web Admin untuk SiTeknisi.

## 1. Login

- Purpose: autentikasi Admin sebelum mengakses dashboard.
- Layout: centered login panel dengan brand SiTeknisi.
- Components: email field, password field, show password, primary button.
- CTA: `Masuk`.
- Empty State: tidak ada.
- Error State: kredensial salah, role bukan admin, network error.

## 2. Dashboard

- Purpose: memberi ringkasan kondisi platform.
- Layout: sidebar kiri, top bar, content grid.
- Components: KPI cards, pending verification table, recent booking table, payment status summary.
- CTA: `Review Teknisi`, `Lihat Booking`, `Lihat Pembayaran`.
- Empty State: tampilkan zero state untuk data baru.
- Error State: banner error dengan retry.

KPI utama:

- Total users.
- Pending technician verification.
- Active bookings.
- Paid payments.
- Platform commission.

## 3. User Management

- Purpose: memonitor Customer, Teknisi, dan Admin.
- Layout: filter bar di atas tabel.
- Components: search, role filter, status filter, user table, detail drawer.
- CTA: `Lihat Detail`.
- Empty State: tidak ada user sesuai filter.
- Error State: gagal memuat user.

Kolom tabel:

- Name.
- Email atau phone.
- Role.
- Created date.
- Status.
- Action.

## 4. Technician Verification

- Purpose: approve atau reject pengajuan Teknisi.
- Layout: queue table dan detail panel.
- Components: status tabs, application table, document preview, expertise detail, bank account detail, rejection reason dialog.
- CTA: `Approve`, `Reject`.
- Empty State: tidak ada pengajuan pending.
- Error State: gagal update status verifikasi.

Detail yang wajib terlihat:

- Nama Teknisi.
- Keahlian.
- Pengalaman.
- KTP.
- Foto profil.
- Nama bank.
- Nomor rekening.
- Pemilik rekening.

## 5. Service Management

- Purpose: mengelola kategori layanan servis.
- Layout: table management.
- Components: service table, create button, edit dialog, active toggle.
- CTA: `Tambah Layanan`, `Simpan`, `Nonaktifkan`.
- Empty State: belum ada layanan.
- Error State: nama layanan duplikat, gagal menyimpan.

Kolom tabel:

- Icon.
- Service name.
- Description.
- Active status.
- Created date.
- Action.

## 6. Booking Monitoring

- Purpose: memonitor request, offer, dan booking.
- Layout: filterable data table dengan detail drawer.
- Components: status filter, date range, booking table, booking detail, timeline.
- CTA: `Lihat Detail`.
- Empty State: tidak ada booking sesuai filter.
- Error State: gagal load booking.

Kolom tabel:

- Booking ID.
- Customer.
- Technician.
- Service.
- Status.
- Payment status.
- Created date.
- Action.

## 7. Payment Monitoring

- Purpose: memonitor transaksi Midtrans.
- Layout: KPI row, filter bar, payment table.
- Components: payment status tabs, search Midtrans order ID, detail drawer.
- CTA: `Lihat Detail`, `Lihat Invoice`.
- Empty State: tidak ada pembayaran.
- Error State: gagal load payment atau sync status.

Kolom tabel:

- Midtrans order ID.
- Booking ID.
- Customer.
- Gross amount.
- Platform fee.
- Technician income.
- Payment method.
- Status.
- Paid date.

## 8. Invoice Monitoring

- Purpose: audit invoice transaksi.
- Layout: search-first table.
- Components: search invoice number, date filter, invoice table, invoice detail.
- CTA: `Lihat Invoice`.
- Empty State: invoice tidak ditemukan.
- Error State: gagal load invoice.

Kolom tabel:

- Invoice number.
- Booking ID.
- Customer.
- Technician.
- Total amount.
- Status.
- Issued date.
- Action.

## 9. Reports

- Purpose: memberi insight dasar performa marketplace.
- Layout: date range filter, summary cards, chart area, tables.
- Components: service demand chart, transaction summary, technician performance table.
- CTA: `Terapkan Filter`.
- Empty State: belum ada data laporan.
- Error State: gagal generate report.

Reports MVP:

- Total booking per status.
- Total payment paid.
- Total platform commission.
- Service category demand.
- Technician completed jobs.

## 10. Settings

- Purpose: mengelola konfigurasi dasar platform.
- Layout: grouped settings forms.
- Components: commission rate input, admin profile, general app info.
- CTA: `Simpan Pengaturan`.
- Empty State: tidak ada.
- Error State: komisi tidak valid, simpan gagal.

Settings MVP:

- Platform commission default 10 persen.
- Admin name.
- Admin email display.
- App support contact placeholder.


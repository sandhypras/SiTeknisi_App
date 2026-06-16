# UX Strategy

## 1. Target User

### Customer

Customer adalah pengguna yang membutuhkan jasa servis elektronik secara cepat, aman, dan terpercaya. Mereka dapat berupa pemilik rumah, mahasiswa, pekerja, atau pemilik usaha kecil yang memiliki perangkat seperti TV, kulkas, mesin cuci, AC, laptop, atau handphone yang perlu diperbaiki.

Kebutuhan utama Customer:

- Menemukan layanan servis yang sesuai.
- Mengirim masalah perangkat dengan mudah.
- Membandingkan penawaran harga dari Teknisi.
- Membayar secara aman.
- Mendapatkan invoice dan riwayat servis.
- Memantau status pekerjaan.

### Technician

Technician adalah penyedia jasa servis elektronik yang ingin mendapatkan pekerjaan dari platform digital. Mereka membutuhkan proses kerja yang ringkas, transparan, dan mendukung pengelolaan pendapatan.

Kebutuhan utama Technician:

- Mendaftar sebagai Teknisi dengan proses verifikasi jelas.
- Melihat permintaan servis yang relevan.
- Mengirim penawaran harga.
- Mengelola booking aktif.
- Mengubah status pekerjaan.
- Melihat pendapatan dan data rekening.

### Admin

Admin adalah pengelola operasional platform yang bertugas menjaga kualitas layanan, memverifikasi Teknisi, dan memonitor transaksi.

Kebutuhan utama Admin:

- Melihat ringkasan performa platform.
- Memverifikasi pengajuan Teknisi.
- Mengelola layanan.
- Memonitor booking, pembayaran, dan invoice.
- Menangani status transaksi secara cepat.

## 2. Pain Point

### Customer Pain Points

- Sulit menemukan Teknisi yang terpercaya.
- Harga servis tidak transparan.
- Komunikasi servis tidak terdokumentasi.
- Tidak ada status pengerjaan yang jelas.
- Pembayaran manual rawan tidak tercatat.
- Riwayat servis dan invoice sering hilang.

### Technician Pain Points

- Sulit mendapatkan pelanggan baru secara konsisten.
- Proses tawar-menawar tidak terstruktur.
- Tidak ada dashboard pekerjaan.
- Pendapatan sulit dilacak.
- Tidak ada validasi kepercayaan dari platform.

### Admin Pain Points

- Data pengguna, Teknisi, booking, dan pembayaran tersebar.
- Verifikasi Teknisi perlu informasi yang lengkap dan cepat dipindai.
- Monitoring transaksi memerlukan status yang mudah dibaca.
- Invoice dan pembayaran perlu jejak audit yang jelas.

## 3. User Goals

### Customer Goals

- Membuat request service kurang dari 3 menit.
- Menerima dan membandingkan offer dengan mudah.
- Memahami status booking tanpa bertanya manual.
- Menyelesaikan pembayaran dengan aman.
- Menyimpan invoice otomatis.

### Technician Goals

- Mendaftar dan mengetahui status verifikasi.
- Melihat request baru secara cepat.
- Mengirim offer yang jelas dan profesional.
- Mengelola pekerjaan aktif.
- Memantau pendapatan dari transaksi selesai.

### Admin Goals

- Mengambil keputusan verifikasi dengan percaya diri.
- Memonitor transaksi bermasalah.
- Menemukan data booking, payment, dan invoice secara cepat.
- Menjaga kualitas marketplace.

## 4. Design Goals

- Membuat pengalaman marketplace yang terasa terpercaya, jelas, dan cepat.
- Mengurangi beban kognitif pada proses request service dan payment.
- Membuat status transaksi terlihat eksplisit di setiap tahap.
- Menyediakan desain mobile yang nyaman untuk penggunaan harian.
- Menyediakan desain admin web yang padat, efisien, dan mudah dipindai.
- Menjaga konsistensi desain antara Customer App, Technician App, dan Admin Web.
- Menghasilkan spesifikasi yang siap digunakan di Stitch dan mudah diterjemahkan ke Flutter.

## 5. UX Principles

### Clarity First

Setiap layar harus menjawab tiga hal: pengguna sedang berada di tahap apa, data apa yang dibutuhkan, dan tindakan berikutnya apa.

### Trust by Design

Gunakan badge status, invoice, detail pembayaran, foto Teknisi, rating, dan informasi rekening secara hati-hati untuk membangun rasa aman.

### Guided Action

Proses kompleks seperti request service, technician application, dan payment harus dipecah menjadi langkah-langkah kecil dengan CTA yang jelas.

### Status Visibility

Status `pending`, `open`, `offered`, `confirmed`, `in_progress`, `completed`, `paid`, `failed`, dan `rejected` harus tampil konsisten dengan warna dan label yang mudah dipahami.

### Mobile Efficiency

Customer dan Technician harus dapat menyelesaikan tugas utama dengan satu tangan, melalui bottom navigation, CTA sticky, dan form yang ringkas.

### Admin Density

Admin Web harus mengutamakan tabel, filter, search, summary cards, dan layout yang efisien. Hindari tampilan promosi atau landing page.

## 6. Accessibility Requirements

- Minimum contrast ratio 4.5:1 untuk teks normal.
- Touch target minimal 44x44 px pada mobile.
- Semua icon penting harus memiliki label atau tooltip.
- Field error harus memiliki pesan teks, bukan hanya warna.
- Status badge harus menggabungkan warna dan teks.
- Form harus mendukung urutan fokus yang logis.
- Gunakan ukuran font minimum 12 px untuk caption dan 14 px untuk body.
- Jangan mengandalkan warna saja untuk membedakan status.
- Admin table harus tetap dapat dibaca pada layar laptop 1366 px.
- Komponen payment dan invoice harus menampilkan nominal dengan format mata uang yang jelas.


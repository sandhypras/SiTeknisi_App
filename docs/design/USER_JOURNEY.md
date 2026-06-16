# User Journey

Dokumen ini memetakan perjalanan pengguna untuk Customer, Technician, dan Admin.

## 1. Customer Journey

| Stage | Goals | Actions | Emotions | Pain Points |
|---|---|---|---|---|
| Discover | Menemukan layanan servis | Membuka aplikasi, melihat layanan populer, mencari kategori | Penasaran, berharap cepat | Tidak yakin layanan tersedia |
| Authenticate | Membuat akun agar bisa request | Login atau register | Sedikit ragu jika form panjang | Takut proses daftar lama |
| Request Service | Menjelaskan masalah perangkat | Pilih layanan, isi lokasi, deskripsi, jadwal, upload foto | Fokus, ingin cepat selesai | Bingung menulis masalah teknis |
| Wait for Offers | Menunggu penawaran | Melihat status request dan notifikasi offer | Cemas, menunggu kepastian | Tidak tahu kapan offer masuk |
| Compare Offers | Memilih Teknisi | Membandingkan harga, rating, pesan, estimasi | Lebih percaya diri | Sulit memilih jika informasi kurang |
| Payment | Membayar booking | Pilih metode pembayaran Midtrans, konfirmasi pembayaran | Hati-hati, butuh rasa aman | Takut payment gagal |
| Track Service | Memantau pengerjaan | Melihat status confirmed, in progress, completed | Tenang jika status jelas | Tidak ada update status |
| Invoice and Review | Menyimpan bukti dan menilai | Lihat invoice, beri rating dan komentar | Puas, lega | Invoice sulit ditemukan |

### Customer UX Opportunities

- Gunakan stepper pada request service.
- Sediakan contoh placeholder deskripsi masalah.
- Tampilkan empty state offer yang menenangkan.
- Tampilkan perbandingan offer yang mudah dipindai.
- Buat invoice mudah diakses dari payment success dan history.

## 2. Technician Journey

| Stage | Goals | Actions | Emotions | Pain Points |
|---|---|---|---|---|
| Join | Bergabung sebagai Teknisi | Mengisi data diri, keahlian, pengalaman, dokumen, rekening | Berharap diterima | Khawatir data ditolak |
| Verification | Menunggu keputusan Admin | Memantau status pending, approved, rejected | Tidak sabar, butuh kepastian | Tidak tahu alasan penolakan |
| Find Requests | Mendapat pekerjaan | Buka dashboard dan request terbuka | Antusias | Request tidak sesuai keahlian |
| Send Offer | Memberi harga | Baca detail request, isi harga dan pesan | Fokus, kompetitif | Takut harga terlalu tinggi atau rendah |
| Work | Menyelesaikan pekerjaan | Update status pekerjaan | Bertanggung jawab | Status update terlupa |
| Complete | Menutup booking | Tandai selesai, cek pendapatan | Puas | Pendapatan tidak jelas |
| Earnings | Memantau uang masuk | Lihat ringkasan job history dan bank account | Butuh transparansi | Komisi platform tidak terlihat |

### Technician UX Opportunities

- Tampilkan status verifikasi di dashboard.
- Buat request card padat dengan jarak, layanan, deskripsi, dan jadwal.
- Beri helper text pada input offer.
- Tampilkan breakdown harga, komisi, dan pendapatan.
- Gunakan timeline status pekerjaan yang mudah diubah.

## 3. Admin Journey

| Stage | Goals | Actions | Emotions | Pain Points |
|---|---|---|---|---|
| Login | Masuk ke dashboard | Mengisi email dan password | Netral, fokus | Lupa kredensial |
| Overview | Memahami kondisi platform | Melihat KPI booking, payment, verification | Terkendali | Data terlalu tersebar |
| Verify Technician | Menjaga kualitas Teknisi | Review data, dokumen, rekening, approve atau reject | Hati-hati | Dokumen sulit dibaca |
| Monitor Bookings | Memantau pekerjaan aktif | Filter status booking, buka detail | Fokus | Status tidak konsisten |
| Monitor Payments | Mendeteksi payment bermasalah | Filter pending, failed, paid | Waspada | Midtrans status tidak jelas |
| Monitor Invoices | Audit transaksi | Cari invoice, buka detail transaksi | Butuh akurasi | Nomor invoice sulit dicari |
| Reports | Menilai performa | Lihat tren transaksi dan layanan | Analitis | Export bukan prioritas MVP |

### Admin UX Opportunities

- Dashboard harus mengangkat pending verification dan payment issue.
- Tabel perlu search, filter status, dan badge yang konsisten.
- Detail Teknisi perlu panel dokumen yang besar dan readable.
- Payment detail perlu menampilkan Midtrans order ID.
- Invoice detail harus memuat total, komisi, dan pendapatan Teknisi.


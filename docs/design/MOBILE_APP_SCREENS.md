# Mobile App Screens

Dokumen ini merinci layar mobile untuk Customer dan Technician.

## 1. Splash

- Purpose: memperkenalkan brand dan memuat session awal.
- Components: logo, nama SiTeknisi, loading indicator.
- CTA: tidak ada.
- Empty State: tidak ada.
- Error State: jika session check gagal, arahkan ke Guest Home dengan snackbar error ringan.

## 2. Onboarding

- Purpose: menjelaskan manfaat utama aplikasi secara singkat.
- Components: visual servis elektronik, headline, body copy, pagination dots.
- CTA: `Mulai`, `Lewati`.
- Empty State: tidak ada.
- Error State: tidak ada.

## 3. Guest Home

- Purpose: memberi akses awal ke layanan tanpa login.
- Components: app bar, search bar, kategori populer, service grid, banner join Teknisi.
- CTA: `Login`, `Lihat Layanan`, `Request Service`.
- Empty State: tampilkan pesan jika layanan belum tersedia.
- Error State: tampilkan retry jika service list gagal dimuat.

## 4. Service Categories

- Purpose: membantu pengguna menemukan kategori servis.
- Components: search, filter chips, grid kategori, service card.
- CTA: `Lihat Detail`.
- Empty State: `Layanan tidak ditemukan`.
- Error State: retry load kategori.

## 5. Service Detail

- Purpose: menjelaskan layanan sebelum request.
- Components: service icon, nama, deskripsi, estimasi cakupan layanan, FAQ pendek.
- CTA: `Request Service`.
- Empty State: jika data layanan hilang, tampilkan fallback not found.
- Error State: retry load detail.

## 6. Login

- Purpose: mengautentikasi user.
- Components: email field, password field, show password, forgot password placeholder.
- CTA: `Masuk`, `Daftar`.
- Empty State: tidak ada.
- Error State: email/password salah, akun tidak ditemukan, network error.

## 7. Register

- Purpose: membuat akun Customer.
- Components: full name, email, phone, password, confirm password.
- CTA: `Daftar`, `Masuk`.
- Empty State: tidak ada.
- Error State: email sudah digunakan, password lemah, field wajib kosong.

## 8. Home Dashboard

- Purpose: pusat aktivitas Customer setelah login.
- Components: greeting, search, active booking card, service categories, recent history.
- CTA: `Request Service`, `Lihat Semua`.
- Empty State: jika tidak ada booking aktif, tampilkan ajakan mulai servis.
- Error State: retry untuk data dashboard.

## 9. Create Service Request

- Purpose: mengumpulkan informasi masalah perangkat.
- Components: selected service, title field, description textarea, address field, location picker, schedule picker.
- CTA: `Lanjut Upload Foto`.
- Empty State: tidak ada.
- Error State: validasi field wajib, lokasi gagal dibaca.

## 10. Upload Damage Photo

- Purpose: menambahkan bukti visual kerusakan.
- Components: upload area, preview image, remove image, helper text.
- CTA: `Kirim Request`.
- Empty State: tampilkan upload placeholder.
- Error State: file terlalu besar, format tidak didukung, upload gagal.

## 11. Technician Offer List

- Purpose: menampilkan offer dari Teknisi.
- Components: request summary, offer list, sort chip, empty waiting illustration.
- CTA: `Lihat Offer`.
- Empty State: `Belum ada penawaran. Kami akan menampilkan offer saat Teknisi merespons.`
- Error State: retry load offers.

## 12. Offer Detail

- Purpose: membantu Customer memilih Teknisi.
- Components: technician profile, rating, offer price, message, price breakdown.
- CTA: `Pilih Offer`.
- Empty State: jika offer tidak ditemukan, tampilkan not found.
- Error State: gagal accept offer, tampilkan retry.

## 13. Payment Method

- Purpose: memilih dan memulai pembayaran.
- Components: booking summary, total amount, method list, Midtrans note.
- CTA: `Bayar Sekarang`.
- Empty State: tidak ada metode pembayaran tersedia.
- Error State: gagal membuat payment session.

## 14. Payment Success

- Purpose: mengonfirmasi pembayaran berhasil.
- Components: success icon, total amount, invoice number, payment method.
- CTA: `Lihat Invoice`, `Tracking Booking`.
- Empty State: tidak ada.
- Error State: jika invoice belum tersedia, tampilkan loading dan retry.

## 15. Invoice

- Purpose: menampilkan bukti pembayaran.
- Components: invoice number, customer info, technician info, service info, total, platform fee, technician income, status.
- CTA: `Kembali ke Booking`, `Bagikan` sebagai placeholder.
- Empty State: invoice belum terbit.
- Error State: gagal load invoice.

## 16. Booking Tracking

- Purpose: memantau status pekerjaan.
- Components: booking summary, status timeline, technician card, payment status, schedule.
- CTA: `Beri Review` jika completed.
- Empty State: tidak ada booking aktif.
- Error State: retry load booking.

## 17. Booking History

- Purpose: melihat riwayat servis.
- Components: search, status tabs, booking cards.
- CTA: `Lihat Detail`, `Lihat Invoice`.
- Empty State: `Belum ada riwayat servis`.
- Error State: retry load history.

## 18. Review

- Purpose: memberi rating kepada Teknisi.
- Components: technician summary, star rating, comment textarea.
- CTA: `Kirim Review`.
- Empty State: tidak ada.
- Error State: rating belum dipilih, submit gagal.

## 19. Profile

- Purpose: mengelola akun Customer.
- Components: avatar, name, phone, menu list, join technician card.
- CTA: `Join As Technician`, `Logout`.
- Empty State: avatar fallback initial.
- Error State: gagal load profile.

## 20. Join As Technician

- Purpose: menjelaskan proses bergabung sebagai Teknisi.
- Components: benefit list, requirement list, verification steps.
- CTA: `Ajukan Sekarang`.
- Empty State: tidak ada.
- Error State: jika sudah pernah apply, arahkan ke status pengajuan.

## 21. Technician Application Form

- Purpose: mengumpulkan data verifikasi Teknisi.
- Components: expertise, experience, KTP upload, profile photo upload, bank name, account number, account holder.
- CTA: `Kirim Pengajuan`.
- Empty State: upload placeholders.
- Error State: dokumen wajib, rekening wajib, submit gagal.

## 22. Technician Dashboard

- Purpose: ringkasan kerja Teknisi.
- Components: verification banner, active jobs KPI, pending offers KPI, earnings card, new request preview.
- CTA: `Lihat Request`, `Lengkapi Verifikasi`.
- Empty State: belum ada pekerjaan aktif.
- Error State: retry load dashboard.

## 23. Incoming Requests

- Purpose: melihat request terbuka.
- Components: search, filter category, request cards, location and schedule metadata.
- CTA: `Lihat Detail`, `Kirim Offer`.
- Empty State: `Belum ada request baru`.
- Error State: retry load requests.

## 24. Create Offer

- Purpose: mengirim penawaran harga.
- Components: request summary, price input, message textarea, earnings after commission preview.
- CTA: `Kirim Offer`.
- Empty State: tidak ada.
- Error State: harga wajib lebih dari 0, submit gagal.

## 25. Job History

- Purpose: melihat pekerjaan aktif dan selesai.
- Components: tabs active/completed, job cards, status badge, amount.
- CTA: `Lihat Detail`.
- Empty State: belum ada job history.
- Error State: retry load jobs.

## 26. Earnings

- Purpose: menampilkan pendapatan Teknisi.
- Components: total earnings, platform fee note, transaction list, monthly summary.
- CTA: `Kelola Rekening`.
- Empty State: belum ada pendapatan.
- Error State: retry load earnings.

## 27. Bank Account

- Purpose: menyimpan data rekening Teknisi.
- Components: bank name, account number, holder name, verification note.
- CTA: `Simpan Rekening`.
- Empty State: rekening belum ditambahkan.
- Error State: nomor rekening tidak valid, simpan gagal.


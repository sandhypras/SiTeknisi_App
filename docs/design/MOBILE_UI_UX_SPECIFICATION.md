# Mobile UI/UX Specification

Dokumen ini adalah spesifikasi desain mobile SiTeknisi untuk Android. Fokusnya adalah Customer Experience, Service Request Flow, Offer Comparison, Payment, Tracking, dan Technician Productivity. Dokumen ini siap dipakai sebagai acuan Stitch dan implementasi Flutter UI.

## 1. Design Direction

SiTeknisi Mobile harus terasa seperti marketplace jasa yang profesional, cepat, dan dapat dipercaya. Kualitas visual mengarah ke aplikasi operasional modern seperti Gojek, Grab, dan Urban Company: bersih, informatif, mobile-first, penuh status yang jelas, dan tidak terasa seperti landing page.

Prinsip desain:

- **Fast to action:** Customer harus bisa request servis dalam beberapa langkah yang jelas.
- **Trust at every step:** tampilkan rating, badge verifikasi, invoice, status pembayaran, dan breakdown biaya.
- **Status visible:** request, offer, booking, payment, invoice, dan job selalu punya status yang mudah dipahami.
- **Technician productivity:** Teknisi butuh daftar request yang cepat dipindai, offer cepat dibuat, status pekerjaan cepat diperbarui.
- **Consistent with Admin Web:** warna, badge, tabel/list density, radius, dan bahasa status konsisten dengan dashboard admin.
- **Flutter ready:** layout memakai pola Material 3, AppBar, BottomNavigationBar/NavigationBar, Cards, Chips, BottomSheet, Dialog, FormField, dan ListView.

## 2. Visual System

| Token | Value | Usage |
|---|---|---|
| Primary | `#2563EB` | CTA utama, active navigation, link |
| Secondary | `#F97316` | CTA pendukung, harga, earning, aksen penting |
| Background | `#F8FAFC` | Screen background |
| Surface | `#FFFFFF` | Card, sheet, dialog |
| Success | `#22C55E` | Paid, completed, approved |
| Warning | `#EAB308` | Pending, waiting, review needed |
| Error | `#EF4444` | Failed, rejected, destructive |
| Text Primary | `#0F172A` | Heading, primary content |
| Text Secondary | `#475569` | Body supporting text |
| Text Muted | `#64748B` | Helper, metadata |
| Border | `#E2E8F0` | Dividers, cards, inputs |

Typography:

- Display: 32/40, weight 700.
- Headline: 24/32, weight 700.
- Title: 18/26, weight 600.
- Body: 14/22, weight 400.
- Label: 12/16, weight 600.

Shape and spacing:

- Main radius: 16 px.
- Input radius: 12 px.
- Button height: 48 px.
- Touch target minimum: 44 px.
- Screen horizontal padding: 16 px.
- Spacing scale: 8, 12, 16, 24, 32.

## 3. Mobile Navigation

### Customer Navigation

Bottom navigation:

- Home
- Booking
- History
- Profile

Nested screens use App Bar with back button. Task-heavy screens use sticky bottom CTA.

### Technician Navigation

Bottom navigation:

- Dashboard
- Requests
- Jobs
- Earnings
- Profile

Technician screens prioritize lists, status chips, price information, and quick actions.

## 4. Reusable Components

### App Bar

- Height 56 px.
- Background follows screen background or white surface.
- Left: back button for nested screens, logo for root screens.
- Center or left title depending hierarchy.
- Right actions: notification, help, search, overflow.
- Loading: show subtle linear progress under AppBar when refreshing.
- Error: can show compact banner below AppBar.

### Bottom Navigation

- Material 3 NavigationBar style.
- Height 72 px.
- Active icon uses primary tonal pill.
- Label always visible for clarity.
- Root screens only.

### Navigation Drawer

- Optional for Technician secondary utilities.
- Contains profile summary, role badge, app settings, help, logout.
- Use only when menu depth grows; bottom navigation remains primary.

### Search Bar

- Height 48 px.
- Leading search icon.
- Placeholder contextual: `Cari layanan`, `Cari booking`, `Cari request`.
- Clear icon when text exists.
- Empty state must mention the active query.
- Use debounce in implementation.

### Service Cards

- Surface white, radius 16, border `#E2E8F0`.
- Content: service icon/photo, name, short description, active indicator, chevron.
- Grid for categories, list for search results.

### Technician Cards

- Content: avatar, name, verified badge, rating, completed jobs, specialization, distance.
- Use in offer detail and offer comparison.
- Trust elements must be visible above fold.

### Offer Cards

- Content: technician summary, offer price, message preview, estimated arrival/time, rating, status.
- Primary action: `Lihat Detail` or `Pilih`.
- Highlight best value with secondary accent only when justified.

### Payment Cards

- Content: method icon, method name, description, availability badge.
- Selected state uses primary border and check icon.
- Failed state uses error border and message.

### Invoice Cards

- Content: invoice number, service, total, status, issued date.
- Detail screen includes customer, technician, platform fee, technician income, payment method.

### Status Chips

Use text plus color:

- Pending: warning tint.
- Approved/Paid/Completed: success tint.
- Rejected/Failed: error tint.
- Open/Offered/Confirmed/In Progress: primary/info tint.
- Cancelled/Expired: neutral tint.

### Buttons

- Primary: full-width for main mobile CTA.
- Secondary: offer, earning, technician actions.
- Outline: back, cancel, view detail.
- Text: login/register links, skip, view all.
- Destructive: logout, delete, cancel booking.
- States: default, pressed, loading, disabled, success feedback.

### Forms

- One logical field group per section.
- Use helper text for technical inputs.
- Show inline validation near fields.
- Currency inputs use Rupiah format.
- File upload fields show accepted type and max size.

### Dialogs

- Use for confirmation: choose offer, payment, logout, cancel.
- Destructive action requires clear copy.
- Keep action pair: secondary left, primary right.

### Bottom Sheets

- Use for filters, sorting, payment method details, status update.
- Include drag handle, title, option list, and sticky apply CTA when needed.

### Image Upload Components

- Empty: dashed border area with icon and helper text.
- Uploaded: thumbnail preview, file name, remove action.
- Uploading: progress bar.
- Error: red border and retry action.
- Use for damage photo, KTP, and profile photo.

## 5. Screen Specifications

Format setiap layar: Purpose, Layout Structure, Components Used, Primary CTA, Secondary CTA, Loading State, Empty State, Error State, Success State.

### Authentication

#### 1. Splash Screen

- Purpose: memuat session dan memperkenalkan brand.
- Layout Structure: centered logo, app name, loading indicator, version label at bottom.
- Components Used: logo, circular progress, text label.
- Primary CTA: none.
- Secondary CTA: none.
- Loading State: circular progress active.
- Empty State: none.
- Error State: session check gagal, route ke Guest Home dengan snackbar.
- Success State: route ke Dashboard sesuai role atau Guest Home.

#### 2. Onboarding Screen 1

- Purpose: mengenalkan manfaat menemukan teknisi terpercaya.
- Layout Structure: top illustration/photo, headline, short copy, dots, bottom CTA.
- Components Used: image hero, page indicator, primary button, text button.
- Primary CTA: `Mulai`.
- Secondary CTA: `Lewati`.
- Loading State: image skeleton.
- Empty State: fallback icon jika image gagal.
- Error State: none critical.
- Success State: lanjut ke onboarding berikutnya.

#### 3. Onboarding Screen 2

- Purpose: menjelaskan offer comparison dan harga transparan.
- Layout Structure: comparison visual, headline, 2-3 benefit chips, dots, CTA.
- Components Used: offer mini cards, chips, primary button.
- Primary CTA: `Lanjut`.
- Secondary CTA: `Lewati`.
- Loading State: visual skeleton.
- Empty State: fallback illustration.
- Error State: none critical.
- Success State: lanjut ke screen 3.

#### 4. Onboarding Screen 3

- Purpose: menekankan pembayaran aman, invoice, dan tracking.
- Layout Structure: payment/tracking visual, headline, supporting copy, dots, CTA.
- Components Used: invoice preview, status timeline, primary button.
- Primary CTA: `Mulai Sekarang`.
- Secondary CTA: `Masuk`.
- Loading State: none.
- Empty State: none.
- Error State: none.
- Success State: route ke Guest Home atau Login.

#### 5. Login Screen

- Purpose: autentikasi Customer atau Technician.
- Layout Structure: app logo, title, email field, password field, forgot password link, CTA, register link.
- Components Used: AppBar optional, text fields, password visibility icon, buttons.
- Primary CTA: `Masuk`.
- Secondary CTA: `Daftar`.
- Loading State: button spinner and fields disabled.
- Empty State: none.
- Error State: invalid credential, network error, role not allowed.
- Success State: route based on role and verification status.

#### 6. Register Screen

- Purpose: membuat akun baru Customer.
- Layout Structure: title, name, phone, email, password, terms note, CTA.
- Components Used: form fields, checkbox/terms text, primary button.
- Primary CTA: `Daftar`.
- Secondary CTA: `Masuk`.
- Loading State: submit button loading.
- Empty State: none.
- Error State: email already used, password weak, required fields missing.
- Success State: account created and route to Customer Dashboard.

#### 7. Forgot Password

- Purpose: membantu user meminta reset password.
- Layout Structure: title, instruction, email field, CTA, back to login.
- Components Used: text field, info card, primary button.
- Primary CTA: `Kirim Link Reset`.
- Secondary CTA: `Kembali ke Login`.
- Loading State: button spinner.
- Empty State: none.
- Error State: email invalid or request failed.
- Success State: confirmation card `Link reset sudah dikirim`.

### Customer

#### 8. Guest Home

- Purpose: browse layanan tanpa login dan mengarahkan ke auth saat ingin request.
- Layout Structure: logo app bar, login action, search bar, popular service grid, promo/join technician banner, service list.
- Components Used: AppBar, Search Bar, Service Cards, banner card.
- Primary CTA: `Request Service`.
- Secondary CTA: `Masuk`.
- Loading State: service card skeleton.
- Empty State: `Layanan belum tersedia`.
- Error State: failed load services with retry.
- Success State: service list visible.

#### 9. Service Categories

- Purpose: menampilkan kategori servis elektronik.
- Layout Structure: AppBar, search bar, filter chips, 2-column category grid.
- Components Used: Search Bar, Filter Chips, Service Cards.
- Primary CTA: `Lihat Detail`.
- Secondary CTA: `Reset Filter`.
- Loading State: grid skeleton.
- Empty State: `Kategori tidak ditemukan`.
- Error State: retry card.
- Success State: selected category opens Service Detail.

#### 10. Service Detail

- Purpose: memberi detail layanan sebelum request.
- Layout Structure: service image/icon, title, rating/usage stats, description, included services, FAQ, sticky CTA.
- Components Used: AppBar, image banner, chips, accordion, sticky button.
- Primary CTA: `Request Service`.
- Secondary CTA: `Bagikan` or `Kembali`.
- Loading State: detail skeleton.
- Empty State: service not found.
- Error State: failed load detail.
- Success State: user proceeds to request or login.

#### 11. Search Services

- Purpose: mencari layanan berdasarkan nama dan kebutuhan.
- Layout Structure: search input fixed top, recent searches, result list, filters.
- Components Used: Search Bar, Filter Chips, Service List Cards.
- Primary CTA: `Pilih Layanan`.
- Secondary CTA: `Hapus Riwayat`.
- Loading State: result skeleton.
- Empty State: `Tidak ada layanan untuk pencarian ini`.
- Error State: search failed.
- Success State: result opens Service Detail.

#### 12. Customer Dashboard

- Purpose: home authenticated untuk memulai servis dan memantau booking aktif.
- Layout Structure: greeting, location summary, search, active booking card, category grid, recent history preview, bottom nav.
- Components Used: Bottom Navigation, Booking Card, Service Cards, Section Headers.
- Primary CTA: `Request Service`.
- Secondary CTA: `Lihat Semua`.
- Loading State: dashboard skeleton.
- Empty State: no active booking card with `Mulai Servis`.
- Error State: retry dashboard.
- Success State: dashboard data loaded.

### Booking

#### 13. Create Service Request

- Purpose: mengumpulkan detail masalah servis.
- Layout Structure: stepper, selected service summary, title field, description, schedule, sticky CTA.
- Components Used: Stepper, Form Fields, Date/Time Picker, Summary Card.
- Primary CTA: `Lanjut Pilih Lokasi`.
- Secondary CTA: `Simpan Draft`.
- Loading State: loading selected service.
- Empty State: service not selected.
- Error State: required fields missing.
- Success State: request info valid.

#### 14. Location Picker

- Purpose: memilih alamat dan titik lokasi servis.
- Layout Structure: search address, map preview, current location button, address detail form, CTA.
- Components Used: Search Bar, Map Placeholder, Location Card, Text Fields.
- Primary CTA: `Gunakan Lokasi Ini`.
- Secondary CTA: `Gunakan Lokasi Saat Ini`.
- Loading State: locating spinner.
- Empty State: no address selected.
- Error State: GPS denied, address not found.
- Success State: selected address saved.

#### 15. Upload Damage Photo

- Purpose: upload foto kerusakan untuk membantu estimasi.
- Layout Structure: request summary, upload area, preview grid, helper text, sticky CTA.
- Components Used: Image Upload, Thumbnail Preview, Primary Button.
- Primary CTA: `Kirim Request`.
- Secondary CTA: `Lewati Foto` only if business allows.
- Loading State: upload progress.
- Empty State: empty upload placeholder.
- Error State: file too large, upload failed.
- Success State: photo uploaded and request ready.

#### 16. Request Submitted Success

- Purpose: memberi kepastian bahwa request sudah terkirim.
- Layout Structure: success icon, title, request number, next-step explanation, CTA group.
- Components Used: Success State, Info Card, Buttons.
- Primary CTA: `Lihat Penawaran`.
- Secondary CTA: `Kembali ke Home`.
- Loading State: waiting for request confirmation.
- Empty State: none.
- Error State: request submit failed with retry.
- Success State: request status `Open`.

### Offers

#### 17. Technician Offer List

- Purpose: melihat offer yang masuk dari Teknisi.
- Layout Structure: request summary, sort/filter bar, offer list.
- Components Used: Offer Cards, Filter Chips, Status Chips.
- Primary CTA: `Lihat Detail`.
- Secondary CTA: `Bandingkan`.
- Loading State: offer list skeleton.
- Empty State: waiting state `Belum ada penawaran`.
- Error State: failed load offers.
- Success State: offers visible and comparable.

#### 18. Offer Comparison Screen

- Purpose: membantu Customer membandingkan harga, rating, waktu, dan trust.
- Layout Structure: comparison table/card stack, pinned request summary, best-value indicator.
- Components Used: Technician Cards, Offer Cards, Comparison Rows, Chips.
- Primary CTA: `Pilih Teknisi`.
- Secondary CTA: `Lihat Detail`.
- Loading State: comparison skeleton.
- Empty State: need at least two offers; show single-offer guidance.
- Error State: comparison data failed.
- Success State: selected offer goes to confirmation/payment.

#### 19. Offer Detail Screen

- Purpose: memberi detail lengkap sebelum memilih Teknisi.
- Layout Structure: technician profile header, rating, specialization, message, price breakdown, estimated arrival, sticky CTA.
- Components Used: Technician Card, Price Breakdown Card, Status Chip, Button.
- Primary CTA: `Pilih Penawaran Ini`.
- Secondary CTA: `Kembali ke Daftar`.
- Loading State: detail skeleton.
- Empty State: offer not found.
- Error State: accept offer failed.
- Success State: booking created with `pending_payment`.

### Payment

#### 20. Payment Method

- Purpose: memilih metode pembayaran Midtrans.
- Layout Structure: booking summary, method list, payment note, sticky CTA.
- Components Used: Payment Cards, Radio Selection, Summary Card.
- Primary CTA: `Lanjut ke Ringkasan`.
- Secondary CTA: `Kembali`.
- Loading State: payment methods loading.
- Empty State: payment method unavailable.
- Error State: failed load method.
- Success State: method selected.

#### 21. Payment Summary

- Purpose: review biaya sebelum bayar.
- Layout Structure: service/booking summary, price rows, platform fee, total, terms note, CTA.
- Components Used: Price Breakdown, Invoice Preview Card, Button.
- Primary CTA: `Bayar Sekarang`.
- Secondary CTA: `Ganti Metode`.
- Loading State: creating Midtrans transaction.
- Empty State: booking not found.
- Error State: payment session failed.
- Success State: redirect/open Midtrans payment flow.

#### 22. Payment Success

- Purpose: mengonfirmasi pembayaran berhasil dan memberi akses invoice/tracking.
- Layout Structure: success icon, title, total, invoice number, CTA group.
- Components Used: Success State, Invoice Card, Buttons.
- Primary CTA: `Lihat Invoice`.
- Secondary CTA: `Lacak Booking`.
- Loading State: invoice generation loading.
- Empty State: invoice pending message.
- Error State: payment paid but invoice failed to load, retry.
- Success State: payment `paid`, invoice `issued`.

### Tracking

#### 23. Booking Tracking

- Purpose: memantau progres servis secara real-time.
- Layout Structure: booking summary, vertical timeline, technician card, payment chip, CTA.
- Components Used: Timeline, Technician Card, Status Chips, Bottom CTA.
- Primary CTA: `Beri Review` when completed.
- Secondary CTA: `Lihat Detail`.
- Loading State: timeline skeleton.
- Empty State: no active booking.
- Error State: failed load tracking.
- Success State: current status highlighted.

#### 24. Booking Detail

- Purpose: melihat detail booking lengkap.
- Layout Structure: service info, customer address, technician info, offer detail, payment status, timeline.
- Components Used: Cards, Status Chips, Timeline, Price Breakdown.
- Primary CTA: context-based `Bayar`, `Lacak`, or `Review`.
- Secondary CTA: `Lihat Invoice`.
- Loading State: detail skeleton.
- Empty State: booking not found.
- Error State: retry detail.
- Success State: booking data shown.

#### 25. Booking History

- Purpose: menampilkan riwayat booking Customer.
- Layout Structure: search, status tabs, booking list.
- Components Used: Search Bar, Tabs, Booking Cards.
- Primary CTA: `Lihat Detail`.
- Secondary CTA: `Lihat Invoice`.
- Loading State: list skeleton.
- Empty State: `Belum ada riwayat servis`.
- Error State: failed load history.
- Success State: history list loaded.

### Invoice

#### 26. Invoice Detail

- Purpose: menampilkan bukti transaksi.
- Layout Structure: invoice header, status, customer/technician, service, payment breakdown, date.
- Components Used: Invoice Card, Price Breakdown, Status Chip.
- Primary CTA: `Download Invoice`.
- Secondary CTA: `Bagikan`.
- Loading State: invoice skeleton.
- Empty State: invoice not generated.
- Error State: failed load invoice.
- Success State: invoice visible with status `LUNAS`.

#### 27. Download Invoice

- Purpose: memberi feedback proses download invoice.
- Layout Structure: file preview card, invoice metadata, download progress, CTA.
- Components Used: Progress Indicator, Invoice Card, Dialog/Bottom Sheet.
- Primary CTA: `Simpan ke Perangkat`.
- Secondary CTA: `Kembali`.
- Loading State: download progress.
- Empty State: file not available.
- Error State: download failed with retry.
- Success State: `Invoice berhasil diunduh`.

### Review

#### 28. Rating Screen

- Purpose: memilih rating cepat setelah booking selesai.
- Layout Structure: technician summary, large star selector, rating labels.
- Components Used: Technician Card, Star Rating, Primary Button.
- Primary CTA: `Lanjut Tulis Review`.
- Secondary CTA: `Lewati`.
- Loading State: submit rating loading.
- Empty State: none.
- Error State: rating required.
- Success State: rating selected.

#### 29. Review Screen

- Purpose: mengirim ulasan lengkap.
- Layout Structure: rating summary, comment field, suggestion chips, CTA.
- Components Used: Text Area, Chips, Star Rating, Button.
- Primary CTA: `Kirim Review`.
- Secondary CTA: `Kembali`.
- Loading State: submit loading.
- Empty State: optional comment can be empty if rating exists.
- Error State: submit failed.
- Success State: review saved and shown in history.

### Profile

#### 30. Profile Screen

- Purpose: mengelola akun dan akses join Teknisi.
- Layout Structure: profile header, account menu, support menu, join technician card, logout.
- Components Used: Avatar, Menu List, Cards, Button.
- Primary CTA: `Join As Technician`.
- Secondary CTA: `Edit Profil`.
- Loading State: profile skeleton.
- Empty State: avatar initials fallback.
- Error State: failed load profile.
- Success State: profile visible.

#### 31. Edit Profile

- Purpose: memperbarui data Customer.
- Layout Structure: avatar editor, name, phone, email read-only, save CTA.
- Components Used: Image Upload, Text Fields, Button.
- Primary CTA: `Simpan Perubahan`.
- Secondary CTA: `Batal`.
- Loading State: saving spinner.
- Empty State: none.
- Error State: invalid phone, upload failed.
- Success State: snackbar `Profil diperbarui`.

#### 32. Settings

- Purpose: mengatur preferensi aplikasi.
- Layout Structure: grouped setting list, notification toggle, language placeholder, privacy, logout.
- Components Used: Switches, List Tiles, Dialogs.
- Primary CTA: context-based save if needed.
- Secondary CTA: `Logout`.
- Loading State: settings loading.
- Empty State: none.
- Error State: failed update setting.
- Success State: setting saved.

#### 33. Help Center

- Purpose: membantu pengguna menyelesaikan masalah umum.
- Layout Structure: search FAQ, category cards, FAQ list, contact support card.
- Components Used: Search Bar, Accordion, Cards.
- Primary CTA: `Hubungi Bantuan`.
- Secondary CTA: `Lihat FAQ`.
- Loading State: FAQ skeleton.
- Empty State: no FAQ result.
- Error State: failed load help content.
- Success State: FAQ answer expanded.

### Technician Registration

#### 34. Join As Technician

- Purpose: menjelaskan benefit dan syarat menjadi Teknisi.
- Layout Structure: hero benefit, requirement list, process stepper, sticky CTA.
- Components Used: Info Cards, Stepper, Button.
- Primary CTA: `Ajukan Sekarang`.
- Secondary CTA: `Pelajari Syarat`.
- Loading State: none.
- Empty State: none.
- Error State: existing application routes to status.
- Success State: open application form.

#### 35. Technician Application Form

- Purpose: mengumpulkan data keahlian dan pengalaman.
- Layout Structure: stepper, expertise dropdown, experience input, service skill chips, CTA.
- Components Used: Form Fields, Chips, Stepper.
- Primary CTA: `Lanjut Upload KTP`.
- Secondary CTA: `Simpan Draft`.
- Loading State: form initial loading.
- Empty State: no skill selected.
- Error State: required fields missing.
- Success State: expertise data saved locally.

#### 36. Upload KTP

- Purpose: upload dokumen identitas untuk verifikasi.
- Layout Structure: instruction card, KTP upload area, preview, privacy note.
- Components Used: Image Upload, Info Card, Button.
- Primary CTA: `Lanjut Upload Foto Profil`.
- Secondary CTA: `Ganti Foto`.
- Loading State: upload progress.
- Empty State: upload placeholder.
- Error State: blurry image, file too large, upload failed.
- Success State: KTP uploaded.

#### 37. Upload Profile Photo

- Purpose: menambahkan foto profil Teknisi untuk trust.
- Layout Structure: photo guide, upload area, circular preview, CTA.
- Components Used: Image Upload, Avatar Preview, Button.
- Primary CTA: `Lanjut Data Rekening`.
- Secondary CTA: `Ambil Ulang`.
- Loading State: upload progress.
- Empty State: camera placeholder.
- Error State: face not visible guidance, upload failed.
- Success State: profile photo uploaded.

#### 38. Bank Account Information

- Purpose: menyimpan rekening pencairan Teknisi.
- Layout Structure: bank name dropdown, account number, account holder, security note, CTA.
- Components Used: Form Fields, Info Card, Button.
- Primary CTA: `Kirim Pengajuan`.
- Secondary CTA: `Kembali`.
- Loading State: validating/submitting.
- Empty State: none.
- Error State: bank/account required, submit failed.
- Success State: application submitted.

#### 39. Application Submitted

- Purpose: memberi kepastian pengajuan sedang diverifikasi.
- Layout Structure: success/waiting icon, application status, estimated review note, CTA.
- Components Used: Status Card, Timeline, Button.
- Primary CTA: `Lihat Status`.
- Secondary CTA: `Kembali ke Profile`.
- Loading State: checking status.
- Empty State: none.
- Error State: status failed to load.
- Success State: status `Pending` displayed.

### Technician App

#### 40. Technician Dashboard

- Purpose: ringkasan produktivitas Teknisi.
- Layout Structure: greeting, verification badge, KPI cards, active job preview, incoming request preview, bottom nav.
- Components Used: KPI Cards, Request Cards, Job Cards, Bottom Navigation.
- Primary CTA: `Lihat Request`.
- Secondary CTA: `Lihat Earnings`.
- Loading State: dashboard skeleton.
- Empty State: no active job with browse requests CTA.
- Error State: failed load dashboard.
- Success State: dashboard metrics shown.

#### 41. Incoming Requests

- Purpose: melihat request terbuka yang bisa diberi offer.
- Layout Structure: search, category filter, distance/schedule filter, request list.
- Components Used: Search Bar, Filter Chips, Request Cards.
- Primary CTA: `Kirim Offer`.
- Secondary CTA: `Lihat Detail`.
- Loading State: request skeleton.
- Empty State: `Belum ada request baru`.
- Error State: failed load requests.
- Success State: request list loaded.

#### 42. Request Detail

- Purpose: memahami kebutuhan Customer sebelum offer.
- Layout Structure: service header, issue description, photos, address, schedule, customer note, CTA.
- Components Used: Image Carousel, Detail Cards, Map Preview, Button.
- Primary CTA: `Buat Offer`.
- Secondary CTA: `Kembali`.
- Loading State: detail skeleton.
- Empty State: request not found.
- Error State: failed load request.
- Success State: full request shown.

#### 43. Create Offer

- Purpose: membuat penawaran harga.
- Layout Structure: request summary, price input, message, estimated time, earning after commission, CTA.
- Components Used: Currency Field, Text Area, Price Preview, Button.
- Primary CTA: `Kirim Offer`.
- Secondary CTA: `Simpan Draft`.
- Loading State: submit loading.
- Empty State: none.
- Error State: price <= 0, message too short, submit failed.
- Success State: offer sent with status `Pending`.

#### 44. Active Jobs

- Purpose: daftar pekerjaan aktif Teknisi.
- Layout Structure: status tabs, active job cards, quick status action.
- Components Used: Tabs, Job Cards, Status Chips.
- Primary CTA: `Update Status`.
- Secondary CTA: `Lihat Detail`.
- Loading State: jobs skeleton.
- Empty State: no active jobs.
- Error State: failed load jobs.
- Success State: active jobs listed.

#### 45. Job Detail

- Purpose: melihat detail pekerjaan yang sedang berjalan.
- Layout Structure: customer/service header, address, timeline, payment info, request photo, CTA.
- Components Used: Timeline, Map Preview, Price Card, Status Chip.
- Primary CTA: `Update Status`.
- Secondary CTA: `Lihat Invoice`.
- Loading State: detail skeleton.
- Empty State: job not found.
- Error State: failed load job.
- Success State: job details visible.

#### 46. Update Job Status

- Purpose: memperbarui status pekerjaan.
- Layout Structure: current status, selectable next status, note field, confirmation CTA.
- Components Used: Bottom Sheet or Screen, Radio List, Text Area, Dialog.
- Primary CTA: `Simpan Status`.
- Secondary CTA: `Batal`.
- Loading State: saving status.
- Empty State: no next status available.
- Error State: invalid transition or save failed.
- Success State: status updated and timeline refreshed.

#### 47. Completed Jobs

- Purpose: melihat pekerjaan selesai.
- Layout Structure: date filter, completed job list, earning amount, review summary.
- Components Used: Filter Chips, Job Cards, Rating Display.
- Primary CTA: `Lihat Detail`.
- Secondary CTA: `Lihat Earnings`.
- Loading State: list skeleton.
- Empty State: no completed jobs.
- Error State: failed load completed jobs.
- Success State: completed jobs listed.

#### 48. Earnings Dashboard

- Purpose: memantau pendapatan Teknisi.
- Layout Structure: total earning card, this month card, commission note, transaction list.
- Components Used: KPI Cards, Transaction List, Info Card.
- Primary CTA: `Kelola Rekening`.
- Secondary CTA: `Lihat Detail`.
- Loading State: earning skeleton.
- Empty State: no earnings yet.
- Error State: failed load earnings.
- Success State: earning metrics shown.

#### 49. Earnings Detail

- Purpose: melihat breakdown pendapatan per transaksi.
- Layout Structure: summary header, filter by month, transaction rows, fee breakdown.
- Components Used: Filter Chips, Transaction Cards, Price Breakdown.
- Primary CTA: `Lihat Job`.
- Secondary CTA: `Export` placeholder if future.
- Loading State: transaction skeleton.
- Empty State: no transactions for period.
- Error State: failed load transactions.
- Success State: transactions shown.

#### 50. Bank Account Management

- Purpose: mengelola rekening pencairan Teknisi.
- Layout Structure: current account card, edit form, verification status, save CTA.
- Components Used: Form Fields, Status Chip, Info Card.
- Primary CTA: `Simpan Rekening`.
- Secondary CTA: `Batal`.
- Loading State: saving/loading bank data.
- Empty State: no bank account added.
- Error State: invalid account, save failed.
- Success State: account saved.

#### 51. Technician Profile

- Purpose: mengelola profil profesional Teknisi.
- Layout Structure: avatar, verification badge, expertise, rating, completed jobs, menu list.
- Components Used: Avatar, Status Chips, Rating Display, Menu List.
- Primary CTA: `Edit Profil Teknisi`.
- Secondary CTA: `Logout`.
- Loading State: profile skeleton.
- Empty State: incomplete profile guidance.
- Error State: failed load profile.
- Success State: profile visible.

## 6. Stitch Prompt For Mobile Refinement

```text
Buat desain high fidelity Android Mobile untuk SiTeknisi, marketplace jasa servis elektronik. Fokus hanya mobile app untuk role Customer dan Technician. Admin Web sudah selesai, jadi pastikan mobile konsisten dengan admin dashboard: warna #2563EB, #F97316, background #F8FAFC, radius 16 px, status badge konsisten, typography modern sans serif, clean professional Material 3.

Style: modern marketplace, clean UI, production ready, Play Store ready, kualitas setara Gojek, Grab, Urban Company. Jangan buat landing page. Buat layar aplikasi usable dengan bottom navigation, app bar, cards, chips, forms, bottom sheets, dialogs, image upload, payment cards, invoice cards, status timeline.

Buat 51 layar:
Splash, Onboarding 1, Onboarding 2, Onboarding 3, Login, Register, Forgot Password, Guest Home, Service Categories, Service Detail, Search Services, Customer Dashboard, Create Service Request, Location Picker, Upload Damage Photo, Request Submitted Success, Technician Offer List, Offer Comparison, Offer Detail, Payment Method, Payment Summary, Payment Success, Booking Tracking, Booking Detail, Booking History, Invoice Detail, Download Invoice, Rating, Review, Profile, Edit Profile, Settings, Help Center, Join As Technician, Technician Application Form, Upload KTP, Upload Profile Photo, Bank Account Information, Application Submitted, Technician Dashboard, Incoming Requests, Request Detail, Create Offer, Active Jobs, Job Detail, Update Job Status, Completed Jobs, Earnings Dashboard, Earnings Detail, Bank Account Management, Technician Profile.

Customer flow: Guest -> Browse Services -> Service Detail -> Login/Register -> Create Service Request -> Upload Damage Photo -> Receive Offers -> Compare Offers -> Choose Technician -> Payment -> Invoice -> Track Service -> Review.

Technician flow: Join As Technician -> Application Form -> Verification -> Dashboard -> Incoming Requests -> Send Offer -> Update Status -> Complete Job -> View Earnings.

Use Bahasa Indonesia for all UI copy. Use Rupiah formatting. Show loading, empty, error, and success states in representative screens. Prioritize Customer request flow, offer comparison, payment flow, tracking flow, and Technician productivity.
```


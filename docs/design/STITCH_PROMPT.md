# Stitch Prompt

Gunakan prompt berikut di Stitch untuk menghasilkan desain high fidelity SiTeknisi secara konsisten.

```text
Buat desain high fidelity untuk SiTeknisi, sebuah marketplace jasa servis elektronik yang menghubungkan Customer dengan Teknisi elektronik terdekat. Desain harus production ready, modern marketplace, Material 3, responsive, Flutter ready untuk mobile, dan Flutter Web ready untuk Admin dashboard.

Brand:
- Nama produk: SiTeknisi
- Karakter: terpercaya, jelas, cepat, profesional, membantu
- Target: Customer yang ingin servis elektronik, Teknisi yang ingin menerima pekerjaan, Admin yang memonitor operasional

Visual style:
- Gunakan Material 3.
- Gunakan background utama #F8FAFC.
- Primary color #2563EB untuk CTA utama, active state, link aktif.
- Secondary color #F97316 untuk CTA pendukung, aksen harga, dan highlight penting.
- Success #22C55E, Warning #EAB308, Error #EF4444.
- Surface #FFFFFF, border #E2E8F0, text utama #0F172A, text sekunder #475569, muted #64748B.
- Radius utama 16 px, input radius 12 px, badge radius full.
- Spacing utama 8, 12, 16, 24, 32 px.
- Typography: Display, Headline, Title, Body, Label. Gunakan Roboto untuk mobile dan Inter untuk web admin.
- Gunakan icon outline bergaya Material atau Lucide.
- Jangan buat landing page marketing. Buat pengalaman aplikasi yang langsung usable.
- Desain harus konsisten antara Customer App, Technician App, dan Admin Web.

UX principles:
- Clarity first: setiap layar harus jelas statusnya dan CTA berikutnya.
- Trust by design: tampilkan status, rating, invoice, payment breakdown, dan detail Teknisi dengan rapi.
- Guided action: form panjang dipandu step-by-step.
- Status visibility: gunakan badge status dengan teks dan warna.
- Mobile efficiency: CTA utama mudah dijangkau, bottom navigation jelas.
- Admin density: web admin harus padat, rapi, dan mudah dipindai dengan tabel, filter, search, dan KPI.

Mobile app screens to design:
1. Splash
2. Onboarding
3. Guest Home
4. Service Categories
5. Service Detail
6. Login
7. Register
8. Home Dashboard
9. Create Service Request
10. Upload Damage Photo
11. Technician Offer List
12. Offer Detail
13. Payment Method
14. Payment Success
15. Invoice
16. Booking Tracking
17. Booking History
18. Review
19. Profile
20. Join As Technician
21. Technician Application Form
22. Technician Dashboard
23. Incoming Requests
24. Create Offer
25. Job History
26. Earnings
27. Bank Account

Customer flow:
Splash -> Onboarding -> Guest Home -> Service Categories -> Service Detail -> Login/Register -> Home Dashboard -> Create Service Request -> Upload Damage Photo -> Technician Offer List -> Offer Detail -> Payment Method -> Payment Success -> Invoice -> Booking Tracking -> Review.

Technician flow:
Login/Register -> Join As Technician -> Technician Application Form -> Pending Verification -> Technician Dashboard -> Incoming Requests -> Request Detail -> Create Offer -> Offer Sent -> Active Job -> Update Status -> Job History -> Earnings -> Bank Account.

Mobile navigation:
- Customer bottom navigation: Home, Booking, History, Profile.
- Technician bottom navigation: Dashboard, Requests, Offers, Earnings, Profile.
- Use sticky primary CTA on task screens such as Service Detail, Create Service Request, Offer Detail, Payment Method, Create Offer, and Technician Application Form.

Mobile UI details:
- Guest Home: app bar with logo and login, search service, popular service categories, service cards, join as technician banner.
- Service Detail: icon or image, service name, description, included service notes, FAQ summary, sticky Request Service CTA.
- Request Service: stepper, selected service summary, title, description, address, location picker, schedule picker.
- Upload Damage Photo: large upload area, image preview, helper text, submit request CTA.
- Offer List: request summary, offer cards with technician avatar, rating, offer price, message preview, status.
- Offer Detail: technician profile, rating, offer price, message, price breakdown, choose offer CTA.
- Payment Method: booking summary, total amount, Midtrans payment methods, pay CTA.
- Payment Success: success icon, total amount, invoice number, CTA to Invoice and Booking Tracking.
- Invoice: invoice number, customer, technician, service, total, platform fee, technician income, payment method, status, date.
- Booking Tracking: timeline with pending payment, confirmed, in progress, completed, reviewed.
- Review: technician summary, star rating, comment field, submit CTA.
- Technician Dashboard: verification status banner, KPI cards active jobs, pending offers, earnings, new request preview.
- Incoming Requests: request cards with service, issue title, address, schedule, photo thumbnail, CTA send offer.
- Create Offer: request summary, price input in Rupiah, message field, earnings after 10 percent platform commission.
- Earnings: total earnings, completed job list, commission note, bank account shortcut.
- Bank Account: bank name, account number, account holder, save CTA.

Admin web screens to design:
1. Login
2. Dashboard
3. User Management
4. Technician Verification
5. Service Management
6. Booking Monitoring
7. Payment Monitoring
8. Invoice Monitoring
9. Reports
10. Settings

Admin web layout:
- Use left sidebar fixed navigation: Dashboard, Users, Technicians, Services, Bookings, Payments, Invoices, Reports, Settings.
- Use top bar with page title, search, notification icon, admin profile.
- Dashboard should include KPI cards: Total Users, Pending Verification, Active Bookings, Paid Payments, Platform Commission.
- Use data tables with search, filters, status badges, and action menu.
- Technician Verification page must show application queue and detail panel with personal data, expertise, experience, KTP preview, profile photo, bank name, account number, account holder, approve and reject actions.
- Booking Monitoring page must show booking ID, customer, technician, service, status, payment status, created date, action.
- Payment Monitoring page must show Midtrans order ID, booking ID, customer, gross amount, platform fee, technician income, method, status, paid date.
- Invoice Monitoring page must support invoice number search and show invoice detail with payment breakdown.
- Reports page should include transaction summary, service demand chart, technician performance table.
- Settings page should include commission rate set to 10 percent, admin profile, and app support contact placeholder.

Component system:
- Buttons: primary, secondary, outline, text, destructive.
- Text fields: email, password, phone, currency, textarea, search, dropdown, date time picker, location picker.
- Cards: service card, offer card, booking card, invoice card, admin KPI card.
- Navigation: mobile bottom navigation, app bar, admin sidebar, admin top bar.
- Dialogs: confirm choose offer, confirm payment, approve technician, reject technician with reason, logout.
- Bottom sheets: payment method, filter, sort, status update.
- Tables: sortable columns, filters, search, status badge, row action.
- Search components: mobile service search, admin global/table search.
- Filters: status chips, date range, role dropdown, service dropdown.

Important states:
- Empty states for no services, no offers, no bookings, no earnings, no pending verification, no payments, no invoices.
- Error states for failed login, failed upload, failed payment session, failed load data, rejected technician application.
- Loading states for auth check, list loading, payment processing, invoice generation.
- Disabled states for incomplete forms.

Content language:
- Use Bahasa Indonesia for all UI copy.
- Keep labels short and clear.
- Use status labels: Pending, Approved, Rejected, Open, Offered, Booked, Pending Payment, Confirmed, In Progress, Completed, Paid, Failed, Expired, Cancelled.
- Use Rupiah formatting for prices, for example Rp200.000.

Output expectation:
- Generate polished high fidelity screens for both mobile app and admin web.
- Screens should look ready for Flutter implementation.
- Maintain consistent spacing, radius, typography, colors, status badges, and component patterns.
- Avoid decorative clutter. Prioritize trust, clarity, and efficient workflows.
```


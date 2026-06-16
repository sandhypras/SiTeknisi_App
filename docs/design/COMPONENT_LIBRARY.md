# Component Library

Komponen berikut menjadi acuan untuk desain SiTeknisi di Stitch dan implementasi Flutter.

## 1. Buttons

### Primary Button

Usage:

- Login.
- Register.
- Request Service.
- Choose Offer.
- Pay Now.
- Submit Application.

Specification:

- Background `#2563EB`.
- Text white.
- Radius 16 px.
- Height 48 px mobile, 40 px web.
- Full width untuk CTA utama mobile.

States:

- Default.
- Pressed.
- Loading with spinner.
- Disabled.
- Error recovery after failed action.

### Secondary Button

Usage:

- Create Offer.
- Join As Technician.
- Save Bank Account.

Specification:

- Background `#F97316`.
- Text white.
- Radius 16 px.

### Outline Button

Usage:

- Cancel.
- View Detail.
- Back to Home.
- Reject Application with confirmation.

Specification:

- Border `#E2E8F0`.
- Text `#0F172A`.
- Background white.

### Text Button

Usage:

- Login link.
- Register link.
- Skip onboarding.
- View all.

## 2. Text Fields

Variants:

- Single line text.
- Password.
- Phone number.
- Currency input.
- Text area.
- Search input.
- Dropdown.
- Date time picker.
- Location picker.

Specification:

- Height 48 px mobile.
- Radius 12 px.
- Border `#E2E8F0`.
- Focus border `#2563EB`.
- Error border `#EF4444`.
- Helper text below field.

Validation:

- Required fields show explicit message.
- Currency uses Rupiah formatting.
- Phone number uses numeric keyboard.
- Password supports show and hide control.

## 3. Cards

### Service Card

Contains:

- Service icon.
- Service name.
- Short description.
- CTA or chevron.

### Offer Card

Contains:

- Technician avatar.
- Technician name.
- Rating.
- Offer price.
- Message preview.
- Status badge.
- CTA detail.

### Booking Card

Contains:

- Service name.
- Technician or Customer name.
- Booking status.
- Schedule.
- Payment status.
- CTA tracking.

### Invoice Card

Contains:

- Invoice number.
- Total amount.
- Date.
- Payment status.
- CTA detail.

### Admin KPI Card

Contains:

- Label.
- Metric value.
- Trend indicator.
- Supporting note.

## 4. Navigation

### Mobile Bottom Navigation

Customer tabs:

- Home.
- Booking.
- History.
- Profile.

Technician tabs:

- Dashboard.
- Requests.
- Offers.
- Earnings.
- Profile.

Rules:

- Active tab uses primary color.
- Inactive tab uses muted color.
- Icon and label must be visible.

### App Bar

Contains:

- Page title.
- Back button when nested.
- Optional action icon.

### Admin Sidebar

Items:

- Dashboard.
- Users.
- Technicians.
- Services.
- Bookings.
- Payments.
- Invoices.
- Reports.
- Settings.

Rules:

- Active item highlighted with primary background tint.
- Sidebar fixed on desktop.
- Collapse into drawer on tablet width if needed.

## 5. Dialogs

Usage:

- Confirm choose offer.
- Confirm payment.
- Confirm approve Technician.
- Confirm reject Technician.
- Confirm logout.

Structure:

- Title.
- Short message.
- Optional detail.
- Primary action.
- Secondary action.

Rules:

- Keep copy concise.
- Destructive action uses error color.
- Reject dialog must include rejection reason field.

## 6. Bottom Sheets

Usage:

- Payment method selector.
- Filter selector.
- Sort selector.
- Status update selector.

Structure:

- Drag handle.
- Title.
- List options.
- Sticky action when required.

## 7. Tables

Usage:

- Admin user management.
- Technician verification.
- Booking monitoring.
- Payment monitoring.
- Invoice monitoring.

Specification:

- Header row sticky if table is long.
- Row height 56 px.
- Status badge in status columns.
- Action menu at right.
- Search and filters above table.

Common columns:

- ID or number.
- Name.
- Type or category.
- Status.
- Amount.
- Date.
- Action.

## 8. Search Components

### Mobile Search

Usage:

- Search services.
- Search history.
- Search requests.

Structure:

- Leading search icon.
- Placeholder.
- Clear icon when filled.

### Admin Search

Usage:

- Search users, booking ID, invoice number, payment order ID.

Rules:

- Debounced search.
- Works with filters.
- Empty state must explain no result.

## 9. Filters

### Filter Chips

Usage:

- Service category.
- Booking status.
- Payment status.
- Request status.

### Admin Filter Bar

Contains:

- Date range.
- Status dropdown.
- Role dropdown.
- Service dropdown.
- Reset button.

Rules:

- Active filters must be visible.
- Reset all filters must be easy to find.


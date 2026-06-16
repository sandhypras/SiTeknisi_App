# Database Schema

Database SiTeknisi menggunakan PostgreSQL melalui Supabase.

## 1. Enum Status

```sql
create type user_role as enum ('customer', 'technician', 'admin');

create type application_status as enum ('pending', 'approved', 'rejected');

create type request_status as enum (
  'draft',
  'open',
  'offered',
  'booked',
  'in_progress',
  'completed',
  'cancelled'
);

create type offer_status as enum ('pending', 'accepted', 'rejected', 'expired');

create type booking_status as enum (
  'pending_payment',
  'confirmed',
  'in_progress',
  'completed',
  'cancelled'
);

create type payment_status as enum ('pending', 'paid', 'failed', 'expired', 'refunded');

create type invoice_status as enum ('issued', 'cancelled');
```

## 2. Table Definitions

### profiles

```sql
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  phone text,
  role user_role not null default 'customer',
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
```

### services

```sql
create table services (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  icon_url text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint services_name_unique unique (name)
);
```

### technician_applications

```sql
create table technician_applications (
  id uuid primary key default gen_random_uuid(),
  technician_id uuid not null references profiles(id) on delete cascade,
  expertise text not null,
  experience_years integer not null default 0,
  ktp_url text not null,
  profile_photo_url text,
  bank_name text not null,
  bank_account_number text not null,
  bank_account_holder text not null,
  status application_status not null default 'pending',
  rejection_reason text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint technician_applications_experience_check check (experience_years >= 0),
  constraint technician_applications_one_active unique (technician_id)
);
```

### service_requests

```sql
create table service_requests (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references profiles(id) on delete cascade,
  service_id uuid not null references services(id),
  title text not null,
  description text not null,
  address text not null,
  latitude numeric(10, 7),
  longitude numeric(10, 7),
  photo_url text,
  preferred_schedule timestamptz,
  status request_status not null default 'open',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
```

### service_offers

```sql
create table service_offers (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references service_requests(id) on delete cascade,
  technician_id uuid not null references profiles(id) on delete cascade,
  offer_price numeric(12, 2) not null,
  message text,
  status offer_status not null default 'pending',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint service_offers_price_check check (offer_price > 0),
  constraint service_offers_unique_per_technician unique (request_id, technician_id)
);
```

### bookings

```sql
create table bookings (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references service_requests(id),
  offer_id uuid not null references service_offers(id),
  customer_id uuid not null references profiles(id),
  technician_id uuid not null references profiles(id),
  status booking_status not null default 'pending_payment',
  started_at timestamptz,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint bookings_one_per_request unique (request_id),
  constraint bookings_offer_unique unique (offer_id)
);
```

### payments

```sql
create table payments (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references bookings(id) on delete cascade,
  customer_id uuid not null references profiles(id),
  gross_amount numeric(12, 2) not null,
  platform_fee numeric(12, 2) not null,
  technician_income numeric(12, 2) not null,
  payment_method text,
  midtrans_order_id text not null,
  status payment_status not null default 'pending',
  paid_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint payments_amount_check check (gross_amount > 0),
  constraint payments_fee_check check (platform_fee >= 0),
  constraint payments_income_check check (technician_income >= 0),
  constraint payments_midtrans_order_unique unique (midtrans_order_id),
  constraint payments_booking_unique unique (booking_id)
);
```

### invoices

```sql
create table invoices (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references bookings(id) on delete cascade,
  payment_id uuid not null references payments(id) on delete cascade,
  invoice_number text not null,
  total_amount numeric(12, 2) not null,
  platform_fee numeric(12, 2) not null,
  technician_income numeric(12, 2) not null,
  status invoice_status not null default 'issued',
  issued_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  constraint invoices_number_unique unique (invoice_number),
  constraint invoices_booking_unique unique (booking_id),
  constraint invoices_payment_unique unique (payment_id)
);
```

### reviews

```sql
create table reviews (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references bookings(id) on delete cascade,
  customer_id uuid not null references profiles(id),
  technician_id uuid not null references profiles(id),
  rating integer not null,
  comment text,
  created_at timestamptz not null default now(),
  constraint reviews_rating_check check (rating between 1 and 5),
  constraint reviews_booking_unique unique (booking_id)
);
```

## 3. Relationships

| Relasi | Keterangan |
|---|---|
| `profiles` ke `service_requests` | Customer membuat banyak request |
| `services` ke `service_requests` | Satu layanan dapat digunakan banyak request |
| `profiles` ke `technician_applications` | Teknisi mengajukan satu verifikasi |
| `service_requests` ke `service_offers` | Satu request menerima banyak offer |
| `profiles` ke `service_offers` | Teknisi mengirim banyak offer |
| `service_requests` ke `bookings` | Satu request menghasilkan satu booking |
| `service_offers` ke `bookings` | Satu offer terpilih menjadi satu booking |
| `bookings` ke `payments` | Satu booking memiliki satu payment |
| `payments` ke `invoices` | Satu payment sukses menghasilkan satu invoice |
| `bookings` ke `reviews` | Satu booking dapat diberi satu review |

## 4. Constraints Utama

- Email dan password dikelola oleh Supabase Auth.
- `profiles.id` wajib sama dengan `auth.users.id`.
- Harga offer wajib lebih dari 0.
- Rating wajib bernilai 1 sampai 5.
- Satu request hanya boleh memiliki satu booking.
- Satu booking hanya boleh memiliki satu payment.
- Satu payment hanya boleh memiliki satu invoice.
- Satu booking hanya boleh memiliki satu review.

## 5. Rekomendasi Index

```sql
create index idx_profiles_role on profiles(role);
create index idx_service_requests_customer on service_requests(customer_id);
create index idx_service_requests_service on service_requests(service_id);
create index idx_service_requests_status on service_requests(status);
create index idx_service_offers_request on service_offers(request_id);
create index idx_service_offers_technician on service_offers(technician_id);
create index idx_bookings_customer on bookings(customer_id);
create index idx_bookings_technician on bookings(technician_id);
create index idx_bookings_status on bookings(status);
create index idx_payments_status on payments(status);
create index idx_invoices_invoice_number on invoices(invoice_number);
```


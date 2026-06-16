# Entity Relationship Diagram

Dokumen ini menjelaskan hubungan antar entitas utama pada database SiTeknisi.

## ERD

```mermaid
erDiagram
    profiles {
        uuid id PK
        text full_name
        text phone
        text role
        text avatar_url
        timestamptz created_at
        timestamptz updated_at
    }

    services {
        uuid id PK
        text name
        text description
        text icon_url
        boolean is_active
        timestamptz created_at
        timestamptz updated_at
    }

    technician_applications {
        uuid id PK
        uuid technician_id FK
        text expertise
        integer experience_years
        text ktp_url
        text profile_photo_url
        text bank_name
        text bank_account_number
        text bank_account_holder
        text status
        text rejection_reason
        timestamptz created_at
        timestamptz updated_at
    }

    service_requests {
        uuid id PK
        uuid customer_id FK
        uuid service_id FK
        text title
        text description
        text address
        numeric latitude
        numeric longitude
        text photo_url
        text status
        timestamptz preferred_schedule
        timestamptz created_at
        timestamptz updated_at
    }

    service_offers {
        uuid id PK
        uuid request_id FK
        uuid technician_id FK
        numeric offer_price
        text message
        text status
        timestamptz created_at
        timestamptz updated_at
    }

    bookings {
        uuid id PK
        uuid request_id FK
        uuid offer_id FK
        uuid customer_id FK
        uuid technician_id FK
        text status
        timestamptz started_at
        timestamptz completed_at
        timestamptz created_at
        timestamptz updated_at
    }

    payments {
        uuid id PK
        uuid booking_id FK
        uuid customer_id FK
        numeric gross_amount
        numeric platform_fee
        numeric technician_income
        text payment_method
        text midtrans_order_id
        text status
        timestamptz paid_at
        timestamptz created_at
        timestamptz updated_at
    }

    invoices {
        uuid id PK
        uuid booking_id FK
        uuid payment_id FK
        text invoice_number
        numeric total_amount
        numeric platform_fee
        numeric technician_income
        text status
        timestamptz issued_at
        timestamptz created_at
    }

    reviews {
        uuid id PK
        uuid booking_id FK
        uuid customer_id FK
        uuid technician_id FK
        integer rating
        text comment
        timestamptz created_at
    }

    profiles ||--o{ service_requests : creates
    services ||--o{ service_requests : selected_for
    profiles ||--o| technician_applications : submits
    service_requests ||--o{ service_offers : receives
    profiles ||--o{ service_offers : sends
    service_requests ||--o| bookings : becomes
    service_offers ||--o| bookings : selected_as
    profiles ||--o{ bookings : customer
    profiles ||--o{ bookings : technician
    bookings ||--o| payments : paid_by
    bookings ||--o| invoices : generates
    payments ||--o| invoices : documented_by
    bookings ||--o| reviews : reviewed_by
```

## Catatan Relasi

- `profiles.id` terhubung dengan user Supabase Auth.
- Satu Customer dapat membuat banyak `service_requests`.
- Satu `service_request` dapat menerima banyak `service_offers`.
- Satu offer yang dipilih akan menjadi satu `booking`.
- Satu `booking` memiliki satu `payment` dan satu `invoice`.
- Satu `booking` dapat memiliki satu `review`.
- Satu Teknisi memiliki satu data `technician_applications` aktif.


# API Specification

API SiTeknisi menggunakan pendekatan REST untuk dokumentasi kontrak. Implementasi dapat dilakukan menggunakan Supabase Client, Supabase Edge Functions, atau backend API tambahan jika dibutuhkan.

Base URL contoh:

```text
https://api.siteknisi.local/v1
```

## 1. Authentication

### Register

```http
POST /auth/register
```

Request:

```json
{
  "email": "customer@example.com",
  "password": "password123",
  "full_name": "Budi Santoso",
  "phone": "08123456789",
  "role": "customer"
}
```

Response:

```json
{
  "user_id": "uuid",
  "email": "customer@example.com",
  "role": "customer"
}
```

### Login

```http
POST /auth/login
```

Request:

```json
{
  "email": "customer@example.com",
  "password": "password123"
}
```

Response:

```json
{
  "access_token": "jwt_token",
  "refresh_token": "refresh_token",
  "profile": {
    "id": "uuid",
    "full_name": "Budi Santoso",
    "role": "customer"
  }
}
```

### Logout

```http
POST /auth/logout
```

Header:

```http
Authorization: Bearer jwt_token
```

## 2. Services

### Get Services

```http
GET /services
```

Response:

```json
[
  {
    "id": "uuid",
    "name": "Servis TV",
    "description": "Perbaikan TV LED, LCD, dan Smart TV",
    "icon_url": "https://...",
    "is_active": true
  }
]
```

### Create Service

```http
POST /services
```

Role: Admin.

Request:

```json
{
  "name": "Servis Kulkas",
  "description": "Perbaikan kulkas satu pintu dan dua pintu",
  "icon_url": "https://..."
}
```

## 3. Service Requests

### Create Request Service

```http
POST /service-requests
```

Role: Customer.

Request:

```json
{
  "service_id": "uuid",
  "title": "TV tidak menyala",
  "description": "TV LED mati total setelah listrik padam",
  "address": "Jl. Merdeka No. 10",
  "latitude": -6.200000,
  "longitude": 106.816666,
  "photo_url": "https://...",
  "preferred_schedule": "2026-06-20T10:00:00Z"
}
```

Response:

```json
{
  "id": "uuid",
  "status": "open"
}
```

### Get Customer Requests

```http
GET /service-requests?customer_id=me
```

Role: Customer.

### Get Open Requests

```http
GET /service-requests?status=open
```

Role: Approved Technician.

### Get Request Detail

```http
GET /service-requests/{request_id}
```

## 4. Offers

### Create Offer

```http
POST /service-requests/{request_id}/offers
```

Role: Approved Technician.

Request:

```json
{
  "offer_price": 200000,
  "message": "Estimasi pengerjaan 1 hari setelah pengecekan."
}
```

Response:

```json
{
  "id": "uuid",
  "request_id": "uuid",
  "status": "pending"
}
```

### Get Offers for Request

```http
GET /service-requests/{request_id}/offers
```

Role: Customer owner.

### Accept Offer

```http
POST /offers/{offer_id}/accept
```

Role: Customer owner.

Response:

```json
{
  "booking_id": "uuid",
  "status": "pending_payment"
}
```

## 5. Bookings

### Get My Bookings

```http
GET /bookings
```

Role: Customer, Technician, Admin.

### Get Booking Detail

```http
GET /bookings/{booking_id}
```

### Update Booking Status

```http
PATCH /bookings/{booking_id}/status
```

Role: Technician or Admin.

Request:

```json
{
  "status": "in_progress"
}
```

Allowed status:

- `confirmed`
- `in_progress`
- `completed`
- `cancelled`

## 6. Payments

### Create Payment

```http
POST /bookings/{booking_id}/payments
```

Role: Customer owner.

Request:

```json
{
  "payment_method": "midtrans",
  "commission_rate": 0.1
}
```

Response:

```json
{
  "payment_id": "uuid",
  "midtrans_order_id": "SITEKNISI-uuid",
  "gross_amount": 200000,
  "platform_fee": 20000,
  "technician_income": 180000,
  "redirect_url": "https://app.sandbox.midtrans.com/..."
}
```

### Midtrans Notification Webhook

```http
POST /payments/midtrans/notification
```

Digunakan oleh Midtrans untuk mengirim status transaksi.

Request:

```json
{
  "order_id": "SITEKNISI-uuid",
  "transaction_status": "settlement",
  "payment_type": "bank_transfer",
  "gross_amount": "200000.00"
}
```

Response:

```json
{
  "status": "ok"
}
```

### Get Payment Detail

```http
GET /payments/{payment_id}
```

## 7. Invoices

### Get Invoice by Booking

```http
GET /bookings/{booking_id}/invoice
```

Response:

```json
{
  "invoice_number": "INV/SITEKNISI/20260620/0001",
  "total_amount": 200000,
  "platform_fee": 20000,
  "technician_income": 180000,
  "status": "issued",
  "issued_at": "2026-06-20T10:30:00Z"
}
```

### Get Invoice Detail

```http
GET /invoices/{invoice_id}
```

Role: Customer owner, Technician related, Admin.

## 8. Reviews

### Create Review

```http
POST /bookings/{booking_id}/reviews
```

Role: Customer owner.

Request:

```json
{
  "rating": 5,
  "comment": "Teknisi cepat dan hasil servis bagus."
}
```

Response:

```json
{
  "id": "uuid",
  "rating": 5
}
```

### Get Technician Reviews

```http
GET /technicians/{technician_id}/reviews
```

## 9. Error Response

Format error standar:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Field offer_price wajib lebih dari 0."
  }
}
```

Kode error umum:

| Code | Keterangan |
|---|---|
| `UNAUTHORIZED` | Token tidak valid atau belum login |
| `FORBIDDEN` | Role tidak memiliki akses |
| `NOT_FOUND` | Data tidak ditemukan |
| `VALIDATION_ERROR` | Data request tidak valid |
| `PAYMENT_ERROR` | Gagal membuat atau memproses pembayaran |


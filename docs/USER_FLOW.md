# User Flow

Dokumen ini menjelaskan alur utama pengguna SiTeknisi untuk role Customer, Teknisi, dan Admin.

## 1. Customer Flow

Alur utama: Guest -> Login -> Request Service -> Offer -> Payment -> Invoice -> Review.

```mermaid
flowchart TD
    A[Guest membuka aplikasi] --> B[Lihat home dan kategori layanan]
    B --> C{Sudah login?}
    C -- Tidak --> D[Login atau Register]
    C -- Ya --> E[Pilih layanan]
    D --> E
    E --> F[Isi request service]
    F --> G[Upload foto perangkat dan isi deskripsi]
    G --> H[Kirim permintaan servis]
    H --> I[Menunggu offer Teknisi]
    I --> J[Lihat daftar offer]
    J --> K[Pilih offer]
    K --> L[Booking dibuat]
    L --> M[Bayar via Midtrans]
    M --> N{Pembayaran sukses?}
    N -- Tidak --> O[Ulangi pembayaran atau batalkan]
    O --> M
    N -- Ya --> P[Invoice otomatis dibuat]
    P --> Q[Teknisi mengerjakan servis]
    Q --> R[Booking selesai]
    R --> S[Beri rating dan review]
```

## 2. Teknisi Flow

Alur utama: Register -> Verifikasi -> Terima Request -> Kirim Offer -> Kerjakan -> Selesai.

```mermaid
flowchart TD
    A[Teknisi register] --> B[Isi profil Teknisi]
    B --> C[Isi keahlian dan pengalaman]
    C --> D[Upload KTP dan foto profil]
    D --> E[Isi data rekening]
    E --> F[Ajukan verifikasi]
    F --> G{Status verifikasi}
    G -- Pending --> H[Menunggu review Admin]
    H --> G
    G -- Rejected --> I[Perbaiki data pengajuan]
    I --> F
    G -- Approved --> J[Masuk dashboard Teknisi]
    J --> K[Lihat request service]
    K --> L[Pilih request sesuai keahlian]
    L --> M[Kirim offer harga]
    M --> N{Offer dipilih Customer?}
    N -- Tidak --> K
    N -- Ya --> O[Booking aktif]
    O --> P[Kerjakan servis]
    P --> Q[Update status pengerjaan]
    Q --> R[Selesaikan pekerjaan]
    R --> S[Pendapatan tercatat]
```

## 3. Admin Flow

Alur utama: Login -> Verifikasi Teknisi -> Monitoring Booking -> Monitoring Pembayaran.

```mermaid
flowchart TD
    A[Admin membuka website] --> B[Login Admin]
    B --> C[Dashboard Admin]
    C --> D[Monitoring ringkasan platform]
    C --> E[Daftar pengajuan Teknisi]
    E --> F[Review data diri, keahlian, KTP, rekening]
    F --> G{Keputusan verifikasi}
    G -- Approve --> H[Status Teknisi Approved]
    G -- Reject --> I[Status Teknisi Rejected]
    C --> J[Monitoring booking]
    J --> K[Lihat status request, offer, booking]
    C --> L[Monitoring pembayaran]
    L --> M[Lihat status payment Midtrans]
    M --> N[Lihat invoice]
```

## 4. Status Flow Service Request

```mermaid
stateDiagram-v2
    [*] --> draft
    draft --> open: Customer submit request
    open --> offered: Teknisi mengirim offer
    offered --> booked: Customer memilih offer
    booked --> in_progress: Teknisi mulai pengerjaan
    in_progress --> completed: Teknisi menyelesaikan pekerjaan
    completed --> reviewed: Customer memberi review
    open --> cancelled: Customer membatalkan
    offered --> cancelled: Customer membatalkan
```

## 5. Status Flow Payment

```mermaid
stateDiagram-v2
    [*] --> pending
    pending --> paid: Midtrans success callback
    pending --> failed: Midtrans failure callback
    pending --> expired: Payment timeout
    paid --> refunded: Refund manual oleh Admin
```


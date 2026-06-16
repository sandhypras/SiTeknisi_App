# Design System

Design system SiTeknisi dibuat untuk menjaga konsistensi tampilan Customer App, Technician App, dan Admin Website.

## 1. Brand Principles

- Jelas dan mudah digunakan.
- Terpercaya untuk transaksi jasa.
- Modern tetapi tetap sederhana.
- Cocok untuk penggunaan mobile harian.
- Admin website harus rapi, padat, dan mudah dipindai.

## 2. Colors

### Primary

| Token | Hex | Usage |
|---|---|---|
| `primary` | `#2563EB` | Tombol utama, link aktif, highlight |
| `primary-dark` | `#1D4ED8` | Hover atau pressed state |
| `primary-light` | `#DBEAFE` | Background informasi ringan |

### Secondary

| Token | Hex | Usage |
|---|---|---|
| `secondary` | `#F97316` | CTA pendukung, badge promo, aksen harga |
| `secondary-dark` | `#EA580C` | Hover atau pressed state |
| `secondary-light` | `#FFEDD5` | Background warning ringan |

### Neutral

| Token | Hex | Usage |
|---|---|---|
| `neutral-900` | `#111827` | Heading utama |
| `neutral-700` | `#374151` | Body text |
| `neutral-500` | `#6B7280` | Secondary text |
| `neutral-300` | `#D1D5DB` | Border |
| `neutral-100` | `#F3F4F6` | Background section |
| `white` | `#FFFFFF` | Surface |

### Semantic

| Token | Hex | Usage |
|---|---|---|
| `success` | `#16A34A` | Payment sukses, booking selesai |
| `warning` | `#F59E0B` | Pending, menunggu verifikasi |
| `danger` | `#DC2626` | Error, rejected, failed |
| `info` | `#0284C7` | Informasi status |

## 3. Typography

Font yang direkomendasikan:

- Mobile: `Roboto` atau default Material.
- Web Admin: `Inter` atau `Roboto`.

### Type Scale

| Style | Size | Weight | Usage |
|---|---:|---:|---|
| Display | 32 | 700 | Judul halaman penting |
| H1 | 28 | 700 | Heading utama |
| H2 | 24 | 700 | Section title |
| H3 | 20 | 600 | Card title |
| Body Large | 16 | 400 | Body utama |
| Body Medium | 14 | 400 | Text default |
| Caption | 12 | 400 | Helper text, metadata |

## 4. Spacing

Gunakan spacing berbasis kelipatan 4.

| Token | Value |
|---|---:|
| `space-1` | 4px |
| `space-2` | 8px |
| `space-3` | 12px |
| `space-4` | 16px |
| `space-5` | 20px |
| `space-6` | 24px |
| `space-8` | 32px |
| `space-10` | 40px |

## 5. Radius

| Token | Value | Usage |
|---|---:|---|
| `radius-sm` | 4px | Badge, input kecil |
| `radius-md` | 8px | Button, card, form field |
| `radius-lg` | 12px | Bottom sheet, modal |
| `radius-full` | 999px | Avatar, pill badge |

## 6. Buttons

### Primary Button

- Background: `#2563EB`
- Text: `#FFFFFF`
- Radius: 8px
- Height mobile: 48px
- Height web: 40px
- Usage: aksi utama seperti Login, Kirim Request, Bayar.

### Secondary Button

- Background: `#F97316`
- Text: `#FFFFFF`
- Radius: 8px
- Usage: aksi pendukung seperti Kirim Offer.

### Outline Button

- Border: `#D1D5DB`
- Text: `#374151`
- Background: transparent atau white
- Usage: aksi sekunder seperti Batal, Lihat Detail.

### Disabled Button

- Background: `#D1D5DB`
- Text: `#6B7280`
- Interaction: tidak dapat diklik.

## 7. Cards

Card digunakan untuk item berulang seperti layanan, offer, booking, dan invoice summary.

Style:

- Background: `#FFFFFF`
- Border: `1px solid #E5E7EB`
- Radius: 8px
- Padding: 16px
- Shadow: ringan hanya jika diperlukan.

Konten card:

- Title.
- Metadata singkat.
- Status badge.
- CTA kecil jika diperlukan.

## 8. Forms

Komponen form:

- Text field.
- Text area.
- Dropdown.
- Date and time picker.
- Upload field.
- Location picker.

Style:

- Height input: 48px.
- Border: `#D1D5DB`.
- Focus border: `#2563EB`.
- Error text: `#DC2626`.
- Helper text: `#6B7280`.

Validasi:

- Field wajib menampilkan pesan error jelas.
- Nominal harga wajib lebih dari 0.
- Rating wajib 1 sampai 5.
- File upload wajib membatasi tipe dan ukuran file.

## 9. Tables

Tabel digunakan terutama pada Admin Website.

Style:

- Header background: `#F3F4F6`.
- Border row: `#E5E7EB`.
- Text header: `#374151`, weight 600.
- Row hover: `#F9FAFB`.
- Padding cell: 12px sampai 16px.

Kolom umum:

- Nama atau nomor data.
- Role atau kategori.
- Status.
- Tanggal.
- Aksi.

## 10. Status Badge

| Status | Color |
|---|---|
| Pending | Warning |
| Approved | Success |
| Rejected | Danger |
| Open | Info |
| Paid | Success |
| Failed | Danger |
| Completed | Success |
| Cancelled | Neutral |

## 11. Icons

Gunakan icon bergaya outline dan konsisten.

Rekomendasi:

- Mobile: Material Icons.
- Web: Material Icons atau Lucide Icons.

Contoh penggunaan:

- Home: ikon rumah.
- Services: ikon tools.
- Booking: ikon calendar.
- Payment: ikon credit card.
- Invoice: ikon receipt.
- Profile: ikon user.


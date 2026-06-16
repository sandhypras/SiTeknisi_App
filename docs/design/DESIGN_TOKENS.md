# Design Tokens

Design tokens ini menjadi sumber konsistensi visual untuk desain Stitch, Flutter Mobile, dan Flutter Web Admin.

## 1. Brand

| Token | Value | Usage |
|---|---|---|
| `brand.name` | `SiTeknisi` | Nama produk |
| `brand.style` | Modern Marketplace | Karakter visual |
| `brand.voice` | Jelas, terpercaya, membantu | Tone UI copy |

## 2. Colors

### Core Colors

| Token | Hex | Usage |
|---|---|---|
| `color.primary` | `#2563EB` | Primary CTA, active state, key links |
| `color.secondary` | `#F97316` | Secondary CTA, price accent, important highlight |
| `color.background` | `#F8FAFC` | App background |
| `color.success` | `#22C55E` | Success status |
| `color.warning` | `#EAB308` | Pending or warning status |
| `color.error` | `#EF4444` | Error, failed, rejected |

### Neutral Colors

| Token | Hex | Usage |
|---|---|---|
| `color.surface` | `#FFFFFF` | Cards, dialogs, table surface |
| `color.text.primary` | `#0F172A` | Heading and primary content |
| `color.text.secondary` | `#475569` | Secondary content |
| `color.text.muted` | `#64748B` | Helper text and metadata |
| `color.border` | `#E2E8F0` | Border and dividers |
| `color.disabled` | `#CBD5E1` | Disabled components |

## 3. Radius

Base radius untuk dokumentasi desain ini adalah 16 px.

| Token | Value | Usage |
|---|---:|---|
| `radius.sm` | 8px | Badge, small chip |
| `radius.md` | 12px | Input, compact button |
| `radius.lg` | 16px | Cards, dialogs, bottom sheets |
| `radius.full` | 999px | Avatar, pill badge |

## 4. Spacing

| Token | Value | Usage |
|---|---:|---|
| `space.1` | 8px | Small gap |
| `space.2` | 12px | Compact spacing |
| `space.3` | 16px | Default component padding |
| `space.4` | 24px | Section spacing |
| `space.5` | 32px | Large section spacing |

## 5. Typography

Font recommendation:

- Mobile: Roboto or Material default.
- Admin Web: Inter.

| Token | Size | Weight | Line Height | Usage |
|---|---:|---:|---:|---|
| `type.display` | 32px | 700 | 40px | Splash, major page heading |
| `type.headline` | 24px | 700 | 32px | Screen title |
| `type.title` | 18px | 600 | 26px | Card title, section title |
| `type.body` | 14px | 400 | 22px | Main reading text |
| `type.label` | 12px | 600 | 16px | Badge, button, metadata |

## 6. Elevation

| Token | Value | Usage |
|---|---|---|
| `elevation.none` | none | Flat surfaces |
| `elevation.sm` | subtle shadow | Mobile cards |
| `elevation.md` | medium shadow | Dialogs, bottom sheets |

## 7. Component Sizes

| Token | Value | Usage |
|---|---:|---|
| `button.height.mobile` | 48px | Mobile primary and secondary button |
| `button.height.web` | 40px | Admin web button |
| `input.height.mobile` | 48px | Mobile text field |
| `input.height.web` | 40px | Admin web text field |
| `touch.target.min` | 44px | Minimum tap target |
| `bottom.nav.height` | 72px | Mobile bottom navigation |
| `sidebar.width` | 264px | Admin web sidebar |

## 8. Status Tokens

| Status | Background | Text |
|---|---|---|
| Pending | `#FEF9C3` | `#854D0E` |
| Approved | `#DCFCE7` | `#166534` |
| Rejected | `#FEE2E2` | `#991B1B` |
| Open | `#DBEAFE` | `#1D4ED8` |
| Paid | `#DCFCE7` | `#166534` |
| Failed | `#FEE2E2` | `#991B1B` |
| Completed | `#DCFCE7` | `#166534` |
| Cancelled | `#F1F5F9` | `#475569` |


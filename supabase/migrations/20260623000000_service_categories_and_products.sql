-- Service Categories & Products Management
-- Tahap 1: Backend untuk admin kelola katalog layanan

-- 1. Tabel untuk kategori layanan
create table service_categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  icon_name text not null, -- nama icon material (e.g., 'print_rounded')
  color_hex text not null default '#2563EB',
  display_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint service_categories_name_unique unique (name)
);

-- 2. Update tabel services dengan relasi ke kategori
alter table services 
  add column category_id uuid references service_categories(id),
  add column base_price numeric(12, 2) not null default 0,
  add column estimated_time text, -- contoh: "1-2 jam"
  add column features text[], -- array fitur layanan
  add column display_order integer not null default 0;

-- 3. Tabel untuk foto layanan (multiple photos per service)
create table service_photos (
  id uuid primary key default gen_random_uuid(),
  service_id uuid not null references services(id) on delete cascade,
  photo_url text not null,
  display_order integer not null default 0,
  is_primary boolean not null default false,
  created_at timestamptz not null default now()
);

-- 4. Indexes untuk performa
create index idx_service_categories_active on service_categories(is_active);
create index idx_service_categories_order on service_categories(display_order);
create index idx_services_category on services(category_id);
create index idx_services_active on services(is_active);
create index idx_service_photos_service on service_photos(service_id);

-- 5. Function untuk auto-update timestamp
create or replace function update_updated_at_column()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- 6. Triggers untuk auto-update timestamp
create trigger update_service_categories_timestamp
  before update on service_categories
  for each row
  execute function update_updated_at_column();

create trigger update_services_timestamp
  before update on services
  for each row
  execute function update_updated_at_column();

-- 7. Trigger untuk auto-update profiles timestamp (jika belum ada)
drop trigger if exists update_profiles_timestamp on profiles;
create trigger update_profiles_timestamp
  before update on profiles
  for each row
  execute function update_updated_at_column();

-- 8. Seed data awal untuk kategori (3 kategori utama)
insert into service_categories (name, description, icon_name, color_hex, display_order) values
  ('Printer', 'Tinta macet, hasil buram, paper jam', 'print_rounded', '#2563EB', 1),
  ('Komputer', 'Tidak menyala, lambat, upgrade komponen', 'desktop_windows_rounded', '#F97316', 2),
  ('Laptop', 'Layar, keyboard, baterai, overheat', 'laptop_mac_rounded', '#22C55E', 3);

-- 9. Seed data awal untuk services (6 layanan dari dummy data)
insert into services (category_id, name, description, base_price, estimated_time, features, display_order) 
select 
  c.id,
  'Servis Printer',
  'Perbaikan printer tidak menarik kertas, hasil buram, atau tidak terdeteksi.',
  150000,
  '1-2 jam',
  array['Diagnosa awal gratis', 'Kompatibel banyak merek', 'Garansi pengerjaan 7 hari'],
  1
from service_categories c where c.name = 'Printer';

insert into services (category_id, name, description, base_price, estimated_time, features, display_order)
select 
  c.id,
  'Perawatan Printer',
  'Pembersihan head, roller, jalur kertas, dan pengecekan kualitas cetak.',
  120000,
  '45 menit',
  array['Tes hasil cetak', 'Estimasi harga transparan', 'Teknisi datang ke lokasi'],
  2
from service_categories c where c.name = 'Printer';

insert into services (category_id, name, description, base_price, estimated_time, features, display_order)
select 
  c.id,
  'Optimasi Komputer',
  'Pembersihan komponen, optimasi sistem, dan pengecekan performa komputer.',
  90000,
  '1 jam',
  array['Cek suhu dan performa', 'Bersihkan komponen internal', 'Invoice otomatis'],
  1
from service_categories c where c.name = 'Komputer';

insert into services (category_id, name, description, base_price, estimated_time, features, display_order)
select 
  c.id,
  'Komputer Tidak Menyala',
  'Diagnosa power supply, motherboard, RAM, atau penyimpanan.',
  150000,
  '1-2 jam',
  array['Diagnosa kerusakan', 'Penawaran sparepart', 'Garansi jasa'],
  2
from service_categories c where c.name = 'Komputer';

insert into services (category_id, name, description, base_price, estimated_time, features, display_order)
select 
  c.id,
  'Servis Laptop',
  'Laptop mati, layar bermasalah, keyboard rusak, atau cepat panas.',
  200000,
  '1-3 hari',
  array['Diagnosa menyeluruh', 'Penawaran sparepart', 'Update status servis'],
  1
from service_categories c where c.name = 'Laptop';

insert into services (category_id, name, description, base_price, estimated_time, features, display_order)
select 
  c.id,
  'Upgrade Laptop',
  'Upgrade RAM, SSD, thermal paste, dan optimasi performa laptop.',
  180000,
  '1-2 hari',
  array['Teknisi terdekat', 'Biaya jasa jelas', 'Pembayaran aman'],
  2
from service_categories c where c.name = 'Laptop';

-- 10. Comments untuk dokumentasi
comment on table service_categories is 'Kategori layanan (Printer, Komputer, Laptop, dll)';
comment on table services is 'Daftar layanan yang bisa dipesan customer';
comment on table service_photos is 'Foto-foto untuk setiap layanan';
comment on column services.base_price is 'Harga dasar layanan dalam Rupiah (teknisi bisa custom di offer)';
comment on column services.estimated_time is 'Estimasi waktu pengerjaan (misal: 1-2 jam)';
comment on column services.features is 'Array fitur/benefit layanan untuk ditampilkan';

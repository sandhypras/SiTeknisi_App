-- Seed services data for MVP
-- Insert services that will be referenced by service requests

-- First, insert services with generated UUIDs
INSERT INTO services (name, description, is_active) VALUES
  ('Servis Printer', 'Perbaikan printer tidak menarik kertas, hasil buram, atau tidak terdeteksi.', true),
  ('Perawatan Printer', 'Pembersihan head, roller, jalur kertas, dan pengecekan kualitas cetak.', true),
  ('Optimasi Komputer', 'Pembersihan komponen, optimasi sistem, dan pengecekan performa komputer.', true),
  ('Komputer Tidak Menyala', 'Diagnosa power supply, motherboard, RAM, atau penyimpanan.', true),
  ('Servis Laptop', 'Laptop mati, layar bermasalah, keyboard rusak, atau cepat panas.', true),
  ('Upgrade Laptop', 'Upgrade RAM, SSD, thermal paste, dan optimasi performa laptop.', true)
ON CONFLICT (name) DO NOTHING;

-- Note: UUIDs will be auto-generated
-- App needs to query services by name to get IDs for creating requests

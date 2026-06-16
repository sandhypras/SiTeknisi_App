import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerServiceCategory {
  const CustomerServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.serviceCount,
  });

  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final int serviceCount;
}

class CustomerService {
  const CustomerService({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.icon,
    required this.basePrice,
    required this.estimatedTime,
    required this.rating,
    required this.completedJobs,
    required this.features,
  });

  final String id;
  final String categoryId;
  final String title;
  final String description;
  final IconData icon;
  final int basePrice;
  final String estimatedTime;
  final double rating;
  final int completedJobs;
  final List<String> features;
}

class FeaturedTechnician {
  const FeaturedTechnician({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.completedJobs,
    required this.distance,
  });

  final String name;
  final String specialization;
  final double rating;
  final int completedJobs;
  final String distance;
}

final customerCategoriesProvider = Provider<List<CustomerServiceCategory>>((
  ref,
) {
  return const [
    CustomerServiceCategory(
      id: 'phone',
      name: 'Smartphone',
      description: 'LCD, baterai, charging, kamera',
      icon: Icons.phone_android_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 18,
    ),
    CustomerServiceCategory(
      id: 'laptop',
      name: 'Laptop',
      description: 'Keyboard, layar, upgrade, install OS',
      icon: Icons.laptop_mac_rounded,
      color: Color(0xFFF97316),
      serviceCount: 14,
    ),
    CustomerServiceCategory(
      id: 'tv',
      name: 'TV & Audio',
      description: 'TV mati, audio rusak, panel bermasalah',
      icon: Icons.tv_rounded,
      color: Color(0xFF22C55E),
      serviceCount: 9,
    ),
    CustomerServiceCategory(
      id: 'home',
      name: 'Elektronik Rumah',
      description: 'Kulkas, mesin cuci, dispenser',
      icon: Icons.kitchen_rounded,
      color: Color(0xFFEAB308),
      serviceCount: 12,
    ),
  ];
});

final customerServicesProvider = Provider<List<CustomerService>>((ref) {
  return const [
    CustomerService(
      id: 'phone-lcd',
      categoryId: 'phone',
      title: 'Ganti LCD Smartphone',
      description:
          'Perbaikan layar retak, blank, shadow, atau touch screen tidak responsif.',
      icon: Icons.phone_iphone_rounded,
      basePrice: 150000,
      estimatedTime: '1-2 jam',
      rating: 4.9,
      completedJobs: 126,
      features: [
        'Diagnosa awal gratis',
        'Kompatibel banyak tipe',
        'Garansi pengerjaan 7 hari',
      ],
    ),
    CustomerService(
      id: 'phone-battery',
      categoryId: 'phone',
      title: 'Ganti Baterai Smartphone',
      description:
          'Baterai cepat habis, drop, menggembung, atau perangkat sering mati.',
      icon: Icons.battery_charging_full_rounded,
      basePrice: 120000,
      estimatedTime: '45 menit',
      rating: 4.8,
      completedJobs: 98,
      features: [
        'Cek kesehatan baterai',
        'Estimasi harga transparan',
        'Teknisi datang ke lokasi',
      ],
    ),
    CustomerService(
      id: 'laptop-keyboard',
      categoryId: 'laptop',
      title: 'Servis Keyboard Laptop',
      description:
          'Tombol tidak berfungsi, keyboard error, atau penggantian full set.',
      icon: Icons.keyboard_rounded,
      basePrice: 175000,
      estimatedTime: '1 hari',
      rating: 4.7,
      completedJobs: 74,
      features: [
        'Pengecekan fleksibel',
        'Pilihan sparepart tersedia',
        'Invoice otomatis',
      ],
    ),
    CustomerService(
      id: 'laptop-install',
      categoryId: 'laptop',
      title: 'Install OS & Software',
      description:
          'Install ulang Windows/Linux, driver, aplikasi kerja, dan optimasi.',
      icon: Icons.install_desktop_rounded,
      basePrice: 100000,
      estimatedTime: '2-3 jam',
      rating: 4.9,
      completedJobs: 142,
      features: ['Backup data opsional', 'Driver lengkap', 'Optimasi performa'],
    ),
    CustomerService(
      id: 'tv-panel',
      categoryId: 'tv',
      title: 'Servis TV LED',
      description:
          'TV mati total, suara ada gambar hilang, panel garis, atau backlight.',
      icon: Icons.live_tv_rounded,
      basePrice: 200000,
      estimatedTime: '1-3 hari',
      rating: 4.8,
      completedJobs: 61,
      features: [
        'Diagnosa kerusakan panel',
        'Penawaran sparepart',
        'Update status servis',
      ],
    ),
    CustomerService(
      id: 'washer',
      categoryId: 'home',
      title: 'Servis Mesin Cuci',
      description:
          'Mesin cuci tidak berputar, bocor, error display, atau pengering mati.',
      icon: Icons.local_laundry_service_rounded,
      basePrice: 180000,
      estimatedTime: '1-2 hari',
      rating: 4.7,
      completedJobs: 55,
      features: ['Teknisi terdekat', 'Biaya jasa jelas', 'Pembayaran aman'],
    ),
  ];
});

final featuredTechniciansProvider = Provider<List<FeaturedTechnician>>((ref) {
  return const [
    FeaturedTechnician(
      name: 'Budi Santoso',
      specialization: 'Smartphone & Tablet',
      rating: 4.9,
      completedJobs: 184,
      distance: '1.8 km',
    ),
    FeaturedTechnician(
      name: 'Andi Kurniawan',
      specialization: 'Laptop & PC',
      rating: 4.8,
      completedJobs: 132,
      distance: '2.4 km',
    ),
    FeaturedTechnician(
      name: 'Rina Wijaya',
      specialization: 'TV & Elektronik Rumah',
      rating: 4.9,
      completedJobs: 96,
      distance: '3.1 km',
    ),
  ];
});

String formatRupiah(int value) {
  final text = value.toString();
  final buffer = StringBuffer();

  for (var index = 0; index < text.length; index++) {
    final reverseIndex = text.length - index;
    buffer.write(text[index]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write('.');
    }
  }

  return 'Rp $buffer';
}

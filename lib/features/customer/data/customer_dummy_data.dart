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
      id: 'ac',
      name: 'AC',
      description: 'AC tidak dingin, bocor, cuci AC',
      icon: Icons.ac_unit_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 10,
    ),
    CustomerServiceCategory(
      id: 'washer',
      name: 'Mesin Cuci',
      description: 'Tidak berputar, bocor, pengering mati',
      icon: Icons.local_laundry_service_rounded,
      color: Color(0xFFF97316),
      serviceCount: 8,
    ),
    CustomerServiceCategory(
      id: 'tv',
      name: 'TV',
      description: 'TV mati, panel, backlight',
      icon: Icons.tv_rounded,
      color: Color(0xFF22C55E),
      serviceCount: 9,
    ),
    CustomerServiceCategory(
      id: 'phone',
      name: 'HP',
      description: 'LCD, baterai, charging, kamera',
      icon: Icons.phone_android_rounded,
      color: Color(0xFFEAB308),
      serviceCount: 18,
    ),
  ];
});

final customerServicesProvider = Provider<List<CustomerService>>((ref) {
  return const [
    CustomerService(
      id: 'phone-lcd',
      categoryId: 'phone',
      title: 'Servis HP',
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
      title: 'Ganti Baterai HP',
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
      id: 'ac-cleaning',
      categoryId: 'ac',
      title: 'Cuci AC',
      description:
          'Pembersihan unit indoor dan outdoor untuk AC lebih dingin dan sehat.',
      icon: Icons.ac_unit_rounded,
      basePrice: 90000,
      estimatedTime: '1 jam',
      rating: 4.7,
      completedJobs: 74,
      features: [
        'Cek tekanan freon',
        'Bersihkan filter dan evaporator',
        'Invoice otomatis',
      ],
    ),
    CustomerService(
      id: 'ac-repair',
      categoryId: 'ac',
      title: 'Servis AC Tidak Dingin',
      description: 'Diagnosa AC tidak dingin, bocor, atau suara berisik.',
      icon: Icons.mode_fan_off_rounded,
      basePrice: 150000,
      estimatedTime: '1-2 jam',
      rating: 4.9,
      completedJobs: 142,
      features: ['Diagnosa kerusakan', 'Penawaran sparepart', 'Garansi jasa'],
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
      categoryId: 'washer',
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_assets.dart';

class CustomerServiceCategory {
  const CustomerServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.imageAsset,
    required this.color,
    required this.serviceCount,
  });

  final String id;
  final String name;
  final String description;
  final IconData icon;
  final String imageAsset;
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
    required this.imageAsset,
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
  final String imageAsset;
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
    required this.imageAsset,
  });

  final String name;
  final String specialization;
  final double rating;
  final int completedJobs;
  final String distance;
  final String imageAsset;
}

final customerCategoriesProvider = Provider<List<CustomerServiceCategory>>((
  ref,
) {
  return const [
    CustomerServiceCategory(
      id: 'printer',
      name: 'Printer',
      description: 'Tinta macet, hasil buram, paper jam',
      icon: Icons.print_rounded,
      imageAsset: AppAssets.printer,
      color: Color(0xFF2563EB),
      serviceCount: 10,
    ),
    CustomerServiceCategory(
      id: 'computer',
      name: 'Komputer',
      description: 'Tidak menyala, lambat, upgrade komponen',
      icon: Icons.desktop_windows_rounded,
      imageAsset: AppAssets.computer,
      color: Color(0xFFF97316),
      serviceCount: 8,
    ),
    CustomerServiceCategory(
      id: 'laptop',
      name: 'Laptop',
      description: 'Layar, keyboard, baterai, overheat',
      icon: Icons.laptop_mac_rounded,
      imageAsset: AppAssets.laptop,
      color: Color(0xFF22C55E),
      serviceCount: 9,
    ),
  ];
});

final customerServicesProvider = Provider<List<CustomerService>>((ref) {
  return const [
    CustomerService(
      id: 'printer-repair',
      categoryId: 'printer',
      title: 'Servis Printer',
      description:
          'Perbaikan printer tidak menarik kertas, hasil buram, atau tidak terdeteksi.',
      icon: Icons.print_rounded,
      imageAsset: AppAssets.printer,
      basePrice: 150000,
      estimatedTime: '1-2 jam',
      rating: 4.9,
      completedJobs: 126,
      features: [
        'Diagnosa awal gratis',
        'Kompatibel banyak merek',
        'Garansi pengerjaan 7 hari',
      ],
    ),
    CustomerService(
      id: 'printer-maintenance',
      categoryId: 'printer',
      title: 'Perawatan Printer',
      description:
          'Pembersihan head, roller, jalur kertas, dan pengecekan kualitas cetak.',
      icon: Icons.cleaning_services_rounded,
      imageAsset: AppAssets.printer,
      basePrice: 120000,
      estimatedTime: '45 menit',
      rating: 4.8,
      completedJobs: 98,
      features: [
        'Tes hasil cetak',
        'Estimasi harga transparan',
        'Teknisi datang ke lokasi',
      ],
    ),
    CustomerService(
      id: 'computer-tuneup',
      categoryId: 'computer',
      title: 'Optimasi Komputer',
      description:
          'Pembersihan komponen, optimasi sistem, dan pengecekan performa komputer.',
      icon: Icons.desktop_windows_rounded,
      imageAsset: AppAssets.computer,
      basePrice: 90000,
      estimatedTime: '1 jam',
      rating: 4.7,
      completedJobs: 74,
      features: [
        'Cek suhu dan performa',
        'Bersihkan komponen internal',
        'Invoice otomatis',
      ],
    ),
    CustomerService(
      id: 'computer-repair',
      categoryId: 'computer',
      title: 'Komputer Tidak Menyala',
      description: 'Diagnosa power supply, motherboard, RAM, atau penyimpanan.',
      icon: Icons.memory_rounded,
      imageAsset: AppAssets.computer,
      basePrice: 150000,
      estimatedTime: '1-2 jam',
      rating: 4.9,
      completedJobs: 142,
      features: ['Diagnosa kerusakan', 'Penawaran sparepart', 'Garansi jasa'],
    ),
    CustomerService(
      id: 'laptop-screen',
      categoryId: 'laptop',
      title: 'Servis Laptop',
      description:
          'Laptop mati, layar bermasalah, keyboard rusak, atau cepat panas.',
      icon: Icons.laptop_mac_rounded,
      imageAsset: AppAssets.laptop,
      basePrice: 200000,
      estimatedTime: '1-3 hari',
      rating: 4.8,
      completedJobs: 61,
      features: [
        'Diagnosa menyeluruh',
        'Penawaran sparepart',
        'Update status servis',
      ],
    ),
    CustomerService(
      id: 'laptop-upgrade',
      categoryId: 'laptop',
      title: 'Upgrade Laptop',
      description:
          'Upgrade RAM, SSD, thermal paste, dan optimasi performa laptop.',
      icon: Icons.upgrade_rounded,
      imageAsset: AppAssets.laptop,
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
      specialization: 'Printer & Perangkat Cetak',
      rating: 4.9,
      completedJobs: 184,
      distance: '1.8 km',
      imageAsset: AppAssets.technicianBudi,
    ),
    FeaturedTechnician(
      name: 'Andi Kurniawan',
      specialization: 'Laptop & PC',
      rating: 4.8,
      completedJobs: 132,
      distance: '2.4 km',
      imageAsset: AppAssets.technicianAndi,
    ),
    FeaturedTechnician(
      name: 'Rina Wijaya',
      specialization: 'Laptop & Komputer',
      rating: 4.9,
      completedJobs: 96,
      distance: '3.1 km',
      imageAsset: AppAssets.technicianRina,
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

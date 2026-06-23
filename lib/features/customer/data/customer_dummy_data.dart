import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerServiceCategory {
  final String id;
  final String name;
  final IconData icon;
  final String imageAsset;
  final String description;
  final int serviceCount;
  
  CustomerServiceCategory({required this.id, required this.name, IconData? icon, this.imageAsset = '', this.description = '', this.serviceCount = 0}) : icon = icon ?? Icons.category;
}

class CustomerService {
  final String id;
  final String name;
  final String title;
  final String description;
  final int basePrice;
  final String categoryId;
  final String imageAsset;
  final IconData icon;
  final double rating;
  final String estimatedTime;
  final int completedJobs;
  final List<String> features;
  
  CustomerService({required this.id, required this.name, required this.description, required this.basePrice, required this.categoryId, String? title, this.imageAsset = '', IconData? icon, this.rating = 4.5, this.estimatedTime = '1-2 jam', this.completedJobs = 0, this.features = const []}) : title = title ?? name, icon = icon ?? Icons.build;
}

class FeaturedTechnician {
  final String id;
  final String name;
  final String photo;
  final String imageAsset;
  final double rating;
  final int completedJobs;
  final String specialization;
  final String distance;
  
  FeaturedTechnician({required this.id, required this.name, required this.photo, required this.rating, required this.completedJobs, String? imageAsset, this.specialization = '', this.distance = ''}) : imageAsset = imageAsset ?? photo;
}

final customerCategoriesProvider = Provider<List<CustomerServiceCategory>>((ref) => [
  CustomerServiceCategory(id: '1', name: 'Komputer', icon: Icons.computer, serviceCount: 5),
  CustomerServiceCategory(id: '2', name: 'Printer', icon: Icons.print, serviceCount: 3),
  CustomerServiceCategory(id: '3', name: 'Laptop', icon: Icons.laptop, serviceCount: 4),
]);

final customerServicesProvider = Provider<List<CustomerService>>((ref) => [
  CustomerService(id: 'printer-repair', name: 'Servis Printer', description: 'Perbaikan printer', basePrice: 50000, categoryId: '2', features: ['Cek hardware', 'Bersihkan']),
  CustomerService(id: 'laptop-repair', name: 'Servis Laptop', description: 'Perbaikan laptop', basePrice: 100000, categoryId: '3', features: ['Diagnosa', 'Perbaikan']),
]);

final featuredTechniciansProvider = Provider<List<FeaturedTechnician>>((ref) => [
  FeaturedTechnician(id: '1', name: 'Ahmad', photo: '', rating: 4.8, completedJobs: 120, specialization: 'Komputer', distance: '2 km'),
  FeaturedTechnician(id: '2', name: 'Budi', photo: '', rating: 4.7, completedJobs: 95, specialization: 'Printer', distance: '3 km'),
]);

String formatRupiah(int amount) {
  return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
}

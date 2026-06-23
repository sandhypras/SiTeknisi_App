import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';
import '../data/service_repository.dart';

// Repository provider
final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  return ServiceRepository(Supabase.instance.client);
});

// ==================== SERVICE CATEGORIES ====================

final serviceCategoriesProvider =
    FutureProvider<List<ServiceCategory>>((ref) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getActiveCategories();
});

final allServiceCategoriesProvider =
    FutureProvider<List<ServiceCategory>>((ref) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getAllCategories();
});

// ==================== SERVICES ====================

final activeServicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getActiveServices();
});

final servicesByCategoryProvider =
    FutureProvider.family<List<Service>, String>((ref, categoryId) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getServicesByCategory(categoryId);
});

final allServicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getAllServices();
});

final serviceByIdProvider =
    FutureProvider.family<Service?, String>((ref, serviceId) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getServiceById(serviceId);
});

// ==================== ADMIN ACTIONS ====================

final createCategoryProvider =
    Provider<Future<ServiceCategory> Function(CreateCategoryParams)>((ref) {
  return (params) async {
    final repository = ref.read(serviceRepositoryProvider);
    final category = await repository.createCategory(
      name: params.name,
      description: params.description,
      iconName: params.iconName,
      colorHex: params.colorHex,
      displayOrder: params.displayOrder,
    );

    ref.invalidate(serviceCategoriesProvider);
    ref.invalidate(allServiceCategoriesProvider);

    return category;
  };
});

final updateCategoryProvider =
    Provider<Future<ServiceCategory> Function(UpdateCategoryParams)>((ref) {
  return (params) async {
    final repository = ref.read(serviceRepositoryProvider);
    final category = await repository.updateCategory(
      id: params.id,
      name: params.name,
      description: params.description,
      iconName: params.iconName,
      colorHex: params.colorHex,
      displayOrder: params.displayOrder,
      isActive: params.isActive,
    );

    ref.invalidate(serviceCategoriesProvider);
    ref.invalidate(allServiceCategoriesProvider);

    return category;
  };
});

final deleteCategoryProvider = Provider<Future<void> Function(String)>((ref) {
  return (categoryId) async {
    final repository = ref.read(serviceRepositoryProvider);
    await repository.deleteCategory(categoryId);

    ref.invalidate(serviceCategoriesProvider);
    ref.invalidate(allServiceCategoriesProvider);
  };
});

final createServiceProvider =
    Provider<Future<Service> Function(CreateServiceParams)>((ref) {
  return (params) async {
    final repository = ref.read(serviceRepositoryProvider);
    final service = await repository.createService(
      categoryId: params.categoryId,
      name: params.name,
      description: params.description,
      basePrice: params.basePrice,
      estimatedTime: params.estimatedTime,
      features: params.features,
      displayOrder: params.displayOrder,
      iconUrl: params.iconUrl,
    );

    ref.invalidate(activeServicesProvider);
    ref.invalidate(allServicesProvider);
    ref.invalidate(servicesByCategoryProvider(params.categoryId));

    return service;
  };
});

final updateServiceProvider =
    Provider<Future<Service> Function(UpdateServiceParams)>((ref) {
  return (params) async {
    final repository = ref.read(serviceRepositoryProvider);
    final service = await repository.updateService(
      id: params.id,
      categoryId: params.categoryId,
      name: params.name,
      description: params.description,
      basePrice: params.basePrice,
      estimatedTime: params.estimatedTime,
      features: params.features,
      displayOrder: params.displayOrder,
      isActive: params.isActive,
      iconUrl: params.iconUrl,
    );

    ref.invalidate(activeServicesProvider);
    ref.invalidate(allServicesProvider);

    return service;
  };
});

final deleteServiceProvider = Provider<Future<void> Function(String)>((ref) {
  return (serviceId) async {
    final repository = ref.read(serviceRepositoryProvider);
    await repository.deleteService(serviceId);

    ref.invalidate(activeServicesProvider);
    ref.invalidate(allServicesProvider);
  };
});

// ==================== PARAMETER CLASSES ====================

class CreateCategoryParams {
  const CreateCategoryParams({
    required this.name,
    required this.description,
    required this.iconName,
    required this.colorHex,
    this.displayOrder = 0,
  });

  final String name;
  final String description;
  final String iconName;
  final String colorHex;
  final int displayOrder;
}

class UpdateCategoryParams {
  const UpdateCategoryParams({
    required this.id,
    this.name,
    this.description,
    this.iconName,
    this.colorHex,
    this.displayOrder,
    this.isActive,
  });

  final String id;
  final String? name;
  final String? description;
  final String? iconName;
  final String? colorHex;
  final int? displayOrder;
  final bool? isActive;
}

class CreateServiceParams {
  const CreateServiceParams({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.estimatedTime,
    required this.features,
    this.displayOrder = 0,
    this.iconUrl,
  });

  final String categoryId;
  final String name;
  final String description;
  final double basePrice;
  final String estimatedTime;
  final List<String> features;
  final int displayOrder;
  final String? iconUrl;
}

class UpdateServiceParams {
  const UpdateServiceParams({
    required this.id,
    this.categoryId,
    this.name,
    this.description,
    this.basePrice,
    this.estimatedTime,
    this.features,
    this.displayOrder,
    this.isActive,
    this.iconUrl,
  });

  final String id;
  final String? categoryId;
  final String? name;
  final String? description;
  final double? basePrice;
  final String? estimatedTime;
  final List<String>? features;
  final int? displayOrder;
  final bool? isActive;
  final String? iconUrl;
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';

class ServiceRepository {
  ServiceRepository(this._supabase);

  final SupabaseClient _supabase;

  // ==================== SERVICE CATEGORIES ====================

  /// Fetch semua kategori aktif (untuk customer & technician)
  Future<List<ServiceCategory>> getActiveCategories() async {
    final response = await _supabase
        .from('service_categories')
        .select()
        .eq('is_active', true)
        .order('display_order');

    return (response as List)
        .map((json) => ServiceCategory.fromJson(json))
        .toList();
  }

  /// Fetch semua kategori (untuk admin)
  Future<List<ServiceCategory>> getAllCategories() async {
    final response = await _supabase
        .from('service_categories')
        .select()
        .order('display_order');

    return (response as List)
        .map((json) => ServiceCategory.fromJson(json))
        .toList();
  }

  /// Create kategori baru (admin only)
  Future<ServiceCategory> createCategory({
    required String name,
    required String description,
    required String iconName,
    required String colorHex,
    int displayOrder = 0,
  }) async {
    final response = await _supabase
        .from('service_categories')
        .insert({
          'name': name,
          'description': description,
          'icon_name': iconName,
          'color_hex': colorHex,
          'display_order': displayOrder,
        })
        .select()
        .single();

    return ServiceCategory.fromJson(response);
  }

  /// Update kategori (admin only)
  Future<ServiceCategory> updateCategory({
    required String id,
    String? name,
    String? description,
    String? iconName,
    String? colorHex,
    int? displayOrder,
    bool? isActive,
  }) async {
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (iconName != null) data['icon_name'] = iconName;
    if (colorHex != null) data['color_hex'] = colorHex;
    if (displayOrder != null) data['display_order'] = displayOrder;
    if (isActive != null) data['is_active'] = isActive;

    final response = await _supabase
        .from('service_categories')
        .update(data)
        .eq('id', id)
        .select()
        .single();

    return ServiceCategory.fromJson(response);
  }

  /// Delete kategori (admin only)
  Future<void> deleteCategory(String id) async {
    await _supabase.from('service_categories').delete().eq('id', id);
  }

  // ==================== SERVICES ====================

  /// Fetch layanan aktif berdasarkan kategori
  Future<List<Service>> getServicesByCategory(String categoryId) async {
    final response = await _supabase
        .from('services')
        .select()
        .eq('category_id', categoryId)
        .eq('is_active', true)
        .order('display_order');

    return (response as List).map((json) => Service.fromJson(json)).toList();
  }

  /// Fetch semua layanan aktif
  Future<List<Service>> getActiveServices() async {
    final response = await _supabase
        .from('services')
        .select()
        .eq('is_active', true)
        .order('display_order');

    return (response as List).map((json) => Service.fromJson(json)).toList();
  }

  /// Fetch semua layanan (untuk admin)
  Future<List<Service>> getAllServices() async {
    final response =
        await _supabase.from('services').select().order('display_order');

    return (response as List).map((json) => Service.fromJson(json)).toList();
  }

  /// Get service by ID
  Future<Service?> getServiceById(String id) async {
    final response =
        await _supabase.from('services').select().eq('id', id).maybeSingle();

    if (response == null) return null;
    return Service.fromJson(response);
  }

  /// Create service baru (admin only)
  Future<Service> createService({
    required String categoryId,
    required String name,
    required String description,
    required double basePrice,
    required String estimatedTime,
    required List<String> features,
    int displayOrder = 0,
    String? iconUrl,
  }) async {
    final response = await _supabase
        .from('services')
        .insert({
          'category_id': categoryId,
          'name': name,
          'description': description,
          'base_price': basePrice,
          'estimated_time': estimatedTime,
          'features': features,
          'display_order': displayOrder,
          'icon_url': iconUrl,
        })
        .select()
        .single();

    return Service.fromJson(response);
  }

  /// Update service (admin only)
  Future<Service> updateService({
    required String id,
    String? categoryId,
    String? name,
    String? description,
    double? basePrice,
    String? estimatedTime,
    List<String>? features,
    int? displayOrder,
    bool? isActive,
    String? iconUrl,
  }) async {
    final data = <String, dynamic>{};
    if (categoryId != null) data['category_id'] = categoryId;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (basePrice != null) data['base_price'] = basePrice;
    if (estimatedTime != null) data['estimated_time'] = estimatedTime;
    if (features != null) data['features'] = features;
    if (displayOrder != null) data['display_order'] = displayOrder;
    if (isActive != null) data['is_active'] = isActive;
    if (iconUrl != null) data['icon_url'] = iconUrl;

    final response = await _supabase
        .from('services')
        .update(data)
        .eq('id', id)
        .select()
        .single();

    return Service.fromJson(response);
  }

  /// Delete service (admin only)
  Future<void> deleteService(String id) async {
    await _supabase.from('services').delete().eq('id', id);
  }

  // ==================== REALTIME SUBSCRIPTIONS ====================

  /// Subscribe ke perubahan kategori (untuk auto-refresh UI)
  RealtimeChannel subscribeToCategories(
    void Function(List<ServiceCategory>) onData,
  ) {
    return _supabase
        .channel('service_categories_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'service_categories',
          callback: (_) async {
            final categories = await getActiveCategories();
            onData(categories);
          },
        )
        .subscribe();
  }

  /// Subscribe ke perubahan services
  RealtimeChannel subscribeToServices(void Function(List<Service>) onData) {
    return _supabase.channel('services_changes').onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'services',
          callback: (_) async {
            final services = await getActiveServices();
            onData(services);
          },
        ).subscribe();
  }
}

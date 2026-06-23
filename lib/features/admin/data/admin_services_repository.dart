import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final String id;
  final String name;
  final String category;
  final String description;
  final int basePrice;
  final String estimatedTime;
  final String? imageUrl;
  final bool isActive;
  
  AdminService({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.basePrice,
    required this.estimatedTime,
    this.imageUrl,
    required this.isActive,
  });
  
  factory AdminService.fromJson(Map<String, dynamic> json) => AdminService(
    id: json['id'] as String,
    name: json['name'] as String,
    category: json['category'] as String? ?? 'Komputer',
    description: json['description'] as String? ?? '',
    basePrice: json['base_price'] as int? ?? 0,
    estimatedTime: json['estimated_duration'] as String? ?? '1-2 jam',
    imageUrl: json['image_url'] as String?,
    isActive: json['is_active'] as bool? ?? true,
  );
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'category': category,
    'description': description,
    'base_price': basePrice,
    'estimated_duration': estimatedTime,
    'image_url': imageUrl,
    'is_active': isActive,
    'updated_at': DateTime.now().toIso8601String(),
  };
}

class AdminServicesRepository {
  final SupabaseClient _client;
  
  AdminServicesRepository(this._client);
  
  Future<List<AdminService>> getServices({String? status}) async {
    var query = _client.from('services').select();
    
    if (status != null && status != 'Semua') {
      final isActive = status == 'Aktif';
      query = query.eq('is_active', isActive);
    }
    
    final response = await query.order('name');
    return (response as List).map((json) => AdminService.fromJson(json)).toList();
  }
  
  Future<void> createService(AdminService service) async {
    await _client.from('services').insert({
      ...service.toJson(),
      'created_at': DateTime.now().toIso8601String(),
    });
  }
  
  Future<void> updateService(String id, AdminService service) async {
    await _client.from('services').update(service.toJson()).eq('id', id);
  }
  
  Future<void> deleteService(String id) async {
    await _client.from('services').delete().eq('id', id);
  }
}

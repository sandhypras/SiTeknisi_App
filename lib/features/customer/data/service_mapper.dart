import 'package:supabase_flutter/supabase_flutter.dart';

/// Service data from database
class Service {
  const Service({
    required this.id,
    required this.name,
    required this.description,
    this.iconUrl,
    required this.isActive,
  });

  final String id;
  final String name;
  final String description;
  final String? iconUrl;
  final bool isActive;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      iconUrl: json['icon_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}

/// Helper to get service ID from database by name
class ServiceMapper {
  ServiceMapper(this._client);

  final SupabaseClient _client;
  final Map<String, String> _cache = {};

  /// Get service UUID by dummy service ID (which matches title)
  /// Maps dummy IDs like 'printer-repair' to database UUID
  Future<String?> getServiceIdByDummyId(String dummyId) async {
    // Check cache first
    if (_cache.containsKey(dummyId)) {
      return _cache[dummyId];
    }

    // Map dummy ID to service name
    final serviceName = _mapDummyIdToName(dummyId);
    
    try {
      final response = await _client
          .from('services')
          .select('id, name')
          .eq('name', serviceName)
          .single();

      final id = response['id'] as String;
      _cache[dummyId] = id;
      return id;
    } catch (e) {
      return null;
    }
  }

  /// Get all services from database
  Future<List<Service>> getAllServices() async {
    try {
      final response = await _client
          .from('services')
          .select()
          .eq('is_active', true)
          .order('name');

      return (response as List)
          .map((item) => Service.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Map dummy service ID to actual service name in database
  String _mapDummyIdToName(String dummyId) {
    switch (dummyId) {
      case 'printer-repair':
        return 'Servis Printer';
      case 'printer-maintenance':
        return 'Perawatan Printer';
      case 'computer-tuneup':
        return 'Optimasi Komputer';
      case 'computer-repair':
        return 'Komputer Tidak Menyala';
      case 'laptop-screen':
        return 'Servis Laptop';
      case 'laptop-upgrade':
        return 'Upgrade Laptop';
      default:
        return dummyId; // Fallback to dummy ID
    }
  }

  /// Clear cache
  void clearCache() {
    _cache.clear();
  }
}

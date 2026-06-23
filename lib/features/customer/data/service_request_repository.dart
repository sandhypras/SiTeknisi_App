import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Exception thrown when service request operations fail
class ServiceRequestException implements Exception {
  const ServiceRequestException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Model for service request data
class ServiceRequest {
  const ServiceRequest({
    required this.id,
    required this.customerId,
    required this.serviceId,
    required this.title,
    required this.description,
    required this.address,
    this.latitude,
    this.longitude,
    this.photoUrl,
    this.preferredSchedule,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String customerId;
  final String serviceId;
  final String title;
  final String description;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? photoUrl;
  final DateTime? preferredSchedule;
  final String status; // draft, open, offered, booked, in_progress, completed, cancelled
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      serviceId: json['service_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      latitude: json['latitude'] != null 
          ? (json['latitude'] as num).toDouble() 
          : null,
      longitude: json['longitude'] != null 
          ? (json['longitude'] as num).toDouble() 
          : null,
      photoUrl: json['photo_url'] as String?,
      preferredSchedule: json['preferred_schedule'] != null
          ? DateTime.parse(json['preferred_schedule'] as String)
          : null,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'service_id': serviceId,
      'title': title,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'photo_url': photoUrl,
      'preferred_schedule': preferredSchedule?.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// Repository for service request operations
class ServiceRequestRepository {
  ServiceRequestRepository(this._client);

  final SupabaseClient _client;
  
  /// Expose client for ServiceMapper access
  SupabaseClient get client => _client;

  /// Create a new service request
  Future<ServiceRequest> createRequest({
    required String serviceId,
    required String title,
    required String description,
    required String address,
    double? latitude,
    double? longitude,
    String? photoUrl,
    DateTime? preferredSchedule,
  }) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        throw const ServiceRequestException(
          'User not authenticated. Please login first.',
        );
      }

      if (kDebugMode) {
        print('\n📝 Creating service request...');
        print('  Service ID: $serviceId');
        print('  Title: $title');
        print('  Customer ID: $userId');
      }

      final data = {
        'customer_id': userId,
        'service_id': serviceId,
        'title': title,
        'description': description,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'photo_url': photoUrl,
        'preferred_schedule': preferredSchedule?.toIso8601String(),
        'status': 'open',
      };

      final response = await _client
          .from('service_requests')
          .insert(data)
          .select()
          .single();

      if (kDebugMode) {
        print('✅ Service request created: ${response['id']}');
      }

      return ServiceRequest.fromJson(response);
    } on PostgrestException catch (e) {
      if (kDebugMode) {
        print('❌ PostgrestException: ${e.message}');
        print('   Code: ${e.code}');
        print('   Details: ${e.details}');
      }
      throw ServiceRequestException(
        'Failed to create service request: ${e.message}',
      );
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error: $e');
      }
      throw ServiceRequestException(
        'Failed to create service request: $e',
      );
    }
  }

  /// Get service request by ID
  Future<ServiceRequest> getRequestById(String id) async {
    try {
      final response = await _client
          .from('service_requests')
          .select()
          .eq('id', id)
          .single();

      return ServiceRequest.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServiceRequestException(
        'Failed to fetch service request: ${e.message}',
      );
    }
  }

  /// Get all requests by customer
  Future<List<ServiceRequest>> getRequestsByCustomer() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        throw const ServiceRequestException('User not authenticated');
      }

      final response = await _client
          .from('service_requests')
          .select()
          .eq('customer_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((item) => ServiceRequest.fromJson(item as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw ServiceRequestException(
        'Failed to fetch service requests: ${e.message}',
      );
    }
  }

  /// Update service request status
  Future<ServiceRequest> updateStatus(String id, String status) async {
    try {
      final response = await _client
          .from('service_requests')
          .update({'status': status})
          .eq('id', id)
          .select()
          .single();

      return ServiceRequest.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServiceRequestException(
        'Failed to update service request: ${e.message}',
      );
    }
  }

  /// Delete service request
  Future<void> deleteRequest(String id) async {
    try {
      await _client
          .from('service_requests')
          .delete()
          .eq('id', id);

      if (kDebugMode) {
        print('✅ Service request deleted: $id');
      }
    } on PostgrestException catch (e) {
      throw ServiceRequestException(
        'Failed to delete service request: ${e.message}',
      );
    }
  }

  /// Get open requests (for technician view)
  Future<List<ServiceRequest>> getOpenRequests({
    String? serviceId,
    int limit = 20,
  }) async {
    try {
      var query = _client
          .from('service_requests')
          .select()
          .eq('status', 'open');

      if (serviceId != null) {
        query = query.eq('service_id', serviceId);
      }

      final response = await query
          .order('created_at', ascending: false)
          .limit(limit);

      return (response as List)
          .map((item) => ServiceRequest.fromJson(item as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw ServiceRequestException(
        'Failed to fetch open requests: ${e.message}',
      );
    }
  }
}

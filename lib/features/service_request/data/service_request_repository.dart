import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';

class ServiceRequestRepository {
  ServiceRequestRepository(this._supabase);

  final SupabaseClient _supabase;

  // ==================== CREATE & UPLOAD ====================

  /// Create service request dengan upload foto
  Future<ServiceRequest> createRequest({
    required String serviceId,
    required String title,
    required String description,
    required String address,
    double? latitude,
    double? longitude,
    List<File>? photos,
    DateTime? preferredSchedule,
    double? budgetMin,
    double? budgetMax,
    RequestUrgency urgency = RequestUrgency.normal,
    String? notes,
    bool publishImmediately = true,
  }) async {
    final customerId = _supabase.auth.currentUser!.id;

    // Upload photos jika ada
    List<String>? photoUrls;
    if (photos != null && photos.isNotEmpty) {
      photoUrls = await _uploadRequestPhotos(customerId, photos);
    }

    // Insert request
    final response = await _supabase
        .from('service_requests')
        .insert({
          'customer_id': customerId,
          'service_id': serviceId,
          'title': title,
          'description': description,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
          'photo_urls': photoUrls,
          'preferred_schedule': preferredSchedule?.toIso8601String(),
          'budget_min': budgetMin,
          'budget_max': budgetMax,
          'status': publishImmediately ? 'open' : 'draft',
          'urgency': urgency.name,
          'notes': notes,
        })
        .select()
        .single();

    return ServiceRequest.fromJson(response);
  }

  /// Upload multiple photos untuk request
  Future<List<String>> _uploadRequestPhotos(
    String customerId,
    List<File> photos,
  ) async {
    final urls = <String>[];

    for (var i = 0; i < photos.length; i++) {
      final file = photos[i];
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = file.path.split('.').last;
      final filePath = '$customerId/request_${timestamp}_$i.$extension';

      await _supabase.storage.from('request-photos').upload(
            filePath,
            file,
            fileOptions: const FileOptions(upsert: false),
          );

      final url =
          _supabase.storage.from('request-photos').getPublicUrl(filePath);
      urls.add(url);
    }

    return urls;
  }

  /// Add foto ke existing request
  Future<ServiceRequest> addPhotosToRequest(
    String requestId,
    List<File> photos,
  ) async {
    final customerId = _supabase.auth.currentUser!.id;

    // Get existing request
    final request = await getRequestById(requestId);
    if (request == null || request.customerId != customerId) {
      throw Exception('Request not found or unauthorized');
    }

    // Upload new photos
    final newPhotoUrls = await _uploadRequestPhotos(customerId, photos);

    // Merge dengan existing photos
    final allPhotoUrls = [...?request.photoUrls, ...newPhotoUrls];

    // Update request
    final response = await _supabase
        .from('service_requests')
        .update({'photo_urls': allPhotoUrls})
        .eq('id', requestId)
        .select()
        .single();

    return ServiceRequest.fromJson(response);
  }

  // ==================== READ ====================

  /// Get request by ID
  Future<ServiceRequest?> getRequestById(String requestId) async {
    final response = await _supabase
        .from('service_requests')
        .select()
        .eq('id', requestId)
        .maybeSingle();

    if (response == null) return null;
    return ServiceRequest.fromJson(response);
  }

  /// Get customer's own requests
  Future<List<ServiceRequest>> getMyRequests({
    RequestStatus? status,
    int limit = 50,
  }) async {
    var query = _supabase
        .from('service_requests')
        .select()
        .eq('customer_id', _supabase.auth.currentUser!.id)
        .order('created_at', ascending: false)
        .limit(limit);

    if (status != null) {
      query = query.eq('status', status.dbValue);
    }

    final response = await query;
    return (response as List)
        .map((json) => ServiceRequest.fromJson(json))
        .toList();
  }

  /// Get open requests (untuk teknisi)
  Future<List<ServiceRequest>> getOpenRequests({
    String? serviceId,
    double? latitude,
    double? longitude,
    double? radiusKm,
    int limit = 50,
  }) async {
    var query = _supabase
        .from('service_requests')
        .select()
        .eq('status', 'open')
        .order('created_at', ascending: false)
        .limit(limit);

    if (serviceId != null) {
      query = query.eq('service_id', serviceId);
    }

    final response = await query;
    var requests = (response as List)
        .map((json) => ServiceRequest.fromJson(json))
        .toList();

    // Filter by radius jika ada koordinat
    if (latitude != null && longitude != null && radiusKm != null) {
      requests = requests.where((req) {
        if (req.latitude == null || req.longitude == null) return false;
        final distance = _calculateDistance(
          latitude,
          longitude,
          req.latitude!,
          req.longitude!,
        );
        return distance <= radiusKm;
      }).toList();
    }

    return requests;
  }

  /// Get requests yang sudah teknisi offer
  Future<List<ServiceRequest>> getRequestsIOffered() async {
    final technicianId = _supabase.auth.currentUser!.id;

    final response = await _supabase
        .from('service_requests')
        .select('''
          *,
          service_offers!inner(technician_id)
        ''')
        .eq('service_offers.technician_id', technicianId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ServiceRequest.fromJson(json))
        .toList();
  }

  /// Get all requests (admin only)
  Future<List<ServiceRequest>> getAllRequests({
    RequestStatus? status,
    int limit = 100,
  }) async {
    var query = _supabase
        .from('service_requests')
        .select()
        .order('created_at', ascending: false)
        .limit(limit);

    if (status != null) {
      query = query.eq('status', status.dbValue);
    }

    final response = await query;
    return (response as List)
        .map((json) => ServiceRequest.fromJson(json))
        .toList();
  }

  // ==================== UPDATE ====================

  /// Update request (draft/open only)
  Future<ServiceRequest> updateRequest({
    required String requestId,
    String? title,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? preferredSchedule,
    double? budgetMin,
    double? budgetMax,
    RequestUrgency? urgency,
    String? notes,
  }) async {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (address != null) data['address'] = address;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    if (preferredSchedule != null) {
      data['preferred_schedule'] = preferredSchedule.toIso8601String();
    }
    if (budgetMin != null) data['budget_min'] = budgetMin;
    if (budgetMax != null) data['budget_max'] = budgetMax;
    if (urgency != null) data['urgency'] = urgency.name;
    if (notes != null) data['notes'] = notes;

    final response = await _supabase
        .from('service_requests')
        .update(data)
        .eq('id', requestId)
        .select()
        .single();

    return ServiceRequest.fromJson(response);
  }

  /// Publish request (draft -> open)
  Future<ServiceRequest> publishRequest(String requestId) async {
    final response = await _supabase.rpc(
      'publish_service_request',
      params: {'request_id': requestId},
    );

    return ServiceRequest.fromJson(response);
  }

  /// Cancel request
  Future<ServiceRequest> cancelRequest(
    String requestId, {
    String? reason,
  }) async {
    final response = await _supabase.rpc(
      'cancel_service_request',
      params: {
        'request_id': requestId,
        'cancel_reason': reason,
      },
    );

    return ServiceRequest.fromJson(response);
  }

  // ==================== DELETE ====================

  /// Delete draft request
  Future<void> deleteRequest(String requestId) async {
    await _supabase.from('service_requests').delete().eq('id', requestId);
  }

  // ==================== REALTIME ====================

  /// Subscribe ke new requests (untuk teknisi)
  RealtimeChannel subscribeToNewRequests(
    void Function(ServiceRequest) onNewRequest,
  ) {
    return _supabase
        .channel('new_requests')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'service_requests',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'status',
            value: 'open',
          ),
          callback: (payload) {
            final request = ServiceRequest.fromJson(
              payload.newRecord as Map<String, dynamic>,
            );
            onNewRequest(request);
          },
        )
        .subscribe();
  }

  /// Subscribe ke request status updates
  RealtimeChannel subscribeToRequestUpdates(
    String requestId,
    void Function(ServiceRequest) onUpdate,
  ) {
    return _supabase
        .channel('request_$requestId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'service_requests',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: requestId,
          ),
          callback: (payload) {
            final request = ServiceRequest.fromJson(
              payload.newRecord as Map<String, dynamic>,
            );
            onUpdate(request);
          },
        )
        .subscribe();
  }

  // ==================== HELPERS ====================

  /// Calculate distance between two coordinates (Haversine formula)
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadiusKm = 6371;

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = (dLat / 2).sin() * (dLat / 2).sin() +
        _degreesToRadians(lat1).cos() *
            _degreesToRadians(lat2).cos() *
            (dLon / 2).sin() *
            (dLon / 2).sin();

    final c = 2 * a.sqrt().asin();

    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * 3.141592653589793 / 180;
  }
}

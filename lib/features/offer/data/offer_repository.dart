import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';

class OfferRepository {
  OfferRepository(this._supabase);

  final SupabaseClient _supabase;

  // ==================== CREATE ====================

  /// Teknisi create offer untuk request
  Future<ServiceOffer> createOffer({
    required String requestId,
    required double offerPrice,
    double transportFee = 0,
    String? estimatedDuration,
    String? message,
    List<File>? photos,
    DateTime? expiresAt,
  }) async {
    final technicianId = _supabase.auth.currentUser!.id;

    // Upload photos jika ada
    List<String>? photoUrls;
    if (photos != null && photos.isNotEmpty) {
      photoUrls = await _uploadOfferPhotos(technicianId, photos);
    }

    // Insert offer
    final response = await _supabase
        .from('service_offers')
        .insert({
          'request_id': requestId,
          'technician_id': technicianId,
          'offer_price': offerPrice,
          'transport_fee': transportFee,
          'estimated_duration': estimatedDuration,
          'message': message,
          'photo_urls': photoUrls,
          'expires_at': expiresAt?.toIso8601String(),
        })
        .select()
        .single();

    return ServiceOffer.fromJson(response);
  }

  /// Upload photos untuk offer
  Future<List<String>> _uploadOfferPhotos(
    String technicianId,
    List<File> photos,
  ) async {
    final urls = <String>[];

    for (var i = 0; i < photos.length; i++) {
      final file = photos[i];
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = file.path.split('.').last;
      final filePath = '$technicianId/offer_${timestamp}_$i.$extension';

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

  // ==================== READ ====================

  /// Get offer by ID
  Future<ServiceOffer?> getOfferById(String offerId) async {
    final response = await _supabase
        .from('service_offers')
        .select()
        .eq('id', offerId)
        .maybeSingle();

    if (response == null) return null;
    return ServiceOffer.fromJson(response);
  }

  /// Get offers untuk specific request (customer view)
  Future<List<ServiceOffer>> getOffersForRequest(String requestId) async {
    final response = await _supabase
        .from('service_offers')
        .select()
        .eq('request_id', requestId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ServiceOffer.fromJson(json))
        .toList();
  }

  /// Get offers dengan technician profile (untuk comparison)
  Future<List<OfferWithTechnician>> getOffersWithTechnicianForRequest(
    String requestId,
  ) async {
    final response = await _supabase
        .from('service_offers')
        .select('''
          *,
          profiles:technician_id (
            full_name,
            phone,
            avatar_url
          )
        ''')
        .eq('request_id', requestId)
        .order('created_at', ascending: false);

    return (response as List).map((json) {
      final profile = json['profiles'] as Map<String, dynamic>?;

      return OfferWithTechnician(
        offer: ServiceOffer.fromJson(json),
        technicianName: profile?['full_name'] as String? ?? 'Unknown',
        technicianPhone: profile?['phone'] as String?,
        technicianAvatar: profile?['avatar_url'] as String?,
        // TODO: Add rating dari reviews aggregation
      );
    }).toList();
  }

  /// Get offers milik teknisi
  Future<List<ServiceOffer>> getMyOffers({
    OfferStatus? status,
    int limit = 50,
  }) async {
    var query = _supabase
        .from('service_offers')
        .select()
        .eq('technician_id', _supabase.auth.currentUser!.id)
        .order('created_at', ascending: false)
        .limit(limit);

    if (status != null) {
      query = query.eq('status', status.name);
    }

    final response = await query;
    return (response as List)
        .map((json) => ServiceOffer.fromJson(json))
        .toList();
  }

  /// Get all offers (admin)
  Future<List<ServiceOffer>> getAllOffers({
    OfferStatus? status,
    int limit = 100,
  }) async {
    var query = _supabase
        .from('service_offers')
        .select()
        .order('created_at', ascending: false)
        .limit(limit);

    if (status != null) {
      query = query.eq('status', status.name);
    }

    final response = await query;
    return (response as List)
        .map((json) => ServiceOffer.fromJson(json))
        .toList();
  }

  // ==================== UPDATE ====================

  /// Update offer (pending only)
  Future<ServiceOffer> updateOffer({
    required String offerId,
    double? offerPrice,
    double? transportFee,
    String? estimatedDuration,
    String? message,
    DateTime? expiresAt,
  }) async {
    final data = <String, dynamic>{};
    if (offerPrice != null) data['offer_price'] = offerPrice;
    if (transportFee != null) data['transport_fee'] = transportFee;
    if (estimatedDuration != null) {
      data['estimated_duration'] = estimatedDuration;
    }
    if (message != null) data['message'] = message;
    if (expiresAt != null) data['expires_at'] = expiresAt.toIso8601String();

    final response = await _supabase
        .from('service_offers')
        .update(data)
        .eq('id', offerId)
        .select()
        .single();

    return ServiceOffer.fromJson(response);
  }

  /// Accept offer (customer action)
  Future<AcceptOfferResult> acceptOffer(String offerId) async {
    final response = await _supabase.rpc(
      'accept_service_offer',
      params: {'offer_id_param': offerId},
    );

    return AcceptOfferResult.fromJson(response as Map<String, dynamic>);
  }

  /// Reject offer (customer action)
  Future<ServiceOffer> rejectOffer(String offerId, {String? reason}) async {
    final response = await _supabase.rpc(
      'reject_service_offer',
      params: {
        'offer_id_param': offerId,
        'rejection_reason': reason,
      },
    );

    return ServiceOffer.fromJson(response as Map<String, dynamic>);
  }

  /// Expire old offers (background job)
  Future<void> expireOldOffers() async {
    await _supabase.rpc('expire_old_offers');
  }

  // ==================== DELETE ====================

  /// Teknisi delete own pending offer
  Future<void> deleteOffer(String offerId) async {
    await _supabase.from('service_offers').delete().eq('id', offerId);
  }

  // ==================== REALTIME ====================

  /// Subscribe ke new offers untuk specific request (customer)
  RealtimeChannel subscribeToOffersForRequest(
    String requestId,
    void Function(ServiceOffer) onNewOffer,
  ) {
    return _supabase
        .channel('offers_$requestId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'service_offers',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'request_id',
            value: requestId,
          ),
          callback: (payload) {
            final offer = ServiceOffer.fromJson(
              payload.newRecord as Map<String, dynamic>,
            );
            onNewOffer(offer);
          },
        )
        .subscribe();
  }

  /// Subscribe ke offer status changes (teknisi)
  RealtimeChannel subscribeToOfferStatusChanges(
    void Function(ServiceOffer) onStatusChange,
  ) {
    final technicianId = _supabase.auth.currentUser!.id;

    return _supabase
        .channel('my_offer_status')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'service_offers',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'technician_id',
            value: technicianId,
          ),
          callback: (payload) {
            final offer = ServiceOffer.fromJson(
              payload.newRecord as Map<String, dynamic>,
            );
            onStatusChange(offer);
          },
        )
        .subscribe();
  }

  // ==================== STATISTICS ====================

  /// Get technician offer statistics
  Future<Map<String, dynamic>?> getTechnicianOfferStats(
    String technicianId,
  ) async {
    final response = await _supabase
        .from('offer_statistics')
        .select()
        .eq('technician_id', technicianId)
        .maybeSingle();

    return response;
  }
}

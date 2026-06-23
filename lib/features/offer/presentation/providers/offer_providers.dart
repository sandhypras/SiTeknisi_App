import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';
import '../data/offer_repository.dart';

// Repository provider
final offerRepositoryProvider = Provider<OfferRepository>((ref) {
  return OfferRepository(Supabase.instance.client);
});

// ==================== READ PROVIDERS ====================

/// Get offers for specific request (customer view)
final offersForRequestProvider =
    FutureProvider.family<List<ServiceOffer>, String>((ref, requestId) async {
  final repository = ref.watch(offerRepositoryProvider);
  return repository.getOffersForRequest(requestId);
});

/// Get offers with technician profile (for comparison)
final offersWithTechnicianProvider = FutureProvider.family<
    List<OfferWithTechnician>, String>((ref, requestId) async {
  final repository = ref.watch(offerRepositoryProvider);
  return repository.getOffersWithTechnicianForRequest(requestId);
});

/// Get offer by ID
final offerByIdProvider =
    FutureProvider.family<ServiceOffer?, String>((ref, offerId) async {
  final repository = ref.watch(offerRepositoryProvider);
  return repository.getOfferById(offerId);
});

/// Get my offers (technician)
final myOffersProvider =
    FutureProvider.family<List<ServiceOffer>, OfferStatus?>((ref, status) async {
  final repository = ref.watch(offerRepositoryProvider);
  return repository.getMyOffers(status: status);
});

/// Get all offers (admin)
final allOffersProvider =
    FutureProvider.family<List<ServiceOffer>, OfferStatus?>((ref, status) async {
  final repository = ref.watch(offerRepositoryProvider);
  return repository.getAllOffers(status: status);
});

/// Get technician offer statistics
final technicianOfferStatsProvider =
    FutureProvider.family<Map<String, dynamic>?, String>(
  (ref, technicianId) async {
    final repository = ref.watch(offerRepositoryProvider);
    return repository.getTechnicianOfferStats(technicianId);
  },
);

// ==================== ACTION PROVIDERS ====================

/// Create new offer (technician)
final createOfferProvider =
    Provider<Future<ServiceOffer> Function(CreateOfferParams)>((ref) {
  return (params) async {
    final repository = ref.read(offerRepositoryProvider);
    final offer = await repository.createOffer(
      requestId: params.requestId,
      offerPrice: params.offerPrice,
      transportFee: params.transportFee,
      estimatedDuration: params.estimatedDuration,
      message: params.message,
      photos: params.photos,
      expiresAt: params.expiresAt,
    );

    // Invalidate relevant providers
    ref.invalidate(myOffersProvider);
    ref.invalidate(offersForRequestProvider(params.requestId));
    ref.invalidate(offersWithTechnicianProvider(params.requestId));

    return offer;
  };
});

/// Update offer (technician)
final updateOfferProvider =
    Provider<Future<ServiceOffer> Function(UpdateOfferParams)>((ref) {
  return (params) async {
    final repository = ref.read(offerRepositoryProvider);
    final offer = await repository.updateOffer(
      offerId: params.offerId,
      offerPrice: params.offerPrice,
      transportFee: params.transportFee,
      estimatedDuration: params.estimatedDuration,
      message: params.message,
      expiresAt: params.expiresAt,
    );

    // Invalidate relevant providers
    ref.invalidate(offerByIdProvider(params.offerId));
    ref.invalidate(myOffersProvider);

    return offer;
  };
});

/// Accept offer (customer) - returns booking & payment info
final acceptOfferProvider =
    Provider<Future<AcceptOfferResult> Function(String)>((ref) {
  return (offerId) async {
    final repository = ref.read(offerRepositoryProvider);
    final result = await repository.acceptOffer(offerId);

    // Invalidate all offer-related providers
    ref.invalidate(offerByIdProvider(offerId));
    ref.invalidate(offersForRequestProvider);
    ref.invalidate(offersWithTechnicianProvider);
    ref.invalidate(myOffersProvider);

    return result;
  };
});

/// Reject offer (customer)
final rejectOfferProvider =
    Provider<Future<ServiceOffer> Function(String, String?)>((ref) {
  return (offerId, reason) async {
    final repository = ref.read(offerRepositoryProvider);
    final offer = await repository.rejectOffer(offerId, reason: reason);

    // Invalidate relevant providers
    ref.invalidate(offerByIdProvider(offerId));
    ref.invalidate(offersForRequestProvider);
    ref.invalidate(offersWithTechnicianProvider);

    return offer;
  };
});

/// Delete offer (technician)
final deleteOfferProvider = Provider<Future<void> Function(String)>((ref) {
  return (offerId) async {
    final repository = ref.read(offerRepositoryProvider);
    await repository.deleteOffer(offerId);

    // Invalidate relevant providers
    ref.invalidate(myOffersProvider);
  };
});

/// Expire old offers (background task)
final expireOldOffersProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final repository = ref.read(offerRepositoryProvider);
    await repository.expireOldOffers();

    // Refresh all offer lists
    ref.invalidate(myOffersProvider);
    ref.invalidate(offersForRequestProvider);
  };
});

// ==================== PARAMETER CLASSES ====================

class CreateOfferParams {
  const CreateOfferParams({
    required this.requestId,
    required this.offerPrice,
    this.transportFee = 0,
    this.estimatedDuration,
    this.message,
    this.photos,
    this.expiresAt,
  });

  final String requestId;
  final double offerPrice;
  final double transportFee;
  final String? estimatedDuration;
  final String? message;
  final List<File>? photos;
  final DateTime? expiresAt;
}

class UpdateOfferParams {
  const UpdateOfferParams({
    required this.offerId,
    this.offerPrice,
    this.transportFee,
    this.estimatedDuration,
    this.message,
    this.expiresAt,
  });

  final String offerId;
  final double? offerPrice;
  final double? transportFee;
  final String? estimatedDuration;
  final String? message;
  final DateTime? expiresAt;
}

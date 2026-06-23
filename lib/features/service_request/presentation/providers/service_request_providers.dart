import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';
import '../data/service_request_repository.dart';

// Repository provider
final serviceRequestRepositoryProvider =
    Provider<ServiceRequestRepository>((ref) {
  return ServiceRequestRepository(Supabase.instance.client);
});

// ==================== READ PROVIDERS ====================

/// Get customer's own requests
final myRequestsProvider = FutureProvider.family<List<ServiceRequest>,
    RequestStatus?>((ref, status) async {
  final repository = ref.watch(serviceRequestRepositoryProvider);
  return repository.getMyRequests(status: status);
});

/// Get request by ID
final requestByIdProvider =
    FutureProvider.family<ServiceRequest?, String>((ref, requestId) async {
  final repository = ref.watch(serviceRequestRepositoryProvider);
  return repository.getRequestById(requestId);
});

/// Get open requests (untuk teknisi)
final openRequestsProvider =
    FutureProvider.family<List<ServiceRequest>, OpenRequestsParams>(
  (ref, params) async {
    final repository = ref.watch(serviceRequestRepositoryProvider);
    return repository.getOpenRequests(
      serviceId: params.serviceId,
      latitude: params.latitude,
      longitude: params.longitude,
      radiusKm: params.radiusKm,
      limit: params.limit,
    );
  },
);

/// Get requests yang teknisi sudah offer
final requestsIOfferedProvider =
    FutureProvider<List<ServiceRequest>>((ref) async {
  final repository = ref.watch(serviceRequestRepositoryProvider);
  return repository.getRequestsIOffered();
});

/// Get all requests (admin only)
final allRequestsProvider = FutureProvider.family<List<ServiceRequest>,
    RequestStatus?>((ref, status) async {
  final repository = ref.watch(serviceRequestRepositoryProvider);
  return repository.getAllRequests(status: status);
});

// ==================== ACTION PROVIDERS ====================

/// Create new service request
final createRequestProvider =
    Provider<Future<ServiceRequest> Function(CreateRequestParams)>((ref) {
  return (params) async {
    final repository = ref.read(serviceRequestRepositoryProvider);
    final request = await repository.createRequest(
      serviceId: params.serviceId,
      title: params.title,
      description: params.description,
      address: params.address,
      latitude: params.latitude,
      longitude: params.longitude,
      photos: params.photos,
      preferredSchedule: params.preferredSchedule,
      budgetMin: params.budgetMin,
      budgetMax: params.budgetMax,
      urgency: params.urgency,
      notes: params.notes,
      publishImmediately: params.publishImmediately,
    );

    // Invalidate relevant providers
    ref.invalidate(myRequestsProvider);

    return request;
  };
});

/// Add photos to existing request
final addPhotosToRequestProvider =
    Provider<Future<ServiceRequest> Function(String, List<File>)>((ref) {
  return (requestId, photos) async {
    final repository = ref.read(serviceRequestRepositoryProvider);
    final request = await repository.addPhotosToRequest(requestId, photos);

    // Invalidate relevant providers
    ref.invalidate(requestByIdProvider(requestId));
    ref.invalidate(myRequestsProvider);

    return request;
  };
});

/// Update service request
final updateRequestProvider =
    Provider<Future<ServiceRequest> Function(UpdateRequestParams)>((ref) {
  return (params) async {
    final repository = ref.read(serviceRequestRepositoryProvider);
    final request = await repository.updateRequest(
      requestId: params.requestId,
      title: params.title,
      description: params.description,
      address: params.address,
      latitude: params.latitude,
      longitude: params.longitude,
      preferredSchedule: params.preferredSchedule,
      budgetMin: params.budgetMin,
      budgetMax: params.budgetMax,
      urgency: params.urgency,
      notes: params.notes,
    );

    // Invalidate relevant providers
    ref.invalidate(requestByIdProvider(params.requestId));
    ref.invalidate(myRequestsProvider);

    return request;
  };
});

/// Publish request (draft -> open)
final publishRequestProvider =
    Provider<Future<ServiceRequest> Function(String)>((ref) {
  return (requestId) async {
    final repository = ref.read(serviceRequestRepositoryProvider);
    final request = await repository.publishRequest(requestId);

    // Invalidate relevant providers
    ref.invalidate(requestByIdProvider(requestId));
    ref.invalidate(myRequestsProvider);
    ref.invalidate(openRequestsProvider);

    return request;
  };
});

/// Cancel request
final cancelRequestProvider =
    Provider<Future<ServiceRequest> Function(String, String?)>((ref) {
  return (requestId, reason) async {
    final repository = ref.read(serviceRequestRepositoryProvider);
    final request = await repository.cancelRequest(requestId, reason: reason);

    // Invalidate relevant providers
    ref.invalidate(requestByIdProvider(requestId));
    ref.invalidate(myRequestsProvider);

    return request;
  };
});

/// Delete draft request
final deleteRequestProvider = Provider<Future<void> Function(String)>((ref) {
  return (requestId) async {
    final repository = ref.read(serviceRequestRepositoryProvider);
    await repository.deleteRequest(requestId);

    // Invalidate relevant providers
    ref.invalidate(myRequestsProvider);
  };
});

// ==================== PARAMETER CLASSES ====================

class CreateRequestParams {
  const CreateRequestParams({
    required this.serviceId,
    required this.title,
    required this.description,
    required this.address,
    this.latitude,
    this.longitude,
    this.photos,
    this.preferredSchedule,
    this.budgetMin,
    this.budgetMax,
    this.urgency = RequestUrgency.normal,
    this.notes,
    this.publishImmediately = true,
  });

  final String serviceId;
  final String title;
  final String description;
  final String address;
  final double? latitude;
  final double? longitude;
  final List<File>? photos;
  final DateTime? preferredSchedule;
  final double? budgetMin;
  final double? budgetMax;
  final RequestUrgency urgency;
  final String? notes;
  final bool publishImmediately;
}

class UpdateRequestParams {
  const UpdateRequestParams({
    required this.requestId,
    this.title,
    this.description,
    this.address,
    this.latitude,
    this.longitude,
    this.preferredSchedule,
    this.budgetMin,
    this.budgetMax,
    this.urgency,
    this.notes,
  });

  final String requestId;
  final String? title;
  final String? description;
  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime? preferredSchedule;
  final double? budgetMin;
  final double? budgetMax;
  final RequestUrgency? urgency;
  final String? notes;
}

class OpenRequestsParams {
  const OpenRequestsParams({
    this.serviceId,
    this.latitude,
    this.longitude,
    this.radiusKm,
    this.limit = 50,
  });

  final String? serviceId;
  final double? latitude;
  final double? longitude;
  final double? radiusKm;
  final int limit;
}

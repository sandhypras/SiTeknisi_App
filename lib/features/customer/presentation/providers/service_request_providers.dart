import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/storage_service.dart';
import '../../data/service_request_repository.dart';

/// Provider for service request repository
final serviceRequestRepositoryProvider = Provider<ServiceRequestRepository?>((ref) {
  final client = Supabase.instance.client;
  if (client.auth.currentUser == null) {
    return null;
  }
  return ServiceRequestRepository(client);
});

/// Provider for storage service
final storageServiceProvider = Provider<StorageService?>((ref) {
  final client = Supabase.instance.client;
  if (client.auth.currentUser == null) {
    return null;
  }
  return StorageService(client);
});

/// Provider for loading state during request creation
final serviceRequestLoadingProvider = StateProvider<bool>((ref) => false);

/// Provider for error message
final serviceRequestErrorProvider = StateProvider<String?>((ref) => null);

/// Provider for customer's service requests
final customerServiceRequestsProvider = FutureProvider<List<ServiceRequest>>((ref) async {
  final repository = ref.watch(serviceRequestRepositoryProvider);
  if (repository == null) {
    return [];
  }
  return repository.getRequestsByCustomer();
});

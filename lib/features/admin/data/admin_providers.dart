import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'admin_users_repository.dart';
import 'admin_technicians_repository.dart';
import 'admin_services_repository.dart';
import 'admin_bookings_repository.dart';

final supabaseClientProvider = Provider<SupabaseClient?>((ref) {
  try {
    return Supabase.instance.client;
  } catch (e) {
    return null;
  }
});

final adminUsersRepositoryProvider = Provider<AdminUsersRepository?>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return client != null ? AdminUsersRepository(client) : null;
});

final adminTechniciansRepositoryProvider = Provider<AdminTechniciansRepository?>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return client != null ? AdminTechniciansRepository(client) : null;
});

final adminServicesRepositoryProvider = Provider<AdminServicesRepository?>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return client != null ? AdminServicesRepository(client) : null;
});

final adminBookingsRepositoryProvider = Provider<AdminBookingsRepository?>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return client != null ? AdminBookingsRepository(client) : null;
});

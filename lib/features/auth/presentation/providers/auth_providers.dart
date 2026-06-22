import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../../../core/config/supabase_config.dart';
import '../../data/auth_repository.dart';
import '../../domain/auth_user.dart';

/// Whether the real Supabase backend is wired up. When false the app stays in
/// its mock/prototype mode and auth screens keep their existing behavior.
final supabaseEnabledProvider = Provider<bool>(
  (ref) => SupabaseConfig.isConfigured,
);

final authRepositoryProvider = Provider<AuthRepository?>((ref) {
  if (!ref.watch(supabaseEnabledProvider)) return null;
  return AuthRepository(Supabase.instance.client);
});

/// Current signed-in user (with profile/role), or null when signed out.
///
/// Rebuilds whenever Supabase emits an auth state change, so the router guard
/// reacts to sign-in/sign-out automatically.
final authUserProvider = StreamProvider<AuthUser?>((ref) async* {
  final repository = ref.watch(authRepositoryProvider);
  if (repository == null) {
    yield null;
    return;
  }

  yield await repository.currentUser();

  await for (final _ in repository.authStateChanges) {
    yield await repository.currentUser();
  }
});

/// Synchronous role accessor for guards/UI. Null while loading or signed out.
final currentRoleProvider = Provider<UserRole?>((ref) {
  return ref.watch(authUserProvider).value?.role;
});

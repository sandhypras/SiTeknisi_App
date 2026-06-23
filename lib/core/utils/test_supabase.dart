import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/bootstrap.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/presentation/providers/auth_providers.dart';

/// Test script untuk verifikasi koneksi Supabase
Future<void> testSupabaseConnection(WidgetRef ref) async {
  if (kDebugMode) {
    print('\n=== TESTING SUPABASE CONNECTION ===');
    
    final repository = ref.read(authRepositoryProvider);
    if (repository == null) {
      print('❌ Repository is null - Supabase not configured');
      return;
    }
    
    print('✓ Repository initialized');
    
    try {
      final currentUser = await repository.currentUser();
      if (currentUser == null) {
        print('✓ Connection OK - No user logged in');
      } else {
        print('✓ Connection OK - User: ${currentUser.email}');
      }
    } catch (e) {
      print('❌ Connection failed: $e');
    }
    
    print('===================================\n');
  }
}

import 'package:flutter/foundation.dart';

import 'supabase_config.dart';

/// Logs Supabase configuration status in debug builds.
void checkSupabaseConfig() {
  if (!kDebugMode) return;

  final url = SupabaseConfig.url;
  final key = SupabaseConfig.publishableKey;
  final hasValidKeyPrefix = key.startsWith('eyJ');

  debugPrint('\n=== SUPABASE CONFIG CHECK ===');
  debugPrint('=' * 50);
  debugPrint('URL: ${url.isEmpty ? "EMPTY" : url}');
  debugPrint('Key: ${key.isEmpty ? "EMPTY" : "${key.substring(0, 30)}..."}');
  debugPrint('Key Length: ${key.length} chars');
  debugPrint('Configured: ${SupabaseConfig.isConfigured}');

  if (key.isNotEmpty) {
    debugPrint(
      'Key Format: ${hasValidKeyPrefix ? "Valid JWT prefix" : "Invalid, must start with eyJ"}',
    );
  }

  if (!SupabaseConfig.isConfigured) {
    debugPrint('');
    debugPrint('App running in mock mode because Supabase is not configured.');
    debugPrint('Run with --dart-define=SUPABASE_URL=...');
    debugPrint('Run with --dart-define=SUPABASE_PUBLISHABLE_KEY=...');
  } else {
    debugPrint('');
    debugPrint('Supabase integration active.');
  }

  debugPrint('${'=' * 50}\n');
}

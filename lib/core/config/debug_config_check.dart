import 'package:flutter/foundation.dart';
import 'supabase_config.dart';

/// Helper untuk debug konfigurasi Supabase
void checkSupabaseConfig() {
  if (kDebugMode) {
    print('\n' + '='*50);
    print('SUPABASE CONFIG CHECK');
    print('='*50);
    
    final url = SupabaseConfig.url;
    final key = SupabaseConfig.publishableKey;
    
    print('URL: ${url.isEmpty ? "❌ KOSONG" : "✓ $url"}');
    print('Key: ${key.isEmpty ? "❌ KOSONG" : "✓ ${key.substring(0, 30)}..."}');
    print('Key Length: ${key.length} chars ${key.length > 0 ? "✓" : "❌"}');
    print('Configured: ${SupabaseConfig.isConfigured ? "✓ TRUE" : "❌ FALSE"}');
    
    // Verify key format
    if (key.isNotEmpty) {
      if (key.startsWith('eyJ')) {
        print('Key Format: ✓ Valid JWT format');
      } else {
        print('Key Format: ❌ INVALID! Must start with eyJ');
      }
    }
    
    if (!SupabaseConfig.isConfigured) {
      print('');
      print('⚠️  APP RUNNING IN MOCK MODE (No Backend)');
      print('To use Supabase, run with:');
      print('  run_supabase_verified.bat  ← USE THIS!');
      print('  OR run_with_supabase.bat');
      print('  OR press F5 and select "Supabase Mode"');
    } else {
      print('');
      print('✓ Supabase Integration Active');
      print('✓ Ready for production mode');
    }
    print('='*50 + '\n');
  }
}

import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_config.dart';

/// Initializes app-level services before `runApp`.
///
/// Supabase is only initialized when [SupabaseConfig.isConfigured] is true, so
/// the app continues to run against its in-memory mock data when no
/// `--dart-define` credentials are supplied.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      publishableKey: SupabaseConfig.publishableKey,
    );
  }
}

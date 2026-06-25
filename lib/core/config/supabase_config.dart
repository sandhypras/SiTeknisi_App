/// Supabase environment configuration.
///
/// Values are injected at build/run time via `--dart-define`, never hardcoded:
///
/// ```
/// flutter run \
///   --dart-define=SUPABASE_URL=https://<ref>.supabase.co \
///   --dart-define=SUPABASE_PUBLISHABLE_KEY=<publishable-key>
/// ```
///
/// When the values are absent the app stays in its mock/prototype mode and no
/// Supabase client is initialized; see `bootstrap.dart`.
class SupabaseConfig {
  const SupabaseConfig._();

  static const String url = String.fromEnvironment('SUPABASE_URL');

  static const String publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  /// Whether both required values were provided at build time.
  static bool get isConfigured => url.isNotEmpty && publishableKey.isNotEmpty;
}

import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../domain/auth_user.dart';

/// Thrown for any auth failure so the UI can show an Indonesian message
/// without depending on Supabase types.
class AuthFailure implements Exception {
  const AuthFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Wraps Supabase Auth + the `profiles` table.
///
/// All methods assume Supabase has been initialized (see
/// lib/core/config/bootstrap.dart). The screens only call into this when
/// [SupabaseConfig.isConfigured] is true; otherwise they keep the mock flow.
class AuthRepository {
  AuthRepository(this._client);

  final SupabaseClient _client;

  Session? get currentSession => _client.auth.currentSession;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  /// Signs in with email/password and returns the resolved profile.
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw const AuthFailure('Email atau password tidak sesuai.');
      }
      return _loadProfile(user);
    } on AuthException catch (error) {
      throw AuthFailure(_mapAuthError(error));
    }
  }

  /// Registers a new account. Role and full name are sent as user metadata so
  /// the `handle_new_user` trigger seeds the matching `profiles` row.
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    String? phone,
  }) async {
    try {
      await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'full_name': fullName.trim(),
          'role': role.name,
          if (phone != null && phone.trim().isNotEmpty) 'phone': phone.trim(),
        },
      );
    } on AuthException catch (error) {
      throw AuthFailure(_mapAuthError(error));
    }
  }

  Future<void> signOut() => _client.auth.signOut();

  Future<void> sendPasswordReset(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email.trim());
    } on AuthException catch (error) {
      throw AuthFailure(_mapAuthError(error));
    }
  }

  /// Reads the `profiles` row for the current session, if any.
  Future<AuthUser?> currentUser() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return _loadProfile(user);
  }

  Future<AuthUser> _loadProfile(User user) async {
    final row = await _client
        .from('profiles')
        .select('full_name, phone, role, avatar_url')
        .eq('id', user.id)
        .maybeSingle();

    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      fullName: (row?['full_name'] as String?) ?? 'Pengguna',
      role: UserRole.fromName(row?['role'] as String?),
      phone: row?['phone'] as String?,
      avatarUrl: row?['avatar_url'] as String?,
    );
  }

  String _mapAuthError(AuthException error) {
    final message = error.message.toLowerCase();
    if (message.contains('invalid login')) {
      return 'Email atau password tidak sesuai.';
    }
    if (message.contains('already registered') ||
        message.contains('already exists')) {
      return 'Email sudah terdaftar. Silakan masuk.';
    }
    if (message.contains('password')) {
      return 'Password tidak memenuhi syarat. Minimal 6 karakter.';
    }
    return 'Terjadi kesalahan autentikasi. Coba lagi.';
  }
}

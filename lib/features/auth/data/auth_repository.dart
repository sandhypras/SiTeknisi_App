import 'package:flutter/foundation.dart';
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

/// Outcome of a sign-up attempt.
class SignUpResult {
  const SignUpResult({required this.needsEmailVerification});

  /// True when the project requires the user to confirm their email before a
  /// session is granted.
  final bool needsEmailVerification;
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
  ///
  /// Returns whether email verification is still required: when the project has
  /// "Confirm email" enabled, Supabase creates the user without an active
  /// session, so the caller must ask the user to check their inbox before
  /// signing in.
  Future<SignUpResult> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    String? phone,
  }) async {
    if (kDebugMode) {
      print('\n🔐 SIGNUP ATTEMPT:');
      print('  Email: $email');
      print('  Role: ${role.name}');
      print('  Name: $fullName');
    }
    
    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'full_name': fullName.trim(),
          'role': role.name,
          if (phone != null && phone.trim().isNotEmpty) 'phone': phone.trim(),
        },
      );
      
      if (kDebugMode) {
        print('✅ Signup response received');
        print('  Session: ${response.session != null ? "Active" : "Null (needs verification)"}');
      }
      
      // No session means the project requires email confirmation before login.
      return SignUpResult(needsEmailVerification: response.session == null);
    } on AuthException catch (error) {
      if (kDebugMode) {
        print('❌ AuthException during signup:');
        print('  Status: ${error.statusCode}');
        print('  Code: ${error.code}');
        print('  Message: ${error.message}');
      }
      throw AuthFailure(_mapAuthError(error));
    } catch (error) {
      if (kDebugMode) {
        print('❌ Unexpected error during signup: $error');
      }
      throw AuthFailure('Gagal mendaftar: $error');
    }
  }

  Future<void> signOut() => _client.auth.signOut();

  /// Re-sends the sign-up confirmation email.
  Future<void> resendVerification(String email) async {
    try {
      await _client.auth.resend(
        type: OtpType.signup,
        email: email.trim(),
      );
    } on AuthException catch (error) {
      throw AuthFailure(_mapAuthError(error));
    }
  }

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
    if (kDebugMode) {
      debugPrint(
        '\n🚨 AuthException Details:\n'
        '  Status Code: ${error.statusCode}\n'
        '  Error Code: ${error.code}\n'
        '  Message: "${error.message}"\n',
      );
    }
    final message = error.message.toLowerCase();
    
    // Check for invalid API key first
    if (message.contains('invalid api key') || 
        message.contains('invalid key') ||
        message.contains('jwt') && message.contains('invalid')) {
      return 'Kredensial Supabase tidak valid. Pastikan app dijalankan dengan:\n'
             '  • run_with_supabase.bat\n'
             '  • Atau F5 > "Supabase Mode"';
    }
    
    if (message.contains('invalid login')) {
      return 'Email atau password tidak sesuai.';
    }
    if (message.contains('email not confirmed') ||
        message.contains('not confirmed')) {
      return 'Email belum diverifikasi. Cek inbox Anda atau kirim ulang link verifikasi.';
    }
    if (message.contains('already registered') ||
        message.contains('already exists') ||
        message.contains('user already')) {
      return 'Email sudah terdaftar. Silakan masuk.';
    }
    if (message.contains('database error') ||
        message.contains('saving new user') ||
        message.contains('unexpected_failure')) {
      return 'Gagal menyimpan profil akun di server. Hubungi admin: trigger profil (handle_new_user) kemungkinan gagal.';
    }
    if (message.contains('signups not allowed') ||
        message.contains('signup is disabled')) {
      return 'Pendaftaran sedang dinonaktifkan di server.';
    }
    if (message.contains('invalid') && message.contains('email')) {
      return 'Format email tidak valid.';
    }
    if (message.contains('password')) {
      return 'Password tidak memenuhi syarat. Minimal 6 karakter.';
    }
    if (message.contains('rate limit') || message.contains('too many')) {
      return 'Terlalu banyak percobaan. Tunggu beberapa saat lalu coba lagi.';
    }
    // Sertakan pesan asli agar penyebab tak terduga tetap terlihat.
    return 'Terjadi kesalahan autentikasi: ${error.message}';
  }
}

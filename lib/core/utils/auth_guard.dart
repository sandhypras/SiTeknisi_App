import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/widgets/login_required_dialog.dart';

/// Gerbang autentikasi untuk aksi yang hanya boleh dijalankan pengguna login.
///
/// Dipakai oleh seluruh tombol yang membutuhkan login (Pesan Sekarang, Kirim
/// Request, Chat Teknisi, Bayar) agar logika pengecekan tidak diulang di setiap
/// layar.
extension AuthGuardX on WidgetRef {
  /// Menjalankan [onAuthenticated] bila pengguna sudah login. Jika belum
  /// (Guest), menampilkan dialog "Login Diperlukan" dengan [returnUrl] sebagai
  /// halaman yang dituju setelah login berhasil.
  Future<void> checkAuthBeforeAction(
    BuildContext context, {
    required VoidCallback onAuthenticated,
    String? returnUrl,
  }) async {
    final user = read(authUserProvider).value;
    if (user != null) {
      onAuthenticated();
      return;
    }
    await showLoginRequiredDialog(context, returnUrl: returnUrl);
  }
}

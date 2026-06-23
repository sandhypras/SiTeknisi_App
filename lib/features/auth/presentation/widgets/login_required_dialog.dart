import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

/// Dialog yang ditampilkan saat Guest mencoba aksi yang membutuhkan login.
///
/// [returnUrl] adalah halaman asal sehingga setelah login berhasil pengguna
/// dapat dikembalikan ke tempat ia menekan tombol.
Future<void> showLoginRequiredDialog(
  BuildContext context, {
  String? returnUrl,
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) {
      String loginPath = AppRoutes.login;
      if (returnUrl != null && returnUrl.isNotEmpty) {
        loginPath =
            '${AppRoutes.login}?returnUrl=${Uri.encodeComponent(returnUrl)}';
      }

      return AlertDialog(
        icon: const Icon(
          Icons.lock_outline_rounded,
          color: AppColors.primary,
          size: 32,
        ),
        title: const Text('Login Diperlukan'),
        content: const Text(
          'Anda harus login terlebih dahulu untuk menggunakan fitur ini.',
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.md,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Nanti'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              dialogContext.go(AppRoutes.register);
            },
            child: const Text('Daftar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              dialogContext.go(loginPath);
            },
            child: const Text('Login'),
          ),
        ],
      );
    },
  );
}

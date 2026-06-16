import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_mock_providers.dart';
import '../widgets/auth_scaffold.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authLoadingProvider);
    final isSent = ref.watch(forgotPasswordSentProvider);
    final textTheme = Theme.of(context).textTheme;

    return AuthScaffold(
      appBar: AppBar(),
      children: [
        if (isSent) ...[
          const SizedBox(height: AppSpacing.xl),
          Icon(
            Icons.mark_email_read_rounded,
            size: 96,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Link Reset Sudah Dikirim',
            textAlign: TextAlign.center,
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Silakan cek email Anda untuk melanjutkan proses reset password.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'Kembali ke Login',
            onPressed: () {
              ref.read(forgotPasswordSentProvider.notifier).setSent(false);
              context.go(AppRoutes.login);
            },
          ),
        ] else ...[
          Text(
            'Lupa Password',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Masukkan email akun Anda. Kami akan mengirim link reset password.',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const CustomTextField(
            label: 'Email',
            hintText: 'nama@email.com',
            prefixIcon: Icon(Icons.email_rounded),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'Kirim Link Reset',
            isLoading: isLoading,
            onPressed: () => _mockSubmit(ref),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: TextButton(
              onPressed: () => context.go(AppRoutes.login),
              child: const Text('Kembali ke Login'),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _mockSubmit(WidgetRef ref) async {
    ref.read(authLoadingProvider.notifier).setLoading(true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    ref.read(authLoadingProvider.notifier).setLoading(false);
    ref.read(forgotPasswordSentProvider.notifier).setSent(true);
  }
}

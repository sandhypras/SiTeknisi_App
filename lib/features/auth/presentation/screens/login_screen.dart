import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_mock_providers.dart';
import '../widgets/auth_illustrations.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_scaffold.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authLoadingProvider);
    final hasError = ref.watch(loginErrorProvider);
    final textTheme = Theme.of(context).textTheme;

    return AuthScaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      bottom: hasError
          ? ErrorToastCard(
              message: 'Login gagal, silakan coba lagi',
              onDismiss: () =>
                  ref.read(loginErrorProvider.notifier).setError(false),
            )
          : null,
      children: [
        const SizedBox(height: AppSpacing.xl),
        Container(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.extraLarge,
            border: Border.all(color: const Color(0xFFD8DCEF)),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: AuthLogo(size: 58, cardSize: 76, showText: false),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'SiTeknisi',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Authentication',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              CustomTextField(
                label: 'Email Address',
                hintText: 'user@example.com',
                prefixIcon: const Icon(Icons.mail_outline_rounded),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (_) {
                  if (hasError) {
                    ref.read(loginErrorProvider.notifier).setError(false);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.md),
              CustomTextField(
                label: 'Password',
                hintText: 'Masukkan password',
                errorText: hasError ? 'Email atau password tidak sesuai' : null,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  tooltip: _obscurePassword
                      ? 'Tampilkan password'
                      : 'Sembunyikan password',
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                ),
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onChanged: (_) {
                  if (hasError) {
                    ref.read(loginErrorProvider.notifier).setError(false);
                  }
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.forgotPassword),
                  child: const Text('Lupa Password?'),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              PrimaryButton(
                label: 'Masuk',
                icon: Icons.login_rounded,
                isLoading: isLoading,
                onPressed: () => _mockSubmit(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.register),
                    child: const Text('Daftar sekarang'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _mockSubmit(BuildContext context) async {
    ref.read(authLoadingProvider.notifier).setLoading(true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    ref.read(authLoadingProvider.notifier).setLoading(false);
    ref.read(loginErrorProvider.notifier).setError(true);

    if (context.mounted) {
      FocusScope.of(context).unfocus();
    }
  }
}

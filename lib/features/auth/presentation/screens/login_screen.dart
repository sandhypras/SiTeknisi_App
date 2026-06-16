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
        const SizedBox(height: AppSpacing.xs),
        const _LoginHeroBand(),
        const SizedBox(height: AppSpacing.md),
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
                color: AppColors.primary.withValues(alpha: 0.08),
                blurRadius: 34,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: AuthLogo(
                  size: 34,
                  cardSize: 78,
                  showText: false,
                  logoMode: AuthLogoMode.mark,
                ),
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
                'Masuk untuk lanjut servis elektronik Anda',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _TrustStrip(),
              const SizedBox(height: AppSpacing.lg),
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
                icon: Icons.arrow_forward_rounded,
                isLoading: isLoading,
                onPressed: () => _mockSubmit(context),
              ),
              const SizedBox(height: AppSpacing.md),
              const _SecurityNotice(),
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

class _LoginHeroBand extends StatelessWidget {
  const _LoginHeroBand();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;

        return Container(
          constraints: const BoxConstraints(minHeight: 172),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: AppRadius.extraLarge,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0F4FD9), AppColors.primary],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.22),
                blurRadius: 28,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _LoginPatternPainter()),
              ),
              Padding(
                padding: EdgeInsets.all(
                  isNarrow ? AppSpacing.md : AppSpacing.lg,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface.withValues(alpha: 0.16),
                              borderRadius: AppRadius.pill,
                              border: Border.all(
                                color: AppColors.surface.withValues(
                                  alpha: 0.24,
                                ),
                              ),
                            ),
                            child: Text(
                              'SiTeknisi Verified',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: AppColors.surface,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Servis elektronik jadi lebih pasti.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColors.surface,
                              fontWeight: FontWeight.w900,
                              height: 1.18,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Teknisi terverifikasi, penawaran transparan, invoice otomatis.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelSmall?.copyWith(
                              color: AppColors.surface.withValues(alpha: 0.86),
                              height: 1.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: isNarrow ? AppSpacing.sm : AppSpacing.md),
                    Container(
                      width: isNarrow ? 64 : 78,
                      height: isNarrow ? 76 : 92,
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.14),
                        borderRadius: AppRadius.large,
                        border: Border.all(
                          color: AppColors.surface.withValues(alpha: 0.22),
                        ),
                      ),
                      child: Icon(
                        Icons.handyman_rounded,
                        color: AppColors.surface,
                        size: isNarrow ? 34 : 42,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TrustStrip extends StatelessWidget {
  const _TrustStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _TrustMetric(
            icon: Icons.verified_user_rounded,
            value: 'Aman',
            label: 'Akun',
          ),
        ),
        SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _TrustMetric(
            icon: Icons.receipt_long_rounded,
            value: 'Invoice',
            label: 'Otomatis',
          ),
        ),
        SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _TrustMetric(
            icon: Icons.support_agent_rounded,
            value: 'Bantuan',
            label: 'Aktif',
          ),
        ),
      ],
    );
  }
}

class _TrustMetric extends StatelessWidget {
  const _TrustMetric({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.52),
        borderRadius: AppRadius.medium,
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityNotice extends StatelessWidget {
  const _SecurityNotice();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_rounded, size: 15, color: AppColors.successText),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(
            'Data akun dilindungi dan hanya digunakan untuk transaksi servis.',
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = AppColors.surface.withValues(alpha: 0.14);

    for (var i = -2; i < 8; i++) {
      final startX = i * 54.0;
      canvas.drawLine(
        Offset(startX, size.height + 10),
        Offset(startX + 118, -10),
        paint,
      );
    }

    final blockPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.surface.withValues(alpha: 0.1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width - 86, 18, 104, 44),
        const Radius.circular(14),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width - 124, size.height - 54, 96, 30),
        const Radius.circular(12),
      ),
      blockPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

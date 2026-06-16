import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

enum AuthIllustrationKind { technician, compare, payment }

class OnboardingVisual extends StatelessWidget {
  const OnboardingVisual({required this.kind, super.key});

  final AuthIllustrationKind kind;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 246,
      child: switch (kind) {
        AuthIllustrationKind.technician => const _TechnicianVisual(),
        AuthIllustrationKind.compare => const _CompareVisual(),
        AuthIllustrationKind.payment => const _PaymentVisual(),
      },
    );
  }
}

class SplashProgressRing extends StatelessWidget {
  const SplashProgressRing({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 32,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        strokeCap: StrokeCap.round,
        backgroundColor: AppColors.primary.withValues(alpha: 0.12),
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }
}

class ErrorToastCard extends StatelessWidget {
  const ErrorToastCard({
    required this.message,
    required this.onDismiss,
    super.key,
  });

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: AppRadius.medium,
        border: Border.all(color: AppColors.error.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withValues(alpha: 0.16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.error,
            size: 22,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.errorText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: onDismiss,
            icon: const Icon(Icons.close_rounded, size: 18),
            color: AppColors.errorText,
            tooltip: 'Tutup',
          ),
        ],
      ),
    );
  }
}

class _TechnicianVisual extends StatelessWidget {
  const _TechnicianVisual();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 264,
        height: 190,
        decoration: BoxDecoration(
          borderRadius: AppRadius.extraLarge,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF132235), Color(0xFF1D3348)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.18),
              blurRadius: 28,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 22,
              top: 28,
              child: _GlowBox(
                size: 70,
                color: AppColors.primary.withValues(alpha: 0.38),
              ),
            ),
            Positioned(
              left: 34,
              bottom: 30,
              child: Transform.rotate(
                angle: -0.12,
                child: Container(
                  width: 138,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F1B2A),
                    borderRadius: AppRadius.medium,
                    border: Border.all(color: const Color(0xFF36506A)),
                  ),
                  child: const Icon(
                    Icons.memory_rounded,
                    color: Color(0xFF76D7FF),
                    size: 56,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 84,
              top: 34,
              child: Container(
                width: 76,
                height: 104,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: AppRadius.large,
                ),
                child: const Icon(
                  Icons.engineering_rounded,
                  color: AppColors.primary,
                  size: 58,
                ),
              ),
            ),
            const Positioned(
              right: 36,
              bottom: 28,
              child: Icon(
                Icons.build_circle_rounded,
                color: AppColors.secondary,
                size: 38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompareVisual extends StatelessWidget {
  const _CompareVisual();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD9DDF1), width: 1.4),
          ),
        ),
        const _MiniOfferCard(
          alignment: Alignment(-0.78, -0.56),
          name: 'Budi T.',
          price: 'Rp 150k',
          rating: '4.8',
        ),
        const _MiniOfferCard(
          alignment: Alignment(0.78, 0.35),
          name: 'Andi K.',
          price: 'Rp 175k',
          rating: '4.9',
        ),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.28),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.compare_arrows_rounded,
            color: AppColors.surface,
            size: 32,
          ),
        ),
      ],
    );
  }
}

class _PaymentVisual extends StatelessWidget {
  const _PaymentVisual();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 16,
          left: 38,
          child: Transform.rotate(
            angle: -0.1,
            child: Container(
              width: 238,
              height: 116,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: AppRadius.large,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.26),
                    blurRadius: 24,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.account_balance_wallet_rounded,
                        color: AppColors.surface,
                        size: 20,
                      ),
                      Text(
                        'SiTeknisi Pay',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.surface,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '**** **** **** 9912',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.surface.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Saldo\nRp 1.250.000',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 18,
          bottom: 40,
          child: Container(
            width: 190,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.medium,
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Invoice #INV-992',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Lunas',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Divider(height: AppSpacing.md),
                const _InvoiceRow(label: 'Jasa Servis', value: 'Rp 150k'),
                const SizedBox(height: AppSpacing.xxs),
                const _InvoiceRow(label: 'Sparepart', value: 'Rp 300k'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniOfferCard extends StatelessWidget {
  const _MiniOfferCard({
    required this.alignment,
    required this.name,
    required this.price,
    required this.rating,
  });

  final Alignment alignment;
  final String name;
  final String price;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 122,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.medium,
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.surfaceMuted,
              child: Icon(
                Icons.person_rounded,
                size: 16,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      Text(
                        rating,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InvoiceRow extends StatelessWidget {
  const _InvoiceRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.labelMedium),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _GlowBox extends StatelessWidget {
  const _GlowBox({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.extraLarge,
      ),
    );
  }
}

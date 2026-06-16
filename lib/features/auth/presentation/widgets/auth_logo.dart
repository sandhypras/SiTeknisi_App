import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

enum AuthLogoMode { full, mark }

class AuthLogo extends StatelessWidget {
  const AuthLogo({
    super.key,
    this.size = 64,
    this.showText = true,
    this.cardSize,
    this.cardWidth,
    this.logoMode = AuthLogoMode.full,
  });

  final double size;
  final bool showText;
  final double? cardSize;
  final double? cardWidth;
  final AuthLogoMode logoMode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final resolvedCardSize = cardSize ?? size;
    final resolvedCardWidth = cardWidth ?? resolvedCardSize;
    final shortestSide = resolvedCardWidth < resolvedCardSize
        ? resolvedCardWidth
        : resolvedCardSize;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: resolvedCardWidth,
          height: resolvedCardSize,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(shortestSide * 0.18),
            border: Border.all(color: const Color(0xFFC9CEE3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: EdgeInsets.all(shortestSide * 0.14),
          clipBehavior: Clip.antiAlias,
          child: logoMode == AuthLogoMode.mark
              ? Icon(
                  Icons.handyman_rounded,
                  size: size,
                  color: AppColors.primary,
                )
              : Image.asset(
                  AppAssets.siteknisiLogoCropped,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
        ),
        if (showText) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            'SiTeknisi',
            style: textTheme.headlineLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ],
    );
  }
}

class AuthIllustration extends StatelessWidget {
  const AuthIllustration({
    required this.icon,
    super.key,
    this.accentColor = AppColors.primary,
  });

  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.extraLarge,
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 28,
            right: 44,
            child: _SoftCircle(size: 48, color: AppColors.secondaryLight),
          ),
          Positioned(
            bottom: 32,
            left: 36,
            child: _SoftCircle(size: 64, color: AppColors.primaryLight),
          ),
          Container(
            width: 132,
            height: 132,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: AppRadius.extraLarge,
            ),
            child: Icon(icon, size: 68, color: accentColor),
          ),
        ],
      ),
    );
  }
}

class _SoftCircle extends StatelessWidget {
  const _SoftCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

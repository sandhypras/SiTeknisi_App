import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

enum StatusChipType { info, success, warning, error, neutral }

class StatusChip extends StatelessWidget {
  const StatusChip({
    required this.label,
    super.key,
    this.type = StatusChipType.info,
    this.icon,
  });

  final String label;
  final StatusChipType type;
  final IconData? icon;

  const StatusChip.info({required this.label, super.key, this.icon})
    : type = StatusChipType.info;

  const StatusChip.success({required this.label, super.key, this.icon})
    : type = StatusChipType.success;

  const StatusChip.warning({required this.label, super.key, this.icon})
    : type = StatusChipType.warning;

  const StatusChip.error({required this.label, super.key, this.icon})
    : type = StatusChipType.error;

  const StatusChip.neutral({required this.label, super.key, this.icon})
    : type = StatusChipType.neutral;

  @override
  Widget build(BuildContext context) {
    final colors = _colorsForType(type);
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: AppRadius.pill,
        border: Border.all(color: colors.foreground.withValues(alpha: 0.12)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: colors.foreground),
              const SizedBox(width: AppSpacing.xxs),
            ],
            Text(
              label,
              style: textTheme.labelMedium?.copyWith(color: colors.foreground),
            ),
          ],
        ),
      ),
    );
  }

  _StatusChipColors _colorsForType(StatusChipType type) {
    return switch (type) {
      StatusChipType.info => const _StatusChipColors(
        background: AppColors.infoContainer,
        foreground: AppColors.infoText,
      ),
      StatusChipType.success => const _StatusChipColors(
        background: AppColors.successContainer,
        foreground: AppColors.successText,
      ),
      StatusChipType.warning => const _StatusChipColors(
        background: AppColors.warningContainer,
        foreground: AppColors.warningText,
      ),
      StatusChipType.error => const _StatusChipColors(
        background: AppColors.errorContainer,
        foreground: AppColors.errorText,
      ),
      StatusChipType.neutral => const _StatusChipColors(
        background: AppColors.surfaceMuted,
        foreground: AppColors.textSecondary,
      ),
    };
  }
}

class _StatusChipColors {
  const _StatusChipColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}

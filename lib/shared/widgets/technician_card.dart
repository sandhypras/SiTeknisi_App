import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import 'status_chip.dart';

class TechnicianCard extends StatelessWidget {
  const TechnicianCard({
    required this.name,
    required this.specialization,
    super.key,
    this.avatarUrl,
    this.rating,
    this.completedJobs,
    this.distanceText,
    this.isVerified = false,
    this.onTap,
    this.trailing,
  });

  final String name;
  final String specialization;
  final String? avatarUrl;
  final double? rating;
  final int? completedJobs;
  final String? distanceText;
  final bool isVerified;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shadowColor: AppColors.shadow,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        splashColor: AppColors.primaryLight.withValues(alpha: 0.46),
        highlightColor: AppColors.primaryLight.withValues(alpha: 0.22),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primaryLight,
                backgroundImage: avatarUrl == null
                    ? null
                    : NetworkImage(avatarUrl!),
                child: avatarUrl == null
                    ? Text(
                        name.characters.first.toUpperCase(),
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: AppSpacing.xs),
                          const StatusChip.success(
                            label: 'Terverifikasi',
                            icon: Icons.verified_rounded,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      specialization,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xxs,
                      children: [
                        if (rating != null)
                          _MetaItem(
                            icon: Icons.star_rounded,
                            label: rating!.toStringAsFixed(1),
                          ),
                        if (completedJobs != null)
                          _MetaItem(
                            icon: Icons.task_alt_rounded,
                            label: '$completedJobs pekerjaan',
                          ),
                        if (distanceText != null)
                          _MetaItem(
                            icon: Icons.place_rounded,
                            label: distanceText!,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}

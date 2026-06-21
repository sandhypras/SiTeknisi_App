import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import 'status_chip.dart';
import 'safe_image.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    required this.technicianName,
    required this.price,
    required this.message,
    super.key,
    this.avatarUrl,
    this.avatarAsset,
    this.rating,
    this.estimatedArrival,
    this.isVerified = false,
    this.statusLabel = 'Baru',
    this.statusType = StatusChipType.info,
    this.onTap,
    this.onSelect,
  });

  final String technicianName;
  final String price;
  final String message;
  final String? avatarUrl;
  final String? avatarAsset;
  final double? rating;
  final String? estimatedArrival;
  final bool isVerified;
  final String statusLabel;
  final StatusChipType statusType;
  final VoidCallback? onTap;
  final VoidCallback? onSelect;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: AppRadius.medium,
                    child: SizedBox.square(
                      dimension: 52,
                      child: SafeImage(
                        assetPath: avatarAsset,
                        imageUrl: avatarUrl,
                        fallbackIcon: Icons.person_rounded,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                technicianName,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleMedium,
                              ),
                            ),
                            if (isVerified) ...[
                              const SizedBox(width: AppSpacing.xxs),
                              const Icon(
                                Icons.verified_rounded,
                                size: 18,
                                color: AppColors.primary,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Row(
                          children: [
                            if (rating != null) ...[
                              const Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: AppColors.warning,
                              ),
                              const SizedBox(width: AppSpacing.xxs),
                              Text(
                                rating!.toStringAsFixed(1),
                                style: textTheme.labelMedium,
                              ),
                            ],
                            if (estimatedArrival != null) ...[
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                estimatedArrival!,
                                style: textTheme.labelMedium?.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  StatusChip(label: statusLabel, type: statusType),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(price, style: textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (onSelect != null) ...[
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onSelect,
                    child: const Text('Pilih Teknisi'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

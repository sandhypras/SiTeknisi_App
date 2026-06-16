import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    required this.title,
    required this.description,
    super.key,
    this.icon,
    this.imageUrl,
    this.onTap,
    this.trailing,
  });

  final String title;
  final String description;
  final IconData? icon;
  final String? imageUrl;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            children: [
              _ServiceVisual(icon: icon, imageUrl: imageUrl),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              trailing ?? const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceVisual extends StatelessWidget {
  const _ServiceVisual({this.icon, this.imageUrl});

  final IconData? icon;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.medium,
      child: ColoredBox(
        color: AppColors.primaryLight,
        child: SizedBox.square(
          dimension: 52,
          child: imageUrl == null
              ? Icon(
                  icon ?? Icons.home_repair_service_rounded,
                  color: AppColors.primary,
                )
              : Image.network(imageUrl!, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

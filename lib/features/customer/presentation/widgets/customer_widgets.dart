import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../data/customer_dummy_data.dart';

class CustomerHeader extends StatelessWidget {
  const CustomerHeader({
    required this.title,
    required this.subtitle,
    super.key,
    this.action,
  });

  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.16,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (action != null) ...[const SizedBox(width: AppSpacing.md), action!],
      ],
    );
  }
}

class ServiceCategoryTile extends StatelessWidget {
  const ServiceCategoryTile({
    required this.category,
    super.key,
    this.onTap,
    this.expanded = false,
  });

  final CustomerServiceCategory category;
  final VoidCallback? onTap;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.large,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: Container(
          width: expanded ? double.infinity : 136,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadius.large,
            border: Border.all(color: AppColors.border),
          ),
          child: expanded
              ? Row(
                  children: [
                    _CategoryImage(category: category),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: _CategoryText(category: category)),
                    const Icon(Icons.chevron_right_rounded),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryImage(category: category),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      '${category.serviceCount} layanan',
                      style: textTheme.labelMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CustomerServiceTile extends StatelessWidget {
  const CustomerServiceTile({
    required this.service,
    super.key,
    this.onTap,
    this.showCategory = false,
  });

  final CustomerService service;
  final VoidCallback? onTap;
  final bool showCategory;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: AppRadius.large,
                child: Image.asset(
                  service.imageAsset,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            service.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium,
                          ),
                        ),
                        const StatusChip.info(label: 'Populer'),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      service.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xxs,
                      children: [
                        _MetaPill(
                          icon: Icons.payments_rounded,
                          label: 'Mulai ${formatRupiah(service.basePrice)}',
                        ),
                        _MetaPill(
                          icon: Icons.schedule_rounded,
                          label: service.estimatedTime,
                        ),
                        _MetaPill(
                          icon: Icons.star_rounded,
                          label: service.rating.toStringAsFixed(1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveBookingCard extends StatelessWidget {
  const ActiveBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: AppRadius.extraLarge,
        gradient: const LinearGradient(
          colors: [Color(0xFF0F4FD9), AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StatusChip.success(
                  label: 'Dalam proses',
                  icon: Icons.task_alt_rounded,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Servis Laptop Keyboard',
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Teknisi sedang menyiapkan penawaran terbaik.',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.surface.withValues(alpha: 0.86),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.14),
              borderRadius: AppRadius.large,
            ),
            child: const Icon(
              Icons.build_circle_rounded,
              color: AppColors.surface,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryImage extends StatelessWidget {
  const _CategoryImage({required this.category});

  final CustomerServiceCategory category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.large,
      child: Image.asset(
        category.imageAsset,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CategoryText extends StatelessWidget {
  const _CategoryText({required this.category});

  final CustomerServiceCategory category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category.name, style: textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          category.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          '${category.serviceCount} layanan tersedia',
          style: textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppColors.textMuted),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}

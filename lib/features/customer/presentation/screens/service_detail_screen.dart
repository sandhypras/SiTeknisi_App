import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/technician_card.dart';
import '../../data/customer_dummy_data.dart';

class ServiceDetailScreen extends ConsumerWidget {
  const ServiceDetailScreen({required this.serviceId, super.key});

  final String serviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(customerServicesProvider);
    final technicians = ref.watch(featuredTechniciansProvider);
    final service = services.firstWhere(
      (item) => item.id == serviceId,
      orElse: () => services.first,
    );
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Detail Layanan')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: 'Request Service',
          icon: Icons.add_task_rounded,
          onPressed: () => context.go('/customer/request/${service.id}'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                borderRadius: AppRadius.extraLarge,
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F4FD9), AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.16),
                      borderRadius: AppRadius.large,
                    ),
                    child: Icon(
                      service.icon,
                      color: AppColors.surface,
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    service.title,
                    style: textTheme.headlineLarge?.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    service.description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.surface.withValues(alpha: 0.86),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      StatusChip.success(
                        label: service.rating.toStringAsFixed(1),
                        icon: Icons.star_rounded,
                      ),
                      StatusChip.info(
                        label: service.estimatedTime,
                        icon: Icons.schedule_rounded,
                      ),
                      StatusChip.neutral(
                        label: '${service.completedJobs} selesai',
                        icon: Icons.task_alt_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _PriceCard(service: service),
            const SizedBox(height: AppSpacing.lg),
            Text('Yang termasuk', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            for (final feature in service.features) ...[
              _FeatureRow(label: feature),
              const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.lg),
            Text('Teknisi rekomendasi', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            for (final technician in technicians.take(2)) ...[
              TechnicianCard(
                name: technician.name,
                specialization: technician.specialization,
                rating: technician.rating,
                completedJobs: technician.completedJobs,
                distanceText: technician.distance,
                isVerified: true,
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  const _PriceCard({required this.service});

  final CustomerService service;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimasi mulai dari',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    formatRupiah(service.basePrice),
                    style: textTheme.headlineLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.receipt_long_rounded,
              color: AppColors.primary,
              size: 34,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.successContainer,
            borderRadius: AppRadius.pill,
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 18,
            color: AppColors.successText,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(label)),
      ],
    );
  }
}

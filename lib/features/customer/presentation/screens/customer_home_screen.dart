import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/search_bar.dart' as shared;
import '../../../../shared/widgets/technician_card.dart';
import '../../data/customer_dummy_data.dart';
import '../widgets/customer_shell.dart';
import '../widgets/customer_widgets.dart';

class CustomerHomeScreen extends ConsumerWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(customerCategoriesProvider);
    final services = ref.watch(customerServicesProvider);
    final technicians = ref.watch(featuredTechniciansProvider);
    final textTheme = Theme.of(context).textTheme;

    return CustomerShell(
      currentIndex: 0,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            CustomerHeader(
              title: 'Halo, Sandhy',
              subtitle: 'Butuh servis elektronik hari ini?',
              action: IconButton.filledTonal(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded),
                tooltip: 'Notifikasi',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            GestureDetector(
              onTap: () => context.go(AppRoutes.customerSearch),
              child: const AbsorbPointer(
                child: shared.SearchBar(
                  hintText: 'Cari servis HP, laptop, TV...',
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const ActiveBookingCard(),
            const SizedBox(height: AppSpacing.xl),
            _SectionHeader(
              title: 'Kategori Servis',
              actionLabel: 'Lihat semua',
              onAction: () => context.go(AppRoutes.customerCategories),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 142,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ServiceCategoryTile(
                    category: category,
                    onTap: () => context.go(
                      '${AppRoutes.customerCategories}?category=${category.id}',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            _SectionHeader(
              title: 'Layanan Populer',
              actionLabel: 'Cari',
              onAction: () => context.go(AppRoutes.customerSearch),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final service in services.take(3)) ...[
              CustomerServiceTile(
                service: service,
                onTap: () => context.go('/customer/services/${service.id}'),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.md),
            _MarketplaceBanner(textTheme: textTheme),
            const SizedBox(height: AppSpacing.xl),
            _SectionHeader(title: 'Teknisi Terdekat'),
            const SizedBox(height: AppSpacing.md),
            for (final technician in technicians) ...[
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        if (actionLabel != null)
          TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}

class _MarketplaceBanner extends StatelessWidget {
  const _MarketplaceBanner({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: AppRadius.extraLarge,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bandingkan offer teknisi',
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.secondaryDark,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Pilih harga, rating, dan estimasi pengerjaan yang paling sesuai.',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          const Icon(
            Icons.compare_arrows_rounded,
            color: AppColors.secondaryDark,
            size: 38,
          ),
        ],
      ),
    );
  }
}

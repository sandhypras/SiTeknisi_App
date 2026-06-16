import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/customer_dummy_data.dart';
import '../widgets/customer_shell.dart';
import '../widgets/customer_widgets.dart';

class ServiceCategoriesScreen extends ConsumerWidget {
  const ServiceCategoriesScreen({super.key, this.selectedCategoryId});

  final String? selectedCategoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(customerCategoriesProvider);
    final services = ref.watch(customerServicesProvider);
    final activeCategoryId = selectedCategoryId ?? categories.first.id;
    final filteredServices = services
        .where((service) => service.categoryId == activeCategoryId)
        .toList();

    return CustomerShell(
      currentIndex: 1,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            CustomerHeader(
              title: 'Kategori Layanan',
              subtitle: 'Pilih jenis perangkat dan temukan layanan terbaik.',
              action: IconButton.filledTonal(
                onPressed: () => context.go(AppRoutes.customerSearch),
                icon: const Icon(Icons.search_rounded),
                tooltip: 'Cari layanan',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final category in categories) ...[
              ServiceCategoryTile(
                category: category,
                expanded: true,
                onTap: () => context.go(
                  '${AppRoutes.customerCategories}?category=${category.id}',
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Layanan tersedia',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Estimasi harga dapat berubah setelah teknisi mengirim offer.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final service in filteredServices) ...[
              CustomerServiceTile(
                service: service,
                onTap: () => context.go('/customer/services/${service.id}'),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ),
      ),
    );
  }
}

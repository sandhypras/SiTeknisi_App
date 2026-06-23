import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/search_bar.dart' as shared;
import '../../data/customer_dummy_data.dart';
import '../widgets/customer_shell.dart';
import '../widgets/customer_widgets.dart';

class SearchServiceScreen extends ConsumerStatefulWidget {
  const SearchServiceScreen({super.key});

  @override
  ConsumerState<SearchServiceScreen> createState() =>
      _SearchServiceScreenState();
}

class _SearchServiceScreenState extends ConsumerState<SearchServiceScreen> {
  final _controller = TextEditingController();
  String _query = '';
  String _categoryId = 'all';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(customerCategoriesProvider);
    final services = ref.watch(customerServicesProvider);
    final filteredServices = services.where((service) {
      final matchesCategory =
          _categoryId == 'all' || service.categoryId == _categoryId;
      final normalizedQuery = _query.toLowerCase();
      final matchesQuery =
          normalizedQuery.isEmpty ||
          service.title.toLowerCase().contains(normalizedQuery) ||
          service.description.toLowerCase().contains(normalizedQuery);

      return matchesCategory && matchesQuery;
    }).toList();

    return CustomerShell(
      currentIndex: 2,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            CustomerHeader(
              title: 'Cari Layanan',
              subtitle: 'Temukan servis sesuai masalah perangkat Anda.',
              action: IconButton(
                onPressed: () => context.go(AppRoutes.customerHome),
                icon: const Icon(Icons.close_rounded),
                tooltip: 'Tutup',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            shared.SearchBar(
              controller: _controller,
              autofocus: true,
              hintText: 'Contoh: printer, laptop, komputer',
              onChanged: (value) => setState(() => _query = value),
              onClear: () => setState(() => _query = ''),
            ),
            const SizedBox(height: AppSpacing.md),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'Semua',
                    selected: _categoryId == 'all',
                    onTap: () => setState(() => _categoryId = 'all'),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  for (final category in categories) ...[
                    _FilterChip(
                      label: category.name,
                      selected: _categoryId == category.id,
                      onTap: () => setState(() => _categoryId = category.id),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '${filteredServices.length} layanan ditemukan',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            if (filteredServices.isEmpty)
              const EmptyState(
                title: 'Layanan tidak ditemukan',
                message:
                    'Coba kata kunci lain atau pilih kategori yang berbeda.',
                icon: Icons.search_off_rounded,
              )
            else
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

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.primaryLight,
      labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: selected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: FontWeight.w800,
      ),
      side: BorderSide(color: selected ? AppColors.primary : AppColors.border),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/customer_dummy_data.dart';
import '../widgets/customer_shell.dart';

class CustomerHomeScreen extends ConsumerWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(customerCategoriesProvider);
    final textTheme = Theme.of(context).textTheme;

    return CustomerShell(
      currentIndex: 0,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const _BrandHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, Budi!',
                    style: textTheme.displayLarge?.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      height: 1.12,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Butuh bantuan apa hari ini?',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const _TrackingCard(),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Kategori Layanan',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            context.go(AppRoutes.customerCategories),
                        child: const Text('Lihat Semua'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final category in categories.take(4))
                        _HomeCategoryItem(
                          category: category,
                          onTap: () => context.go(
                            '${AppRoutes.customerCategories}?category=${category.id}',
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const _JoinTechnicianBanner(),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Riwayat Terakhir',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const _RecentHistoryCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFC9CEE3))),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            color: AppColors.surface,
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: Image.asset(AppAssets.siteknisiLogo, fit: BoxFit.contain),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'SiTeknisi',
              style: textTheme.headlineLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
                fontSize: 29,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Belum ada notifikasi baru.')),
                  );
                },
                icon: const Icon(Icons.notifications_none_rounded, size: 30),
                tooltip: 'Notifikasi',
              ),
              Positioned(
                right: 10,
                top: 7,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDC2626),
                    borderRadius: AppRadius.pill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrackingCard extends StatelessWidget {
  const _TrackingCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        borderRadius: AppRadius.large,
        border: Border.all(color: const Color(0xFFC5CADF), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: AppRadius.pill,
            ),
            child: const Icon(
              Icons.local_shipping_outlined,
              color: AppColors.surface,
              size: 30,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF64748B),
                        borderRadius: AppRadius.pill,
                      ),
                      child: Text(
                        'Berlangsung',
                        style: textTheme.labelLarge?.copyWith(
                          color: AppColors.surface,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '10:30 AM',
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Teknisi dalam perjalanan',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Servis AC - Bpk. Andi',
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                InkWell(
                  onTap: () => context.go(AppRoutes.customerTracking),
                  borderRadius: AppRadius.pill,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lacak Pesanan',
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.primaryDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeCategoryItem extends StatelessWidget {
  const _HomeCategoryItem({required this.category, required this.onTap});

  final CustomerServiceCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.large,
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.62),
                borderRadius: AppRadius.large,
              ),
              child: Icon(category.icon, color: AppColors.primary, size: 34),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JoinTechnicianBanner extends StatelessWidget {
  const _JoinTechnicianBanner();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 190,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFF0B55D9),
        borderRadius: AppRadius.large,
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -28,
            child: Icon(
              Icons.handyman_rounded,
              size: 138,
              color: AppColors.surface.withValues(alpha: 0.18),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ingin Jadi Teknisi?',
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.surface,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: 250,
                child: Text(
                  'Bergabunglah dengan kami dan dapatkan penghasilan tambahan.',
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
              ),
              const Spacer(),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primaryDark,
                  minimumSize: const Size(180, 48),
                ),
                onPressed: () => context.go(AppRoutes.technicianJoin),
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Daftar Sekarang'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentHistoryCard extends StatelessWidget {
  const _RecentHistoryCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(color: const Color(0xFFC5CADF), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.54),
              borderRadius: AppRadius.pill,
            ),
            child: const Icon(
              Icons.phone_android_rounded,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Servis HP',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'Selesai · 12 Okt 2023',
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textPrimary, width: 2),
              borderRadius: AppRadius.pill,
            ),
            child: const Icon(Icons.check_rounded, size: 22),
          ),
        ],
      ),
    );
  }
}

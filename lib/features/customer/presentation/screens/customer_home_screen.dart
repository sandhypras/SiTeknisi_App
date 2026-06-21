import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/safe_image.dart';
import '../../../../shared/widgets/slogan_banner.dart';
import '../../data/customer_dummy_data.dart';
import '../widgets/customer_shell.dart';

class CustomerHomeScreen extends ConsumerWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(customerCategoriesProvider);
    final technicians = ref.watch(featuredTechniciansProvider);
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
                  const SizedBox(height: AppSpacing.lg),
                  _HomeSearchBar(
                    onTap: () => context.go(AppRoutes.customerSearch),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const _SloganHero(),
                  const SizedBox(height: AppSpacing.xl),
                  const _JoinTechnicianBanner(),
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Teknisi Pilihan',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRoutes.customerOffers),
                        child: const Text('Lihat Penawaran'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    height: 190,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: technicians.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, index) => _FeaturedTechnicianCard(
                        technician: technicians[index],
                        onTap: () => context.go(AppRoutes.customerOffers),
                      ),
                    ),
                  ),
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

class _HomeSearchBar extends StatelessWidget {
  const _HomeSearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.large,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: AppRadius.large,
          ),
          child: const Row(
            children: [
              Icon(Icons.search_rounded, color: AppColors.primary),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Cari servis printer, komputer, laptop...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ),
              Icon(Icons.tune_rounded, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

class _SloganHero extends StatelessWidget {
  const _SloganHero();

  @override
  Widget build(BuildContext context) {
    return SloganBanner(
      imageAsset: AppAssets.customerServicePromo,
      title: 'Elektronik pulih, aktivitas kembali utuh.',
      subtitle: 'Teknisi tepercaya untuk perangkat yang menemani harimu.',
      buttonLabel: 'Temukan Teknisi',
      onPressed: () => context.go(AppRoutes.customerSearch),
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

class _JoinTechnicianBanner extends StatelessWidget {
  const _JoinTechnicianBanner();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: AppRadius.extraLarge,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.technicianJoin),
        child: Ink(
          height: 252,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.joinTechnicianBanner),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF082F5B).withValues(alpha: 0.98),
                  const Color(0xFF0B4F8A).withValues(alpha: 0.88),
                  Colors.transparent,
                ],
                stops: const [0, 0.54, 1],
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.62,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: AppRadius.pill,
                      ),
                      child: const Text(
                        'Mitra SiTeknisi',
                        style: TextStyle(
                          color: AppColors.surface,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Bergabung Jadi Teknisi',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    const Text(
                      'Ubah keahlian Anda menjadi peluang kerja.',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 38),
                        backgroundColor: AppColors.surface,
                        foregroundColor: AppColors.primaryDark,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                      ),
                      onPressed: () => context.push(AppRoutes.technicianJoin),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 17),
                      label: const Text('Daftar Sekarang'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
              clipBehavior: Clip.antiAlias,
              child: SafeImage(
                assetPath: category.imageAsset,
                width: 64,
                height: 64,
                fallbackIcon: Icons.home_repair_service_rounded,
              ),
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

class _FeaturedTechnicianCard extends StatelessWidget {
  const _FeaturedTechnicianCard({
    required this.technician,
    required this.onTap,
  });

  final FeaturedTechnician technician;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.large,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: AppRadius.large,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: AppRadius.medium,
                  child: SafeImage(
                    assetPath: technician.imageAsset,
                    width: double.infinity,
                    height: 82,
                    fallbackIcon: Icons.person_rounded,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  technician.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  technician.specialization,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Text(
                      technician.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.verified_rounded,
                      size: 17,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
                  'Servis Printer',
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_mock_providers.dart';
import '../widgets/auth_illustrations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(onboardingItemsProvider);
    final isLastPage = _currentIndex == items.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompactHeight = constraints.maxHeight < 720;

            return Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: const Text('Lewati'),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: items.length,
                      onPageChanged: (index) {
                        setState(() => _currentIndex = index);
                      },
                      itemBuilder: (context, index) {
                        return _OnboardingPage(item: items[index]);
                      },
                    ),
                  ),
                  _PageDots(count: items.length, currentIndex: _currentIndex),
                  SizedBox(
                    height: isCompactHeight ? AppSpacing.md : AppSpacing.xl,
                  ),
                  PrimaryButton(
                    label: isLastPage ? 'Mulai Sekarang' : 'Lanjut',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () {
                      if (isLastPage) {
                        context.go(AppRoutes.login);
                        return;
                      }

                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
                  SizedBox(
                    height: isCompactHeight ? AppSpacing.xs : AppSpacing.md,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.item});

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final kind = switch (item.icon) {
      'compare' => AuthIllustrationKind.compare,
      'invoice' => AuthIllustrationKind.payment,
      _ => AuthIllustrationKind.technician,
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompactHeight = constraints.maxHeight < 510;
        final visualScale = isCompactHeight ? 0.82 : 1.0;
        final sectionGap = isCompactHeight ? AppSpacing.lg : AppSpacing.xxl;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 246 * visualScale,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: OnboardingVisual(kind: kind),
                    ),
                  ),
                  SizedBox(height: sectionGap),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      height: 1.16,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.55,
                    ),
                  ),
                  if (item.icon == 'compare') ...[
                    const SizedBox(height: AppSpacing.md),
                    const Wrap(
                      alignment: WrapAlignment.center,
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        _FeaturePill(
                          icon: Icons.price_check_rounded,
                          label: 'Harga Jelas',
                        ),
                        _FeaturePill(
                          icon: Icons.star_rounded,
                          label: 'Rating Terlihat',
                        ),
                        _FeaturePill(
                          icon: Icons.touch_app_rounded,
                          label: 'Pilih Sendiri',
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.currentIndex});

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < count; index++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            width: currentIndex == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppColors.primary
                  : AppColors.border,
              borderRadius: AppRadius.pill,
            ),
          ),
      ],
    );
  }
}

class _FeaturePill extends StatelessWidget {
  const _FeaturePill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.pill,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

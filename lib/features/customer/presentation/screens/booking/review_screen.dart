import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../shared/widgets/primary_button.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Review Layanan')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: 'Kirim Review',
          icon: Icons.send_rounded,
          onPressed: () => context.go(AppRoutes.customerHome),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.extraLarge,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: AppColors.primaryLight,
                  child: Icon(Icons.engineering_rounded, size: 38),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Andi Kurniawan', style: textTheme.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Servis AC selesai',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.warning,
                      size: 36,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.warning,
                      size: 36,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.warning,
                      size: 36,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.warning,
                      size: 36,
                    ),
                    Icon(
                      Icons.star_half_rounded,
                      color: AppColors.warning,
                      size: 36,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const CustomTextField(
            label: 'Tulis Review',
            hintText: 'Bagikan pengalaman Anda',
            maxLines: 5,
            prefixIcon: Icon(Icons.rate_review_outlined),
          ),
        ],
      ),
    );
  }
}

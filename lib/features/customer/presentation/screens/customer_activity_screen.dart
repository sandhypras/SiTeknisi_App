import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../widgets/customer_shell.dart';
import '../widgets/customer_widgets.dart';

class CustomerActivityScreen extends StatelessWidget {
  const CustomerActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomerShell(
      currentIndex: 1,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            const CustomerHeader(
              title: 'Aktivitas',
              subtitle: 'Pantau pesanan, offer, dan riwayat servis Anda.',
            ),
            const SizedBox(height: AppSpacing.lg),
            const _OngoingActivityCard(),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Riwayat Pesanan',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            const _HistoryTile(
              icon: Icons.phone_android_rounded,
              title: 'Servis HP',
              subtitle: 'Selesai - 12 Okt 2023',
              chip: StatusChip.success(label: 'Selesai'),
            ),
            const SizedBox(height: AppSpacing.sm),
            const _HistoryTile(
              icon: Icons.local_laundry_service_rounded,
              title: 'Servis Mesin Cuci',
              subtitle: 'Invoice INV-0921',
              chip: StatusChip.info(label: 'Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}

class _OngoingActivityCard extends StatelessWidget {
  const _OngoingActivityCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.45),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
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
                    const StatusChip.neutral(label: 'Berlangsung'),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Teknisi dalam perjalanan',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Servis AC - Bpk. Andi',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Mock tracking: teknisi 10 menit lagi.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.map_rounded),
                  label: const Text('Lacak'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutes.customerMessages),
                  icon: const Icon(Icons.chat_rounded),
                  label: const Text('Chat'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.chip,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget chip;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight.withValues(alpha: 0.54),
          child: Icon(icon, color: AppColors.textPrimary),
        ),
        title: Text(title, style: textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing: chip,
      ),
    );
  }
}

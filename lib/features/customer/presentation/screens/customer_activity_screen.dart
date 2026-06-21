import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/utils/whatsapp_launcher.dart';
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
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: AppSpacing.md),
            const _HistoryTile(
              imageAsset: AppAssets.printer,
              title: 'Servis Printer',
              subtitle: 'Selesai · 12 Okt 2023',
              chip: StatusChip.success(label: 'Selesai'),
            ),
            const SizedBox(height: AppSpacing.sm),
            const _HistoryTile(
              imageAsset: AppAssets.computer,
              title: 'Servis Komputer',
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
        color: const Color(0xFFF0F3FF),
        borderRadius: AppRadius.large,
        border: Border.all(color: const Color(0xFFC5CADF), width: 1.2),
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
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Servis Laptop - Bpk. Andi',
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
                  onPressed: () => openWhatsApp(
                    context,
                    phoneNumber: '6281234567890',
                    message:
                        'Halo Pak Andi, saya Budi dari booking SiTeknisi. Saya ingin menanyakan progres servis laptop saya.',
                  ),
                  icon: const Icon(Icons.chat_rounded),
                  label: const Text('WhatsApp'),
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
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.chip,
  });

  final String imageAsset;
  final String title;
  final String subtitle;
  final Widget chip;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: AppRadius.medium,
          child: Image.asset(
            imageAsset,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title, style: textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing: chip,
      ),
    );
  }
}

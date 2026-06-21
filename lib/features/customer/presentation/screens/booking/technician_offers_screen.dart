import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../../shared/widgets/status_chip.dart';
import '../../../../../shared/utils/whatsapp_launcher.dart';

class TechnicianOffersScreen extends StatelessWidget {
  const TechnicianOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penawaran Teknisi'),
        actions: [
          IconButton(
            tooltip: 'Bandingkan offer',
            onPressed: () => context.push(AppRoutes.customerOfferComparison),
            icon: const Icon(Icons.compare_arrows_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          const MobileFlowStepper(
            steps: ['Detail', 'Penawaran', 'Bayar', 'Lacak'],
            currentStep: 1,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '3 teknisi mengirim penawaran',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Bandingkan harga, rating, dan waktu kedatangan sebelum memilih.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _RequestSummary(),
          const SizedBox(height: AppSpacing.lg),
          const _OfferCard(
            name: 'Andi Kurniawan',
            rating: '4.9',
            price: 'Rp 175.000',
            eta: 'Datang 30 menit',
            imageAsset: AppAssets.technicianAndi,
            phoneNumber: '6281234567890',
            recommended: true,
          ),
          const SizedBox(height: AppSpacing.md),
          const _OfferCard(
            name: 'Budi Santoso',
            rating: '4.8',
            price: 'Rp 150.000',
            eta: 'Datang 1 jam',
            imageAsset: AppAssets.technicianBudi,
            phoneNumber: '6281234567891',
          ),
          const SizedBox(height: AppSpacing.md),
          const _OfferCard(
            name: 'Rina Wijaya',
            rating: '4.9',
            price: 'Rp 190.000',
            eta: 'Datang 45 menit',
            imageAsset: AppAssets.technicianRina,
            phoneNumber: '6281234567892',
          ),
        ],
      ),
    );
  }
}

class _RequestSummary extends StatelessWidget {
  const _RequestSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.55),
        borderRadius: AppRadius.large,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppRadius.medium,
            child: Image.asset(
              AppAssets.laptop,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Servis Laptop Tidak Menyala',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: AppSpacing.xxs),
                Text(
                  'Dago, Bandung • Hari ini',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.name,
    required this.rating,
    required this.price,
    required this.eta,
    required this.imageAsset,
    required this.phoneNumber,
    this.recommended = false,
  });

  final String name;
  final String rating;
  final String price;
  final String eta;
  final String imageAsset;
  final String phoneNumber;
  final bool recommended;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.large,
                  child: Image.asset(
                    imageAsset,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'Teknisi Laptop Terverifikasi',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (recommended) const StatusChip.success(label: 'Terbaik'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                _OfferMeta(icon: Icons.star_rounded, label: rating),
                const SizedBox(width: AppSpacing.md),
                _OfferMeta(icon: Icons.schedule_rounded, label: eta),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.5),
                borderRadius: AppRadius.medium,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      price,
                      style: textTheme.headlineLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  PrimaryButton(
                    label: 'Pilih',
                    fullWidth: false,
                    onPressed: () => context.go(AppRoutes.customerOfferDetail),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => openWhatsApp(
                  context,
                  phoneNumber: phoneNumber,
                  message:
                      'Halo $name, saya tertarik dengan penawaran servis laptop sebesar $price di SiTeknisi.',
                ),
                icon: const Icon(Icons.chat_rounded),
                label: const Text('Hubungi via WhatsApp'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferMeta extends StatelessWidget {
  const _OfferMeta({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.textMuted),
        const SizedBox(width: AppSpacing.xxs),
        Text(label),
      ],
    );
  }
}

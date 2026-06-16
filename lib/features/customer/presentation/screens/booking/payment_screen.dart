import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/primary_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: 'Bayar Sekarang',
          icon: Icons.payment_rounded,
          onPressed: () => context.go(AppRoutes.customerInvoice),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.large,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ringkasan Booking', style: textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),
                const _RowItem(label: 'Layanan', value: 'Servis AC'),
                const _RowItem(label: 'Teknisi', value: 'Andi Kurniawan'),
                const _RowItem(label: 'Jadwal', value: 'Hari ini, 14:00'),
                const Divider(height: AppSpacing.xl),
                const _RowItem(label: 'Jasa servis', value: 'Rp 175.000'),
                const _RowItem(label: 'Biaya platform', value: 'Rp 17.500'),
                const _RowItem(label: 'Total', value: 'Rp 192.500', bold: true),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Metode Pembayaran', style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          const _PaymentMethod(
            icon: Icons.qr_code_rounded,
            title: 'QRIS',
            subtitle: 'Simulasi Midtrans Sandbox',
            selected: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          const _PaymentMethod(
            icon: Icons.account_balance_rounded,
            title: 'Virtual Account',
            subtitle: 'BCA, BNI, Mandiri, Permata',
          ),
          const SizedBox(height: AppSpacing.sm),
          const _PaymentMethod(
            icon: Icons.wallet_rounded,
            title: 'E-Wallet',
            subtitle: 'GoPay, ShopeePay, DANA',
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.w900 : FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: style),
        ],
      ),
    );
  }
}

class _PaymentMethod extends StatelessWidget {
  const _PaymentMethod({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primaryLight.withValues(alpha: 0.5)
            : AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(title), Text(subtitle)],
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle_rounded, color: AppColors.primary),
        ],
      ),
    );
  }
}

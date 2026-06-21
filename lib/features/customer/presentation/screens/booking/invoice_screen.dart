import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/primary_button.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Invoice')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Download invoice dummy.')),
                  );
                },
                icon: const Icon(Icons.download_rounded),
                label: const Text('Download'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: PrimaryButton(
                label: 'Review',
                onPressed: () => context.go(AppRoutes.customerReview),
              ),
            ),
          ],
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
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 72,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Pembayaran Berhasil',
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'INV/SITEKNISI/20260617/0001',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Divider(height: AppSpacing.xl),
                const _InvoiceRow(label: 'Customer', value: 'Budi Santoso'),
                const _InvoiceRow(label: 'Teknisi', value: 'Andi Kurniawan'),
                const _InvoiceRow(label: 'Layanan', value: 'Servis Laptop'),
                const _InvoiceRow(label: 'Metode', value: 'QRIS Midtrans'),
                const _InvoiceRow(label: 'Status', value: 'Paid'),
                const Divider(height: AppSpacing.xl),
                const _InvoiceRow(
                  label: 'Total',
                  value: 'Rp 192.500',
                  bold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceRow extends StatelessWidget {
  const _InvoiceRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

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

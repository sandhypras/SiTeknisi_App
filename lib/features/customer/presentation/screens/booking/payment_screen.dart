import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/utils/auth_guard.dart';
import '../../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../../shared/widgets/primary_button.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: const Border(top: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total pembayaran',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Rp 192.500',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                label: 'Bayar',
                icon: Icons.arrow_forward_rounded,
                fullWidth: false,
                onPressed: () => ref.checkAuthBeforeAction(
                  context,
                  returnUrl: AppRoutes.customerPayment,
                  onAuthenticated: () =>
                      context.go(AppRoutes.customerPaymentSuccess),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          const MobileFlowStepper(
            steps: ['Detail', 'Penawaran', 'Bayar', 'Lacak'],
            currentStep: 2,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Selesaikan pembayaran',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Transaksi diproses dengan aman melalui Midtrans.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: AppRadius.large,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ringkasan Booking', style: textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),
                const _RowItem(label: 'Layanan', value: 'Servis Laptop'),
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
          Text('Pilih Metode Pembayaran', style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          _PaymentMethod(
            icon: Icons.qr_code_rounded,
            title: 'QRIS',
            subtitle: 'Simulasi Midtrans Sandbox',
            selected: _selectedMethod == 0,
            onTap: () => setState(() => _selectedMethod = 0),
          ),
          const SizedBox(height: AppSpacing.sm),
          _PaymentMethod(
            icon: Icons.account_balance_rounded,
            title: 'Virtual Account',
            subtitle: 'BCA, BNI, Mandiri, Permata',
            selected: _selectedMethod == 1,
            onTap: () => setState(() => _selectedMethod = 1),
          ),
          const SizedBox(height: AppSpacing.sm),
          _PaymentMethod(
            icon: Icons.wallet_rounded,
            title: 'E-Wallet',
            subtitle: 'GoPay, ShopeePay, DANA',
            selected: _selectedMethod == 2,
            onTap: () => setState(() => _selectedMethod = 2),
          ),
          const SizedBox(height: AppSpacing.md),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                color: AppColors.successText,
                size: 18,
              ),
              SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Data pembayaran dienkripsi dan tidak disimpan di aplikasi.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
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

class _RowItem extends StatelessWidget {
  const _RowItem({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.w900 : FontWeight.w500,
      color: bold ? AppColors.primary : null,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
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
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryLight.withValues(alpha: 0.5)
                : Theme.of(context).colorScheme.surface,
            borderRadius: AppRadius.large,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.primaryLight,
                  borderRadius: AppRadius.medium,
                ),
                child: Icon(
                  icon,
                  color: selected ? Colors.white : AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: selected ? AppColors.primary : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

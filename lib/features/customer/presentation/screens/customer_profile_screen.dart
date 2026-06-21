import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/customer_shell.dart';
import '../widgets/customer_widgets.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomerShell(
      currentIndex: 3,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            const CustomerHeader(
              title: 'Profil',
              subtitle: 'Kelola akun, alamat, dan aktivitas servis Anda.',
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.extraLarge,
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: AppColors.primaryLight,
                    child: Text('S'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sandhy Prasetyo', style: textTheme.titleLarge),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'sandhy@example.com',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '+62 812 3456 7890',
                          style: textTheme.labelMedium?.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showEditProfileDialog(context),
                    icon: const Icon(Icons.edit_rounded),
                    tooltip: 'Edit profil',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: const [
                Expanded(
                  child: _StatCard(
                    value: '8',
                    label: 'Booking',
                    icon: Icons.assignment_turned_in_rounded,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _StatCard(
                    value: '4.9',
                    label: 'Rating',
                    icon: Icons.star_rounded,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _StatCard(
                    value: '3',
                    label: 'Invoice',
                    icon: Icons.receipt_long_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Akun & Layanan', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            _ProfileMenuTile(
              icon: Icons.location_on_outlined,
              title: 'Alamat Tersimpan',
              subtitle: 'Rumah, kantor, dan lokasi servis',
              onTap: () => context.push(AppRoutes.customerLocation),
            ),
            _ProfileMenuTile(
              icon: Icons.payment_rounded,
              title: 'Metode Pembayaran',
              subtitle: 'Midtrans, transfer, dan riwayat pembayaran',
              onTap: () => _showPaymentMethods(context),
            ),
            _ProfileMenuTile(
              icon: Icons.history_rounded,
              title: 'Riwayat Booking',
              subtitle: 'Lihat status servis dan invoice',
              onTap: () => context.push(AppRoutes.customerBookingHistory),
            ),
            _ProfileMenuTile(
              icon: Icons.receipt_long_outlined,
              title: 'Riwayat Invoice',
              subtitle: 'Invoice otomatis dari transaksi selesai',
              onTap: () => context.push(AppRoutes.customerInvoiceHistory),
            ),
            _ProfileMenuTile(
              icon: Icons.support_agent_rounded,
              title: 'Bantuan',
              subtitle: 'FAQ dan pusat bantuan SiTeknisi',
              onTap: () => _showHelpCenter(context),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton.icon(
              onPressed: () => context.go(AppRoutes.login),
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profil'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Nama lengkap')),
            SizedBox(height: AppSpacing.sm),
            TextField(
              decoration: InputDecoration(labelText: 'Nomor WhatsApp'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil berhasil diperbarui.')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethods(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Metode Pembayaran',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: AppSpacing.md),
              ListTile(
                leading: Icon(Icons.qr_code_rounded),
                title: Text('QRIS'),
                subtitle: Text('Pembayaran instan melalui Midtrans'),
              ),
              ListTile(
                leading: Icon(Icons.account_balance_rounded),
                title: Text('Virtual Account'),
                subtitle: Text('BCA, BNI, BRI, dan Mandiri'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpCenter(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pusat Bantuan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              const ListTile(
                leading: Icon(Icons.help_outline_rounded),
                title: Text('Cara membuat permintaan servis'),
              ),
              const ListTile(
                leading: Icon(Icons.shield_outlined),
                title: Text('Keamanan pembayaran dan garansi'),
              ),
              const ListTile(
                leading: Icon(Icons.support_agent_rounded),
                title: Text('Hubungi dukungan SiTeknisi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.56),
        borderRadius: AppRadius.large,
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: AppRadius.medium,
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

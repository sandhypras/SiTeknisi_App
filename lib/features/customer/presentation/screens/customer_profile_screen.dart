import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../auth/data/auth_repository.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../widgets/customer_shell.dart';

class CustomerProfileScreen extends ConsumerStatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  ConsumerState<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends ConsumerState<CustomerProfileScreen> {
  String _name = 'Sandhy Prasetyo';
  String _phone = '+62 812 3456 7890';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomerShell(
      currentIndex: 3,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenPadding,
            AppSpacing.md,
            AppSpacing.screenPadding,
            AppSpacing.xl,
          ),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Profil Saya',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  tooltip: 'Pengaturan',
                  onPressed: () => _showSettings(context),
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _ProfileHero(
              name: _name,
              phone: _phone,
              onEdit: () => _showEditProfileDialog(context),
            ),
            const SizedBox(height: AppSpacing.md),
            const _ProfileSummary(),
            const SizedBox(height: AppSpacing.xl),
            _SectionHeading(
              title: 'Aktivitas Servis',
              caption: 'Pantau transaksi dan dokumen Anda',
            ),
            const SizedBox(height: AppSpacing.sm),
            _ProfileMenuGroup(
              items: [
                _ProfileMenuItem(
                  icon: Icons.history_rounded,
                  title: 'Riwayat Booking',
                  subtitle: 'Status servis yang sedang berjalan',
                  badge: '2 aktif',
                  onTap: () => context.push(AppRoutes.customerBookingHistory),
                ),
                _ProfileMenuItem(
                  icon: Icons.receipt_long_outlined,
                  title: 'Riwayat Invoice',
                  subtitle: 'Unduh bukti pembayaran servis',
                  onTap: () => context.push(AppRoutes.customerInvoiceHistory),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            _SectionHeading(
              title: 'Akun & Preferensi',
              caption: 'Atur data dan kenyamanan penggunaan',
            ),
            const SizedBox(height: AppSpacing.sm),
            _ProfileMenuGroup(
              items: [
                _ProfileMenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'Alamat Tersimpan',
                  subtitle: 'Rumah, kantor, dan lokasi servis',
                  onTap: () => context.push(AppRoutes.customerLocation),
                ),
                _ProfileMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Metode Pembayaran',
                  subtitle: 'QRIS dan Virtual Account Midtrans',
                  onTap: () => _showPaymentMethods(context),
                ),
                _ProfileMenuItem(
                  icon: Icons.support_agent_rounded,
                  title: 'Pusat Bantuan',
                  subtitle: 'FAQ dan dukungan SiTeknisi',
                  onTap: () => _showHelpCenter(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            _TechnicianInvite(
              onTap: () => context.push(AppRoutes.technicianJoin),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.errorText,
                side: const BorderSide(color: AppColors.errorContainer),
              ),
              onPressed: () => _confirmLogout(context),
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Keluar dari akun'),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Center(
              child: Text(
                'SiTeknisi v1.0.0',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    final nameController = TextEditingController(text: _name);
    final phoneController = TextEditingController(text: _phone);
    final formKey = GlobalKey<FormState>();
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profil'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama lengkap',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Nama lengkap wajib diisi'
                    : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor WhatsApp',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Nomor WhatsApp wajib diisi'
                    : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (saved == true && mounted) {
      setState(() {
        _name = nameController.text.trim();
        _phone = phoneController.text.trim();
      });
      ScaffoldMessenger.of(this.context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui.')),
      );
    }
    nameController.dispose();
    phoneController.dispose();
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
              SizedBox(height: AppSpacing.xs),
              Text(
                'Pilih metode saat menyelesaikan pembayaran booking.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSpacing.md),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: _SheetIcon(icon: Icons.qr_code_rounded),
                title: Text('QRIS'),
                subtitle: Text('Pembayaran instan melalui Midtrans'),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: _SheetIcon(icon: Icons.account_balance_rounded),
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
                contentPadding: EdgeInsets.zero,
                leading: _SheetIcon(icon: Icons.build_circle_outlined),
                title: Text('Cara membuat permintaan servis'),
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: _SheetIcon(icon: Icons.shield_outlined),
                title: Text('Keamanan pembayaran dan garansi'),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _SheetIcon(icon: Icons.support_agent_rounded),
                title: const Text('Hubungi dukungan SiTeknisi'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tim dukungan akan segera tersedia.'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettings(BuildContext context) {
    var notificationsEnabled = true;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
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
                  'Pengaturan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: notificationsEnabled,
                  onChanged: (value) =>
                      setSheetState(() => notificationsEnabled = value),
                  secondary: const Icon(Icons.notifications_outlined),
                  title: const Text('Notifikasi servis'),
                  subtitle: const Text('Status booking dan penawaran teknisi'),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.language_rounded),
                  title: Text('Bahasa'),
                  trailing: Text('Indonesia'),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.lock_outline_rounded),
                  title: Text('Privasi & keamanan'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.logout_rounded, color: AppColors.errorText),
        title: const Text('Keluar dari akun?'),
        content: const Text(
          'Anda perlu masuk kembali untuk melihat booking dan invoice.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    
    if (shouldLogout == true && context.mounted) {
      // Show loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 12),
              Text('Keluar dari akun...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      // Perform logout
      final repository = ref.read(authRepositoryProvider);
      
      if (repository != null) {
        // Real Supabase logout
        try {
          await repository.signOut();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Berhasil keluar dari akun'),
                backgroundColor: AppColors.success,
              ),
            );
            context.go(AppRoutes.splash);
          }
        } on AuthFailure catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal logout: ${e.message}'),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      } else {
        // Mock mode - just redirect
        await Future.delayed(const Duration(milliseconds: 500));
        if (context.mounted) {
          context.go(AppRoutes.splash);
        }
      }
    }
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({
    required this.name,
    required this.phone,
    required this.onEdit,
  });

  final String name;
  final String phone;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final initial = name.trim().isEmpty ? 'S' : name.trim()[0].toUpperCase();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppRadius.extraLarge,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: AppColors.surface,
                    child: Text(
                      initial,
                      style: textTheme.headlineMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: -2,
                    bottom: -2,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: AppColors.surface,
                      child: Icon(
                        Icons.verified_rounded,
                        size: 18,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      'sandhy@example.com',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                    Text(
                      phone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Edit profil',
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.14),
                  foregroundColor: AppColors.surface,
                ),
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.13),
              borderRadius: AppRadius.medium,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shield_outlined,
                  color: AppColors.secondaryLight,
                  size: 17,
                ),
                SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: Text(
                    'Akun terverifikasi · Bergabung Mei 2026',
                    style: TextStyle(
                      color: AppColors.surface,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.large,
      ),
      child: const Row(
        children: [
          Expanded(
            child: _SummaryItem(
              value: '8',
              label: 'Booking',
              icon: Icons.assignment_turned_in_outlined,
            ),
          ),
          _SummaryDivider(),
          Expanded(
            child: _SummaryItem(
              value: '4.9',
              label: 'Rating',
              icon: Icons.star_outline_rounded,
            ),
          ),
          _SummaryDivider(),
          Expanded(
            child: _SummaryItem(
              value: '3',
              label: 'Invoice',
              icon: Icons.receipt_long_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  const _SummaryDivider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 44,
      child: VerticalDivider(color: AppColors.border),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.caption});

  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          caption,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _ProfileMenuGroup extends StatelessWidget {
  const _ProfileMenuGroup({required this.items});

  final List<_ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.large,
      ),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            items[index],
            if (index < items.length - 1) const Divider(height: 1, indent: 68),
          ],
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.badge,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: AppSpacing.sm,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xxs,
      ),
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withValues(alpha: 0.65),
          borderRadius: AppRadius.medium,
        ),
        child: Icon(icon, color: AppColors.primary, size: 21),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: badge == null
          ? const Icon(Icons.chevron_right_rounded)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    badge!,
                    style: const TextStyle(
                      color: AppColors.secondaryDark,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xxs),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
    );
  }
}

class _TechnicianInvite extends StatelessWidget {
  const _TechnicianInvite({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondaryLight,
      borderRadius: AppRadius.large,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: AppRadius.medium,
                ),
                child: const Icon(
                  Icons.handyman_rounded,
                  color: AppColors.surface,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Punya keahlian servis?',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.secondaryDark,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    const Text(
                      'Bergabung dan mulai menerima pekerjaan.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.secondaryDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetIcon extends StatelessWidget {
  const _SheetIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: AppRadius.medium,
      ),
      child: Icon(icon, color: AppColors.primary),
    );
  }
}

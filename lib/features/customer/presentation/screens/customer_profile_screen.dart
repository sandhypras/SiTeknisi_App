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
  ConsumerState<CustomerProfileScreen> createState() =>
      _CustomerProfileScreenState();
}

class _CustomerProfileScreenState
    extends ConsumerState<CustomerProfileScreen> {
  String? _nameOverride;
  String? _phoneOverride;

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authUserProvider).value;
    final fullName = _nameOverride ?? authUser?.fullName ?? 'Pengguna';
    final name = fullName.trim().split(' ').first;
    final phone = _phoneOverride ?? authUser?.phone ?? '-';
    final email = authUser?.email ?? '-';
    final initial = name.trim().isEmpty ? 'P' : name.trim()[0].toUpperCase();
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
            // Header
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

            // Profile hero card
            Container(
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
                              email,
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
                          backgroundColor:
                              Colors.white.withValues(alpha: 0.14),
                          foregroundColor: AppColors.surface,
                        ),
                        onPressed: () =>
                            _showEditDialog(context, fullName, phone),
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
                        Icon(Icons.shield_outlined,
                            color: AppColors.secondaryLight, size: 17),
                        SizedBox(width: AppSpacing.xs),
                        Flexible(
                          child: Text(
                            'Akun terverifikasi',
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
            ),
            const SizedBox(height: AppSpacing.md),

            // Stats
            Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: AppRadius.large,
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: _StatItem(
                      value: '8',
                      label: 'Booking',
                      icon: Icons.assignment_turned_in_outlined,
                    ),
                  ),
                  _StatDivider(),
                  Expanded(
                    child: _StatItem(
                      value: '4.9',
                      label: 'Rating',
                      icon: Icons.star_outline_rounded,
                    ),
                  ),
                  _StatDivider(),
                  Expanded(
                    child: _StatItem(
                      value: '3',
                      label: 'Invoice',
                      icon: Icons.receipt_long_outlined,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Menu aktivitas
            _SectionLabel(title: 'Aktivitas Servis'),
            const SizedBox(height: AppSpacing.sm),
            _MenuGroup(items: [
              _MenuItem(
                icon: Icons.history_rounded,
                title: 'Riwayat Booking',
                subtitle: 'Status servis yang sedang berjalan',
                badge: '2 aktif',
                onTap: () => context.push(AppRoutes.customerBookingHistory),
              ),
              _MenuItem(
                icon: Icons.receipt_long_outlined,
                title: 'Riwayat Invoice',
                subtitle: 'Unduh bukti pembayaran servis',
                onTap: () => context.push(AppRoutes.customerInvoiceHistory),
              ),
            ]),
            const SizedBox(height: AppSpacing.xl),

            // Menu akun
            _SectionLabel(title: 'Akun & Preferensi'),
            const SizedBox(height: AppSpacing.sm),
            _MenuGroup(items: [
              _MenuItem(
                icon: Icons.location_on_outlined,
                title: 'Alamat Tersimpan',
                subtitle: 'Rumah, kantor, dan lokasi servis',
                onTap: () => context.push(AppRoutes.customerLocation),
              ),
              _MenuItem(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Metode Pembayaran',
                subtitle: 'QRIS dan Virtual Account Midtrans',
                onTap: () => _showPaymentMethods(context),
              ),
              _MenuItem(
                icon: Icons.support_agent_rounded,
                title: 'Pusat Bantuan',
                subtitle: 'FAQ dan dukungan SiTeknisi',
                onTap: () => _showHelpCenter(context),
              ),
            ]),
            const SizedBox(height: AppSpacing.xl),

            // Join teknisi
            Material(
              color: AppColors.secondaryLight,
              borderRadius: AppRadius.large,
              child: InkWell(
                onTap: () => context.push(AppRoutes.technicianJoin),
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
                        child: const Icon(Icons.handyman_rounded,
                            color: AppColors.surface),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Punya keahlian servis?',
                              style: textTheme.titleSmall?.copyWith(
                                color: AppColors.secondaryDark,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
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
                      const Icon(Icons.arrow_forward_rounded,
                          color: AppColors.secondaryDark),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Logout
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

  Future<void> _showEditDialog(
      BuildContext context, String currentName, String currentPhone) async {
    final nameCtrl = TextEditingController(text: currentName);
    final phoneCtrl = TextEditingController(text: currentPhone);
    final formKey = GlobalKey<FormState>();

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Profil'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama lengkap',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor WhatsApp',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx, true);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (saved == true && mounted) {
      setState(() {
        _nameOverride = nameCtrl.text.trim();
        _phoneOverride = phoneCtrl.text.trim();
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui.')),
        );
      }
    }
    nameCtrl.dispose();
    phoneCtrl.dispose();
  }

  void _showPaymentMethods(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Metode Pembayaran',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900)),
              SizedBox(height: AppSpacing.xs),
              Text('Pilih metode saat menyelesaikan pembayaran booking.',
                  style: TextStyle(color: AppColors.textSecondary)),
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
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pusat Bantuan',
                  style: Theme.of(ctx).textTheme.titleLarge),
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
                leading:
                    const _SheetIcon(icon: Icons.support_agent_rounded),
                title: const Text('Hubungi dukungan SiTeknisi'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Tim dukungan akan segera tersedia.')),
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
    var notifEnabled = true;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pengaturan',
                    style: Theme.of(ctx).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: notifEnabled,
                  onChanged: (v) => setSheet(() => notifEnabled = v),
                  secondary: const Icon(Icons.notifications_outlined),
                  title: const Text('Notifikasi servis'),
                  subtitle:
                      const Text('Status booking dan penawaran teknisi'),
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
    final should = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.logout_rounded, color: AppColors.errorText),
        title: const Text('Keluar dari akun?'),
        content: const Text(
          'Anda perlu masuk kembali untuk melihat booking dan invoice.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (should == true && context.mounted) {
      final repo = ref.read(authRepositoryProvider);
      if (repo != null) {
        try {
          await repo.signOut();
          if (context.mounted) context.go(AppRoutes.splash);
        } on AuthFailure catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal logout: ${e.message}')),
            );
          }
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
        if (context.mounted) context.go(AppRoutes.splash);
      }
    }
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
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
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w900)),
        Text(label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 44, child: VerticalDivider(color: AppColors.border));
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w900),
    );
  }
}

class _MenuGroup extends StatelessWidget {
  const _MenuGroup({required this.items});
  final List<_MenuItem> items;

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
          for (var i = 0; i < items.length; i++) ...[
            items[i],
            if (i < items.length - 1)
              const Divider(height: 1, indent: 68),
          ],
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
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
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.xxs),
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
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle:
          Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: badge == null
          ? const Icon(Icons.chevron_right_rounded)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs, vertical: AppSpacing.xxs),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(badge!,
                      style: const TextStyle(
                          color: AppColors.secondaryDark,
                          fontSize: 11,
                          fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: AppSpacing.xxs),
                const Icon(Icons.chevron_right_rounded),
              ],
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

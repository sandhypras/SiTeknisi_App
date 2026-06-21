import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../shared/widgets/image_upload_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/safe_image.dart';
import '../providers/technician_image_provider.dart';

class TechnicianApplicationFormScreen extends StatelessWidget {
  const TechnicianApplicationFormScreen({super.key});
  @override
  Widget build(BuildContext context) => _TechForm(
    title: 'Data Keahlian',
    button: 'Lanjut ke KTP',
    flowStep: 0,
    onPressed: () => context.go(AppRoutes.technicianUploadKtp),
    children: const [
      CustomTextField(label: 'Keahlian', hintText: 'Printer, Komputer, Laptop'),
      SizedBox(height: AppSpacing.md),
      CustomTextField(
        label: 'Pengalaman',
        hintText: 'Contoh: 3 tahun',
        maxLines: 3,
      ),
    ],
  );
}

class TechnicianUploadDocumentScreen extends ConsumerWidget {
  const TechnicianUploadDocumentScreen({required this.profilePhoto, super.key});
  final bool profilePhoto;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(technicianImageProvider);
    final selectedBytes = profilePhoto ? images.profileBytes : images.ktpBytes;

    return _TechForm(
      title: profilePhoto ? 'Upload Foto Profil' : 'Upload KTP',
      button: profilePhoto ? 'Lanjut Data Bank' : 'Lanjut Foto Profil',
      flowStep: profilePhoto ? 2 : 1,
      onPressed: () => context.go(
        profilePhoto
            ? AppRoutes.technicianBankInfo
            : AppRoutes.technicianUploadProfile,
      ),
      children: [
        ImageUploadField(
          title: profilePhoto ? 'Foto Profil Teknisi' : 'Foto KTP',
          description: profilePhoto
              ? 'Foto ini akan tampil pada penawaran dan dapat dilihat pelanggan.'
              : 'Foto KTP hanya digunakan admin untuk proses verifikasi.',
          bytes: selectedBytes,
          aspectRatio: profilePhoto ? 1 : 16 / 10,
          onSelected: (bytes) {
            final controller = ref.read(technicianImageProvider.notifier);
            if (profilePhoto) {
              controller.setProfile(bytes);
            } else {
              controller.setKtp(bytes);
            }
          },
        ),
      ],
    );
  }
}

class TechnicianBankInformationScreen extends StatelessWidget {
  const TechnicianBankInformationScreen({super.key});
  @override
  Widget build(BuildContext context) => _TechForm(
    title: 'Informasi Rekening',
    button: 'Kirim Pengajuan',
    flowStep: 3,
    onPressed: () => context.go(AppRoutes.technicianVerification),
    children: const [
      CustomTextField(label: 'Nama Bank', hintText: 'BCA'),
      SizedBox(height: AppSpacing.md),
      CustomTextField(label: 'Nomor Rekening', hintText: '1234567890'),
      SizedBox(height: AppSpacing.md),
      CustomTextField(label: 'Nama Pemilik', hintText: 'Andi Kurniawan'),
    ],
  );
}

class TechnicianVerificationStatusScreen extends StatelessWidget {
  const TechnicianVerificationStatusScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.hourglass_top_rounded,
              size: 92,
              color: AppColors.warning,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Pengajuan Sedang Diverifikasi',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Admin akan meninjau KTP, foto profil, keahlian, dan rekening Anda.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Lihat Dashboard Demo',
              onPressed: () => context.go(AppRoutes.technicianDashboard),
            ),
          ],
        ),
      ),
    ),
  );
}

class TechnicianRequestDetailScreen extends StatelessWidget {
  const TechnicianRequestDetailScreen({super.key});
  @override
  Widget build(BuildContext context) => _TechForm(
    title: 'Request Detail',
    button: 'Buat Offer',
    onPressed: () => context.go(AppRoutes.technicianCreateOffer),
    children: const [
      _InfoCard(
        title: 'Servis Laptop Tidak Menyala',
        lines: [
          'Customer: Budi Santoso',
          'Lokasi: Dago · 2.1 km',
          'Jadwal: Hari ini, 14:00',
          'Keluhan: Laptop tidak menyala dan indikator berkedip',
        ],
      ),
    ],
  );
}

class TechnicianCreateOfferScreen extends ConsumerWidget {
  const TechnicianCreateOfferScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offerBytes = ref.watch(technicianImageProvider).offerBytes;

    return _TechForm(
      title: 'Create Offer',
      button: 'Kirim Offer',
      onPressed: () => context.go(AppRoutes.technicianRequests),
      children: [
        const CustomTextField(
          label: 'Harga Penawaran',
          hintText: 'Rp 175.000',
          prefixIcon: Icon(Icons.payments_outlined),
        ),
        const SizedBox(height: AppSpacing.md),
        const CustomTextField(
          label: 'Catatan Penawaran',
          hintText: 'Jelaskan estimasi dan cakupan jasa',
          maxLines: 4,
        ),
        const SizedBox(height: AppSpacing.md),
        ImageUploadField(
          title: 'Foto Pendukung Penawaran',
          description:
              'Tambahkan foto hasil pemeriksaan atau komponen agar pelanggan memahami penawaran.',
          bytes: offerBytes,
          onSelected: (bytes) =>
              ref.read(technicianImageProvider.notifier).setOffer(bytes),
        ),
        const SizedBox(height: AppSpacing.md),
        const _InfoCard(
          title: 'Estimasi Pendapatan',
          lines: [
            'Total offer: Rp 175.000',
            'Komisi platform 10%: Rp 17.500',
            'Pendapatan Anda: Rp 157.500',
          ],
        ),
      ],
    );
  }
}

class TechnicianCompletedJobsScreen extends StatelessWidget {
  const TechnicianCompletedJobsScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SimpleTechList(
    title: 'Completed Jobs',
    items: [
      'Servis Printer · Rp 150.000',
      'Servis Laptop · Rp 175.000',
      'Servis Komputer · Rp 225.000',
    ],
  );
}

class TechnicianBankAccountScreen extends StatelessWidget {
  const TechnicianBankAccountScreen({super.key});
  @override
  Widget build(BuildContext context) => _TechForm(
    title: 'Bank Account',
    button: 'Simpan Rekening',
    onPressed: () => context.pop(),
    children: const [
      StatusChip.success(
        label: 'Rekening Terverifikasi',
        icon: Icons.verified_rounded,
      ),
      SizedBox(height: AppSpacing.lg),
      CustomTextField(label: 'Bank', hintText: 'BCA'),
      SizedBox(height: AppSpacing.md),
      CustomTextField(label: 'Nomor Rekening', hintText: '1234567890'),
      SizedBox(height: AppSpacing.md),
      CustomTextField(label: 'Nama Pemilik', hintText: 'Andi Kurniawan'),
    ],
  );
}

class TechnicianProfileScreen extends ConsumerWidget {
  const TechnicianProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileBytes = ref.watch(technicianImageProvider).profileBytes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Teknisi'),
        actions: [
          IconButton(
            tooltip: 'Perbarui foto profil',
            onPressed: () => context.push(AppRoutes.technicianUploadProfile),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding,
          AppSpacing.sm,
          AppSpacing.screenPadding,
          AppSpacing.xl,
        ),
        children: [
          _TechnicianProfileHero(profileBytes: profileBytes),
          const SizedBox(height: AppSpacing.md),
          const _TechnicianReputationSummary(),
          const SizedBox(height: AppSpacing.lg),
          const _ProfileCompletionCard(),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Keahlian Utama',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _ExpertiseChip(icon: Icons.print_outlined, label: 'Printer'),
              _ExpertiseChip(icon: Icons.computer_rounded, label: 'Komputer'),
              _ExpertiseChip(icon: Icons.laptop_rounded, label: 'Laptop'),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Operasional Akun',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.xxs),
          const Text(
            'Kelola data kerja dan pencairan pendapatan.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          _TechnicianMenuGroup(
            items: [
              _TechnicianProfileMenu(
                icon: Icons.account_balance_outlined,
                title: 'Rekening Bank',
                subtitle: 'Kelola rekening pencairan dana',
                badge: 'Aktif',
                onTap: () => context.push(AppRoutes.technicianBankAccount),
              ),
              _TechnicianProfileMenu(
                icon: Icons.task_alt_rounded,
                title: 'Pekerjaan Selesai',
                subtitle: 'Riwayat servis dan pendapatan',
                onTap: () => context.push(AppRoutes.technicianCompletedJobs),
              ),
              _TechnicianProfileMenu(
                icon: Icons.photo_camera_back_outlined,
                title: 'Foto Profil',
                subtitle: 'Foto yang dilihat calon pelanggan',
                onTap: () => context.push(AppRoutes.technicianUploadProfile),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.successContainer,
              borderRadius: AppRadius.large,
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.28),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.successText,
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Identitas terverifikasi',
                        style: TextStyle(
                          color: AppColors.successText,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xxs),
                      Text(
                        'KTP, rekening, dan nomor telepon telah diperiksa.',
                        style: TextStyle(
                          color: AppColors.successText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            onPressed: () => context.go(AppRoutes.customerHome),
            icon: const Icon(Icons.swap_horiz_rounded),
            label: const Text('Beralih ke Mode Customer'),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: AppColors.errorText),
            onPressed: () => context.go(AppRoutes.login),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Keluar dari akun'),
          ),
        ],
      ),
    );
  }
}

class _TechnicianProfileHero extends StatelessWidget {
  const _TechnicianProfileHero({required this.profileBytes});

  final Uint8List? profileBytes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: AppRadius.extraLarge,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: AppRadius.large,
                child: SafeImage(
                  bytes: profileBytes,
                  assetPath: AppAssets.technicianAndi,
                  width: 88,
                  height: 88,
                  fallbackIcon: Icons.person_rounded,
                ),
              ),
              const Positioned(
                right: -5,
                bottom: -5,
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor: AppColors.surface,
                  child: Icon(
                    Icons.verified_rounded,
                    size: 21,
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
                  'Andi Kurniawan',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: AppRadius.pill,
                  ),
                  child: const Text(
                    'Teknisi Profesional',
                    style: TextStyle(
                      color: AppColors.surface,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  'Bandung · Aktif sejak 2024',
                  style: TextStyle(color: AppColors.primaryLight, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechnicianReputationSummary extends StatelessWidget {
  const _TechnicianReputationSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _ReputationItem(value: '4.9', label: 'Rating'),
          ),
          _ReputationDivider(),
          Expanded(
            child: _ReputationItem(value: '184', label: 'Pekerjaan'),
          ),
          _ReputationDivider(),
          Expanded(
            child: _ReputationItem(value: '98%', label: 'Tepat Waktu'),
          ),
        ],
      ),
    );
  }
}

class _ReputationItem extends StatelessWidget {
  const _ReputationItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
        ),
      ],
    );
  }
}

class _ReputationDivider extends StatelessWidget {
  const _ReputationDivider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 36,
      child: VerticalDivider(color: AppColors.border),
    );
  }
}

class _ProfileCompletionCard extends StatelessWidget {
  const _ProfileCompletionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: AppRadius.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                color: AppColors.secondaryDark,
              ),
              SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Profil profesional 90%',
                  style: TextStyle(
                    color: AppColors.secondaryDark,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'Level Pro',
                style: TextStyle(
                  color: AppColors.secondaryDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: AppRadius.pill,
            child: const LinearProgressIndicator(
              value: 0.9,
              minHeight: 7,
              color: AppColors.secondary,
              backgroundColor: AppColors.surface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Tambahkan sertifikat keahlian untuk meningkatkan kepercayaan.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ExpertiseChip extends StatelessWidget {
  const _ExpertiseChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 17, color: AppColors.primary),
      label: Text(label),
      side: const BorderSide(color: AppColors.border),
      backgroundColor: AppColors.surface,
    );
  }
}

class _TechnicianMenuGroup extends StatelessWidget {
  const _TechnicianMenuGroup({required this.items});

  final List<_TechnicianProfileMenu> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(color: AppColors.border),
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

class _TechnicianProfileMenu extends StatelessWidget {
  const _TechnicianProfileMenu({
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
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xxs,
      ),
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: AppRadius.medium,
        ),
        child: Icon(icon, color: AppColors.primary, size: 21),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: badge == null
          ? const Icon(Icons.chevron_right_rounded)
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: AppColors.successContainer,
                borderRadius: AppRadius.pill,
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: AppColors.successText,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
    );
  }
}

class _TechForm extends StatelessWidget {
  const _TechForm({
    required this.title,
    required this.children,
    required this.button,
    required this.onPressed,
    this.flowStep,
  });
  final String title, button;
  final List<Widget> children;
  final VoidCallback onPressed;
  final int? flowStep;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    bottomNavigationBar: SafeArea(
      minimum: const EdgeInsets.all(AppSpacing.screenPadding),
      child: PrimaryButton(label: button, onPressed: onPressed),
    ),
    body: ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      children: [
        if (flowStep != null) ...[
          MobileFlowStepper(
            steps: const ['Data', 'KTP', 'Profil', 'Rekening'],
            currentStep: flowStep!,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        ...children,
      ],
    ),
  );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.lines});
  final String title;
  final List<String> lines;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(line),
            ),
          ),
        ],
      ),
    ),
  );
}

class _SimpleTechList extends StatelessWidget {
  const _SimpleTechList({required this.title, required this.items});
  final String title;
  final List<String> items;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      itemCount: items.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text(items[index]),
          trailing: const Icon(Icons.chevron_right_rounded),
        ),
      ),
    ),
  );
}

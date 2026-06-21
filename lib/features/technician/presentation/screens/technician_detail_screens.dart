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
      appBar: AppBar(title: const Text('Profil Teknisi')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: AppRadius.extraLarge,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.large,
                  child: SafeImage(
                    bytes: profileBytes,
                    assetPath: AppAssets.technicianAndi,
                    width: 84,
                    height: 84,
                    fallbackIcon: Icons.person_rounded,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Andi Kurniawan',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const StatusChip.success(
                        label: 'Terverifikasi',
                        icon: Icons.verified_rounded,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text('4.9 rating - 184 pekerjaan'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Keahlian', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          const Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              Chip(label: Text('Printer')),
              Chip(label: Text('Komputer')),
              Chip(label: Text('Laptop')),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _TechnicianProfileMenu(
            icon: Icons.account_balance_outlined,
            title: 'Rekening Bank',
            subtitle: 'Kelola rekening pencairan dana',
            onTap: () => context.push(AppRoutes.technicianBankAccount),
          ),
          _TechnicianProfileMenu(
            icon: Icons.task_alt_rounded,
            title: 'Pekerjaan Selesai',
            subtitle: 'Lihat riwayat dan pendapatan pekerjaan',
            onTap: () => context.push(AppRoutes.technicianCompletedJobs),
          ),
          _TechnicianProfileMenu(
            icon: Icons.photo_camera_back_outlined,
            title: 'Perbarui Foto Profil',
            subtitle: 'Foto ini tampil pada penawaran pelanggan',
            onTap: () => context.push(AppRoutes.technicianUploadProfile),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => context.go(AppRoutes.customerHome),
            icon: const Icon(Icons.swap_horiz_rounded),
            label: const Text('Beralih ke Mode Customer'),
          ),
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
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
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

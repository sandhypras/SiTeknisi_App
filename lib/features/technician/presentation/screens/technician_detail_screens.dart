import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/status_chip.dart';

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

class TechnicianUploadDocumentScreen extends StatelessWidget {
  const TechnicianUploadDocumentScreen({required this.profilePhoto, super.key});
  final bool profilePhoto;
  @override
  Widget build(BuildContext context) => _TechForm(
    title: profilePhoto ? 'Upload Foto Profil' : 'Upload KTP',
    button: profilePhoto ? 'Lanjut Data Bank' : 'Lanjut Foto Profil',
    flowStep: profilePhoto ? 2 : 1,
    onPressed: () => context.go(
      profilePhoto
          ? AppRoutes.technicianBankInfo
          : AppRoutes.technicianUploadProfile,
    ),
    children: [
      Container(
        height: 260,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.large,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              profilePhoto
                  ? Icons.account_circle_outlined
                  : Icons.badge_outlined,
              size: 72,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              profilePhoto
                  ? 'Ambil atau upload foto profil'
                  : 'Upload foto KTP yang jelas',
            ),
          ],
        ),
      ),
    ],
  );
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

class TechnicianCreateOfferScreen extends StatelessWidget {
  const TechnicianCreateOfferScreen({super.key});
  @override
  Widget build(BuildContext context) => _TechForm(
    title: 'Create Offer',
    button: 'Kirim Offer',
    onPressed: () => context.go(AppRoutes.technicianRequests),
    children: const [
      CustomTextField(
        label: 'Harga Penawaran',
        hintText: 'Rp 175.000',
        prefixIcon: Icon(Icons.payments_outlined),
      ),
      SizedBox(height: AppSpacing.md),
      CustomTextField(
        label: 'Catatan Penawaran',
        hintText: 'Jelaskan estimasi dan cakupan jasa',
        maxLines: 4,
      ),
      SizedBox(height: AppSpacing.md),
      _InfoCard(
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

class TechnicianProfileScreen extends StatelessWidget {
  const TechnicianProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SimpleTechList(
    title: 'Technician Profile',
    items: [
      'Andi Kurniawan · Verified',
      'Keahlian: Printer, Komputer & Laptop',
      'Rating: 4.9 · 184 pekerjaan',
      'Bank Account',
      'Keluar dari mode Teknisi',
    ],
  );
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

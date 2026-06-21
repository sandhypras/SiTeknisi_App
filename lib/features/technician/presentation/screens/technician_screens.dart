import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/safe_image.dart';
import '../../../../shared/utils/whatsapp_launcher.dart';
import '../widgets/technician_shell.dart';

class JoinTechnicianScreen extends StatelessWidget {
  const JoinTechnicianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Jadi Teknisi')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: 'Mulai Pendaftaran',
          icon: Icons.verified_user_rounded,
          onPressed: () => context.go(AppRoutes.technicianApplication),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: const [
          _HeroPanel(
            title: 'Gabung jadi teknisi SiTeknisi',
            subtitle: 'Lengkapi verifikasi untuk mulai menerima permintaan.',
            icon: Icons.engineering_rounded,
          ),
          SizedBox(height: AppSpacing.lg),
          CustomTextField(
            label: 'Keahlian',
            hintText: 'Printer, Komputer, Laptop',
          ),
          SizedBox(height: AppSpacing.md),
          CustomTextField(label: 'Nomor KTP', hintText: '320xxxxxxxxxxxxx'),
          SizedBox(height: AppSpacing.md),
          CustomTextField(
            label: 'Pengalaman',
            hintText: 'Contoh: 3 tahun',
            maxLines: 3,
          ),
          SizedBox(height: AppSpacing.md),
          _UploadBox(label: 'Upload KTP'),
          SizedBox(height: AppSpacing.md),
          _UploadBox(label: 'Upload Foto Profil'),
        ],
      ),
    );
  }
}

class TechnicianDashboardScreen extends StatelessWidget {
  const TechnicianDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TechnicianShell(
      currentIndex: 0,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            const _TechnicianHeader(
              title: 'Dashboard Teknisi',
              subtitle: 'Halo, Andi. Ada request baru di sekitar Anda.',
            ),
            const SizedBox(height: AppSpacing.lg),
            const MobileFlowStepper(
              steps: ['Permintaan', 'Penawaran', 'Aktif', 'Selesai'],
              currentStep: 0,
            ),
            const SizedBox(height: AppSpacing.lg),
            const _AvailabilityCard(),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: const [
                Expanded(
                  child: _MetricCard(value: '12', label: 'Permintaan'),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _MetricCard(value: '8', label: 'Selesai'),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _MetricCard(value: 'Rp 1,8 jt', label: 'Pendapatan'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const _RequestCard(),
          ],
        ),
      ),
    );
  }
}

class TechnicianRequestsScreen extends StatelessWidget {
  const TechnicianRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TechnicianShell(
      currentIndex: 1,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: const [
            _TechnicianHeader(
              title: 'Permintaan Masuk',
              subtitle: 'Pilih pekerjaan yang sesuai lalu kirim penawaran.',
            ),
            SizedBox(height: AppSpacing.lg),
            MobileFlowStepper(
              steps: ['Permintaan', 'Penawaran', 'Aktif', 'Selesai'],
              currentStep: 0,
            ),
            SizedBox(height: AppSpacing.lg),
            _RequestCard(),
            SizedBox(height: AppSpacing.sm),
            _RequestCard(
              title: 'Servis Komputer Lambat',
              location: 'Antapani • 4,2 km',
            ),
          ],
        ),
      ),
    );
  }
}

class TechnicianJobsScreen extends StatelessWidget {
  const TechnicianJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TechnicianShell(
      currentIndex: 2,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            const _TechnicianHeader(
              title: 'Pekerjaan Aktif',
              subtitle: 'Perbarui progres agar customer mengetahui status.',
            ),
            const SizedBox(height: AppSpacing.lg),
            const MobileFlowStepper(
              steps: ['Permintaan', 'Penawaran', 'Aktif', 'Selesai'],
              currentStep: 2,
            ),
            const SizedBox(height: AppSpacing.lg),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StatusChip.info(label: 'Sedang dikerjakan'),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Servis Laptop - Budi Santoso',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Text('Status: Teknisi dalam perjalanan'),
                    const SizedBox(height: AppSpacing.md),
                    ClipRRect(
                      borderRadius: AppRadius.large,
                      child: const SafeImage(
                        assetPath: AppAssets.laptop,
                        width: double.infinity,
                        height: 150,
                        fallbackIcon: Icons.laptop_rounded,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => openWhatsApp(
                          context,
                          phoneNumber: '6281234567800',
                          message:
                              'Halo Budi, saya Andi teknisi dari SiTeknisi. Penawaran servis laptop Anda sudah saya terima.',
                        ),
                        icon: const Icon(Icons.chat_rounded),
                        label: const Text('Hubungi Customer via WhatsApp'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    PrimaryButton(
                      label: 'Tandai Pekerjaan Selesai',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Status job diupdate dummy.'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TechnicianEarningsScreen extends StatelessWidget {
  const TechnicianEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TechnicianShell(
      currentIndex: 3,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: const [
            _TechnicianHeader(
              title: 'Pendapatan',
              subtitle: 'Ringkasan pendapatan dan rekening teknisi.',
            ),
            SizedBox(height: AppSpacing.lg),
            _HeroPanel(
              title: 'Rp 1.800.000',
              subtitle: 'Pendapatan bulan ini setelah komisi platform 10%.',
              icon: Icons.account_balance_wallet_rounded,
            ),
            SizedBox(height: AppSpacing.lg),
            CustomTextField(label: 'Bank', hintText: 'BCA'),
            SizedBox(height: AppSpacing.md),
            CustomTextField(label: 'Nomor Rekening', hintText: '1234567890'),
            SizedBox(height: AppSpacing.md),
            CustomTextField(label: 'Nama Pemilik', hintText: 'Andi Kurniawan'),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    this.title = 'Servis Laptop Tidak Menyala',
    this.location = 'Dago • 2,1 km',
  });

  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatusChip.warning(label: 'Permintaan terbuka'),
            const SizedBox(height: AppSpacing.sm),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: AppSpacing.xxs),
                Text(location),
                const Spacer(),
                const Icon(
                  Icons.schedule_rounded,
                  size: 18,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: AppSpacing.xxs),
                const Text('Hari ini'),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: AppRadius.medium,
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.notes_rounded,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      'Laptop tidak menyala dan lampu indikator berkedip.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: 'Lihat Detail & Tawarkan Harga',
              icon: Icons.local_offer_rounded,
              onPressed: () => context.go(AppRoutes.technicianRequestDetail),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechnicianHeader extends StatelessWidget {
  const _TechnicianHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _AvailabilityCard extends StatelessWidget {
  const _AvailabilityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.successContainer,
        borderRadius: AppRadius.large,
        border: Border.all(color: AppColors.success.withValues(alpha: 0.35)),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.success,
            foregroundColor: Colors.white,
            child: Icon(Icons.wifi_tethering_rounded),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anda sedang online',
                  style: TextStyle(
                    color: AppColors.successText,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: AppSpacing.xxs),
                Text(
                  'Permintaan baru akan muncul secara otomatis.',
                  style: TextStyle(color: AppColors.successText),
                ),
              ],
            ),
          ),
          Icon(Icons.toggle_on_rounded, size: 42, color: AppColors.successText),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: AppRadius.large,
      ),
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          Text(label),
        ],
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppRadius.large,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.surface, size: 42),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.surface),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.surface.withValues(alpha: 0.86),
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

class _UploadBox extends StatelessWidget {
  const _UploadBox({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.large,
      ),
      child: Center(child: Text(label)),
    );
  }
}

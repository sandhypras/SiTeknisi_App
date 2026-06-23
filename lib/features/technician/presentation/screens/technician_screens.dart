import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/slogan_banner.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/safe_image.dart';
import '../../../../shared/utils/whatsapp_launcher.dart';
import '../widgets/technician_shell.dart';

class JoinTechnicianScreen extends StatelessWidget {
  const JoinTechnicianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FF),
        title: const Text('Daftar Jadi Teknisi'),
        elevation: 0,
      ),
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
        children: [
          // Hero gradient banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0F4FD9), AppColors.primary, Color(0xFF3B82F6)],
              ),
              borderRadius: AppRadius.extraLarge,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  bottom: -30,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: AppRadius.pill,
                      ),
                      child: Text(
                        'Bergabung Sekarang',
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Wujudkan Penghasilan\nDari Keahlianmu',
                      style: textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Ribuan customer menunggu teknisi handal seperti Anda. Daftar gratis, mulai terima job hari ini.',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.88),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        _HeroBadge(icon: Icons.verified_rounded, label: 'Terverifikasi'),
                        const SizedBox(width: AppSpacing.sm),
                        _HeroBadge(icon: Icons.payments_rounded, label: 'Bayar Cepat'),
                        const SizedBox(width: AppSpacing.sm),
                        _HeroBadge(icon: Icons.stars_rounded, label: 'Rating Terbuka'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Benefit section
          Text(
            'Keuntungan Bergabung',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.extraLarge,
              border: Border.all(color: const Color(0xFFE0E7FF)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: const [
                _BenefitTile(
                  icon: Icons.money_rounded,
                  color: Color(0xFF059669),
                  title: 'Pendapatan Fleksibel',
                  subtitle: 'Terima job kapan saja, pencairan dana mingguan.',
                  isFirst: true,
                ),
                Divider(height: 1, indent: 64),
                _BenefitTile(
                  icon: Icons.location_on_rounded,
                  color: Color(0xFF2563EB),
                  title: 'Job di Sekitar Kamu',
                  subtitle: 'Prioritas permintaan berdasarkan jarak terdekat.',
                ),
                Divider(height: 1, indent: 64),
                _BenefitTile(
                  icon: Icons.shield_rounded,
                  color: Color(0xFF7C3AED),
                  title: 'Perlindungan Transaksi',
                  subtitle: 'Pembayaran aman melalui platform, anti penipuan.',
                ),
                Divider(height: 1, indent: 64),
                _BenefitTile(
                  icon: Icons.trending_up_rounded,
                  color: Color(0xFFD97706),
                  title: 'Bangun Reputasi',
                  subtitle: 'Rating bintang dari customer meningkatkan kepercayaan.',
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Step indicator
          Text(
            'Proses Pendaftaran',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.extraLarge,
              border: Border.all(color: const Color(0xFFE0E7FF)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: const [
                _StepTile(step: '1', title: 'Isi Data Diri & Keahlian',
                    subtitle: 'Nama, nomor HP, kota, dan bidang keahlian.'),
                _StepTile(step: '2', title: 'Upload Foto KTP',
                    subtitle: 'Untuk verifikasi identitas oleh admin.'),
                _StepTile(step: '3', title: 'Upload Foto Profil',
                    subtitle: 'Foto yang tampil ke customer saat penawaran.'),
                _StepTile(step: '4', title: 'Data Rekening Bank',
                    subtitle: 'Untuk pencairan pendapatan setiap minggu.',
                    isLast: true),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.successContainer,
              borderRadius: AppRadius.large,
              border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.35)),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined,
                    color: AppColors.successText, size: 18),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Proses verifikasi admin 1×24 jam setelah pengajuan lengkap.',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.successText,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: AppRadius.pill,
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 13),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  const _BenefitTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.isFirst = false,
    this.isLast = false,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: isFirst ? AppSpacing.md : AppSpacing.sm,
        bottom: isLast ? AppSpacing.md : AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: AppRadius.medium,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
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

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.step,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });
  final String step;
  final String title;
  final String subtitle;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 36,
                color: AppColors.border,
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: isLast ? 0 : AppSpacing.md),
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
            _TechnicianHeader(
              title: 'Selamat pagi, Andi',
              subtitle: 'Siap membantu perangkat kembali bekerja?',
              trailing: _TechnicianAvatarButton(
                onPressed: () => context.push(AppRoutes.technicianProfile),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const _AvailabilityCard(),
            const SizedBox(height: AppSpacing.md),
            _PerformanceCard(
              onTap: () => context.go(AppRoutes.technicianEarnings),
            ),
            const SizedBox(height: AppSpacing.md),
            _DashboardQuickActions(
              onRequests: () => context.go(AppRoutes.technicianRequests),
              onJobs: () => context.go(AppRoutes.technicianJobs),
              onEarnings: () => context.go(AppRoutes.technicianEarnings),
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Permintaan Terdekat',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => context.go(AppRoutes.technicianRequests),
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const _RequestCard(),
            const SizedBox(height: AppSpacing.lg),
            SloganBanner(
              imageAsset: AppAssets.technicianEarningsPromo,
              title: 'Keahlian yang dipercaya, pekerjaan yang berarti.',
              subtitle: 'Jaga kualitas servis dan bangun reputasi terbaik.',
              buttonLabel: 'Lihat Performa',
              onPressed: () => context.go(AppRoutes.technicianEarnings),
            ),
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
              imageAsset: AppAssets.computer,
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

class TechnicianEarningsScreen extends StatefulWidget {
  const TechnicianEarningsScreen({super.key});

  @override
  State<TechnicianEarningsScreen> createState() =>
      _TechnicianEarningsScreenState();
}

class _TechnicianEarningsScreenState extends State<TechnicianEarningsScreen> {
  bool _showBalance = true;
  int _periodIndex = 1;

  @override
  Widget build(BuildContext context) {
    return TechnicianShell(
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
            _TechnicianHeader(
              title: 'Pendapatan',
              subtitle: 'Pantau hasil kerja dan pencairan dana Anda.',
              trailing: IconButton.filledTonal(
                tooltip: _showBalance ? 'Sembunyikan saldo' : 'Tampilkan saldo',
                onPressed: () => setState(() => _showBalance = !_showBalance),
                icon: Icon(
                  _showBalance
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _EarningsBalanceCard(
              showBalance: _showBalance,
              onWithdraw: () => _showWithdrawSheet(context),
            ),
            const SizedBox(height: AppSpacing.md),
            _PayoutAccountCard(
              onTap: () => context.push(AppRoutes.technicianBankAccount),
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Performa Pendapatan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const StatusChip.success(label: '+18,5%'),
              ],
            ),
            const SizedBox(height: AppSpacing.xxs),
            const Text(
              'Dibandingkan periode sebelumnya',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: AppSpacing.md),
            _PeriodSelector(
              selectedIndex: _periodIndex,
              onSelected: (index) => setState(() => _periodIndex = index),
            ),
            const SizedBox(height: AppSpacing.sm),
            _EarningsChart(periodIndex: _periodIndex),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Transaksi Terbaru',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.push(AppRoutes.technicianCompletedJobs),
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _TransactionList(
              onTransactionTap: (transaction) =>
                  _showTransactionDetail(context, transaction),
            ),
          ],
        ),
      ),
    );
  }

  void _showWithdrawSheet(BuildContext context) {
    final amountController = TextEditingController(text: '1000000');
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          MediaQuery.viewInsetsOf(sheetContext).bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tarik Saldo',
              style: Theme.of(
                sheetContext,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: AppSpacing.xxs),
            const Text(
              'Saldo tersedia Rp 1.450.000',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nominal pencairan',
                prefixText: 'Rp ',
                prefixIcon: Icon(Icons.payments_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const _WithdrawDestination(),
            const SizedBox(height: AppSpacing.sm),
            const Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 17,
                  color: AppColors.textMuted,
                ),
                SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Dana masuk dalam 1-2 hari kerja tanpa biaya admin.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: 'Konfirmasi Pencairan',
              icon: Icons.arrow_outward_rounded,
              onPressed: () {
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Permintaan pencairan berhasil dibuat.'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ).whenComplete(amountController.dispose);
  }

  void _showTransactionDetail(
    BuildContext context,
    _EarningsTransaction transaction,
  ) {
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
                'Detail Pendapatan',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: AppSpacing.lg),
              _EarningsDetailRow(label: 'Pekerjaan', value: transaction.title),
              _EarningsDetailRow(label: 'Booking', value: transaction.booking),
              _EarningsDetailRow(label: 'Tanggal', value: transaction.date),
              const _EarningsDetailRow(
                label: 'Harga servis',
                value: 'Rp 500.000',
              ),
              const _EarningsDetailRow(
                label: 'Komisi platform',
                value: '- Rp 50.000',
              ),
              const Divider(height: AppSpacing.xl),
              _EarningsDetailRow(
                label: 'Pendapatan bersih',
                value: transaction.amount,
                emphasized: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EarningsBalanceCard extends StatelessWidget {
  const _EarningsBalanceCard({
    required this.showBalance,
    required this.onWithdraw,
  });

  final bool showBalance;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: AppRadius.extraLarge,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.24),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.primaryLight,
                size: 20,
              ),
              SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Saldo dapat dicairkan',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Text(
              showBalance ? 'Rp 1.450.000' : 'Rp ••••••••',
              key: ValueKey(showBalance),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.08),
              borderRadius: AppRadius.medium,
              border: Border.all(
                color: AppColors.surface.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      color: AppColors.primaryLight,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Expanded(
                      child: Text(
                        'Pendapatan sedang diproses',
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      showBalance ? 'Rp 350.000' : 'Rp ••••••',
                      style: const TextStyle(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.surface,
                    ),
                    onPressed: onWithdraw,
                    icon: const Icon(Icons.arrow_outward_rounded, size: 18),
                    label: const Text('Tarik Saldo'),
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

class _PayoutAccountCard extends StatelessWidget {
  const _PayoutAccountCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.large,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadius.large,
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: AppRadius.medium,
                ),
                child: const Icon(
                  Icons.account_balance_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rekening Pencairan',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: AppSpacing.xxs),
                    Text(
                      'BCA •••• 7890 · Andi Kurniawan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const StatusChip.success(label: 'Aktif'),
            ],
          ),
        ),
      ),
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    const labels = ['Minggu', 'Bulan', 'Tahun'];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.medium,
      ),
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++)
            Expanded(
              child: InkWell(
                borderRadius: AppRadius.small,
                onTap: () => onSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? AppColors.surface
                        : Colors.transparent,
                    borderRadius: AppRadius.small,
                    boxShadow: selectedIndex == index
                        ? [
                            BoxShadow(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.08,
                              ),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    labels[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedIndex == index
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: selectedIndex == index
                          ? FontWeight.w900
                          : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EarningsChart extends StatelessWidget {
  const _EarningsChart({required this.periodIndex});

  final int periodIndex;

  @override
  Widget build(BuildContext context) {
    final values = switch (periodIndex) {
      0 => const [0.42, 0.68, 0.5, 0.82, 0.64, 0.95, 0.74],
      1 => const [0.5, 0.72, 0.64, 0.92],
      _ => const [0.34, 0.48, 0.66, 0.74, 0.92, 0.82],
    };
    final labels = switch (periodIndex) {
      0 => const ['S', 'S', 'R', 'K', 'J', 'S', 'M'],
      1 => const ['M1', 'M2', 'M3', 'M4'],
      _ => const ['Jan', 'Mar', 'Mei', 'Jul', 'Sep', 'Nov'],
    };

    return Container(
      height: 196,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var index = 0; index < values.length; index++) ...[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: values[index],
                        widthFactor: 0.56,
                        child: Container(
                          decoration: BoxDecoration(
                            color: index == values.length - 1
                                ? AppColors.secondary
                                : AppColors.primary,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    labels[index],
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (index < values.length - 1)
              const SizedBox(width: AppSpacing.xxs),
          ],
        ],
      ),
    );
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({required this.onTransactionTap});

  final ValueChanged<_EarningsTransaction> onTransactionTap;

  static const _transactions = [
    _EarningsTransaction(
      title: 'Servis Laptop',
      booking: 'BKG-260621-018',
      date: '21 Jun 2026',
      amount: 'Rp 450.000',
      icon: Icons.laptop_rounded,
      status: 'Tersedia',
    ),
    _EarningsTransaction(
      title: 'Servis Printer',
      booking: 'BKG-260620-011',
      date: '20 Jun 2026',
      amount: 'Rp 225.000',
      icon: Icons.print_rounded,
      status: 'Tersedia',
    ),
    _EarningsTransaction(
      title: 'Servis Komputer',
      booking: 'BKG-260619-006',
      date: '19 Jun 2026',
      amount: 'Rp 350.000',
      icon: Icons.computer_rounded,
      status: 'Diproses',
    ),
  ];

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
          for (var index = 0; index < _transactions.length; index++) ...[
            _TransactionTile(
              transaction: _transactions[index],
              onTap: () => onTransactionTap(_transactions[index]),
            ),
            if (index < _transactions.length - 1)
              const Divider(height: 1, indent: 68),
          ],
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction, required this.onTap});

  final _EarningsTransaction transaction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isPending = transaction.status == 'Diproses';
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: AppRadius.medium,
        ),
        child: Icon(transaction.icon, color: AppColors.primary, size: 21),
      ),
      title: Text(
        transaction.title,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        '${transaction.date} · ${transaction.status}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            transaction.amount,
            style: const TextStyle(
              color: AppColors.successText,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            isPending ? 'Menunggu selesai' : 'Masuk saldo',
            style: TextStyle(
              color: isPending ? AppColors.warningText : AppColors.textMuted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _EarningsTransaction {
  const _EarningsTransaction({
    required this.title,
    required this.booking,
    required this.date,
    required this.amount,
    required this.icon,
    required this.status,
  });

  final String title;
  final String booking;
  final String date;
  final String amount;
  final IconData icon;
  final String status;
}

class _WithdrawDestination extends StatelessWidget {
  const _WithdrawDestination();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.medium,
      ),
      child: const Row(
        children: [
          Icon(Icons.account_balance_rounded, color: AppColors.primary),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bank BCA', style: TextStyle(fontWeight: FontWeight.w800)),
                Text(
                  '•••• 7890 · Andi Kurniawan',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.verified_rounded, color: AppColors.success),
        ],
      ),
    );
  }
}

class _EarningsDetailRow extends StatelessWidget {
  const _EarningsDetailRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: emphasized ? AppColors.successText : null,
                fontWeight: emphasized ? FontWeight.w900 : FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    this.title = 'Servis Laptop Tidak Menyala',
    this.imageAsset = AppAssets.laptop,
    this.location = 'Dago • 2,1 km',
  });

  final String title;
  final String imageAsset;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: AppRadius.medium,
              child: SafeImage(
                assetPath: imageAsset,
                width: double.infinity,
                height: 132,
                fallbackIcon: Icons.home_repair_service_rounded,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
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
  const _TechnicianHeader({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppSpacing.sm),
          trailing!,
        ],
      ],
    );
  }
}

class _TechnicianAvatarButton extends StatelessWidget {
  const _TechnicianAvatarButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Buka profil teknisi',
      child: Material(
        color: AppColors.primaryLight,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: const Padding(
            padding: EdgeInsets.all(3),
            child: ClipOval(
              child: SafeImage(
                assetPath: AppAssets.technicianAndi,
                width: 48,
                height: 48,
                fallbackIcon: Icons.person_rounded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AvailabilityCard extends StatefulWidget {
  const _AvailabilityCard();

  @override
  State<_AvailabilityCard> createState() => _AvailabilityCardState();
}

class _AvailabilityCardState extends State<_AvailabilityCard> {
  bool _isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.successContainer,
        borderRadius: AppRadius.large,
        border: Border.all(color: AppColors.success.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: _isOnline ? AppColors.success : AppColors.disabled,
            foregroundColor: AppColors.surface,
            child: Icon(
              _isOnline ? Icons.wifi_tethering_rounded : Icons.wifi_off_rounded,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isOnline ? 'Anda sedang online' : 'Anda sedang offline',
                  style: const TextStyle(
                    color: AppColors.successText,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  _isOnline
                      ? 'Permintaan baru akan muncul secara otomatis.'
                      : 'Aktifkan status untuk menerima permintaan.',
                  style: const TextStyle(color: AppColors.successText),
                ),
              ],
            ),
          ),
          Switch(
            value: _isOnline,
            onChanged: (value) => setState(() => _isOnline = value),
          ),
        ],
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  const _PerformanceCard({required this.onTap});

  final VoidCallback onTap;

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
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pendapatan Bulan Ini',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      'Rp 1.850.000',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.surface,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Lihat pendapatan',
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.surface,
                  backgroundColor: Colors.white.withValues(alpha: 0.13),
                ),
                onPressed: onTap,
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Row(
            children: [
              Expanded(
                child: _PerformanceMetric(value: '12', label: 'Permintaan'),
              ),
              _PerformanceDivider(),
              Expanded(
                child: _PerformanceMetric(value: '3', label: 'Job Aktif'),
              ),
              _PerformanceDivider(),
              Expanded(
                child: _PerformanceMetric(value: '8', label: 'Selesai'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PerformanceMetric extends StatelessWidget {
  const _PerformanceMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.surface,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColors.primaryLight, fontSize: 11),
        ),
      ],
    );
  }
}

class _PerformanceDivider extends StatelessWidget {
  const _PerformanceDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      color: Colors.white.withValues(alpha: 0.2),
    );
  }
}

class _DashboardQuickActions extends StatelessWidget {
  const _DashboardQuickActions({
    required this.onRequests,
    required this.onJobs,
    required this.onEarnings,
  });

  final VoidCallback onRequests;
  final VoidCallback onJobs;
  final VoidCallback onEarnings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.large,
      ),
      child: Row(
        children: [
          Expanded(
            child: _QuickAction(
              icon: Icons.inbox_outlined,
              label: 'Request',
              onTap: onRequests,
            ),
          ),
          Expanded(
            child: _QuickAction(
              icon: Icons.build_circle_outlined,
              label: 'Job Aktif',
              onTap: onJobs,
            ),
          ),
          Expanded(
            child: _QuickAction(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Pendapatan',
              onTap: onEarnings,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: AppRadius.medium,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
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



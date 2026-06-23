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

class TechnicianApplicationFormScreen extends ConsumerStatefulWidget {
  const TechnicianApplicationFormScreen({super.key});
  @override
  ConsumerState<TechnicianApplicationFormScreen> createState() =>
      _TechnicianApplicationFormScreenState();
}

class _TechnicianApplicationFormScreenState
    extends ConsumerState<TechnicianApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _hpCtrl = TextEditingController();
  final _keahlianCtrl = TextEditingController();
  final _pengalamanCtrl = TextEditingController();
  final _kotaCtrl = TextEditingController();

  @override
  void dispose() {
    _namaCtrl.dispose();
    _hpCtrl.dispose();
    _keahlianCtrl.dispose();
    _pengalamanCtrl.dispose();
    _kotaCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.go(AppRoutes.technicianUploadKtp);
    }
  }

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
          label: 'Lanjut ke Upload KTP',
          icon: Icons.arrow_forward_rounded,
          onPressed: _submit,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            MobileFlowStepper(
              steps: const ['Data Diri', 'KTP', 'Foto', 'Rekening'],
              currentStep: 0,
            ),
            const SizedBox(height: AppSpacing.lg),
            // Hero card
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A56DB), AppColors.primary],
                ),
                borderRadius: AppRadius.extraLarge,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: AppRadius.large,
                    ),
                    child: const Icon(
                      Icons.engineering_rounded,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Langkah 1 dari 4',
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'Data Diri & Keahlian',
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'Isi data lengkap agar profil mudah ditemukan customer.',
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Form card
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.extraLarge,
                border: Border.all(color: const Color(0xFFE0E7FF)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(label: 'Informasi Pribadi', icon: Icons.person_outline_rounded),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    controller: _namaCtrl,
                    label: 'Nama Lengkap',
                    hintText: 'Sesuai KTP',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Nama lengkap wajib diisi' : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    controller: _hpCtrl,
                    label: 'Nomor HP Aktif',
                    hintText: '08xxxxxxxxxx',
                    prefixIcon: const Icon(Icons.phone_android_rounded),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Nomor HP wajib diisi';
                      if (v.trim().length < 10) return 'Nomor HP tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    controller: _kotaCtrl,
                    label: 'Kota / Kabupaten',
                    hintText: 'Contoh: Bandung',
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Kota wajib diisi' : null,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _SectionLabel(label: 'Keahlian & Pengalaman', icon: Icons.build_outlined),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    controller: _keahlianCtrl,
                    label: 'Bidang Keahlian',
                    hintText: 'Contoh: Printer, Komputer, Laptop',
                    prefixIcon: const Icon(Icons.handyman_rounded),
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Keahlian wajib diisi' : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    controller: _pengalamanCtrl,
                    label: 'Pengalaman Kerja',
                    hintText: 'Ceritakan pengalaman servis Anda...',
                    prefixIcon: const Icon(Icons.work_history_outlined),
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Pengalaman wajib diisi' : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Info strip
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.infoContainer,
                borderRadius: AppRadius.large,
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: AppColors.infoText, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Semua field wajib diisi. Data digunakan untuk proses verifikasi admin.',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.infoText,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TechnicianUploadDocumentScreen extends ConsumerStatefulWidget {
  const TechnicianUploadDocumentScreen({required this.profilePhoto, super.key});
  final bool profilePhoto;
  @override
  ConsumerState<TechnicianUploadDocumentScreen> createState() =>
      _TechnicianUploadDocumentScreenState();
}

class _TechnicianUploadDocumentScreenState
    extends ConsumerState<TechnicianUploadDocumentScreen> {
  void _submit() {
    final images = ref.read(technicianImageProvider);
    final hasFile = widget.profilePhoto
        ? images.profileBytes != null
        : images.ktpBytes != null;
    if (!hasFile) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.profilePhoto
                ? 'Foto profil wajib diunggah'
                : 'Foto KTP wajib diunggah',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    context.go(
      widget.profilePhoto
          ? AppRoutes.technicianBankInfo
          : AppRoutes.technicianUploadProfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(technicianImageProvider);
    final selectedBytes =
        widget.profilePhoto ? images.profileBytes : images.ktpBytes;
    final textTheme = Theme.of(context).textTheme;
    final stepIndex = widget.profilePhoto ? 2 : 1;
    final gradientColors = widget.profilePhoto
        ? const [Color(0xFF7C3AED), Color(0xFF9F7AEA)]
        : const [Color(0xFFB45309), Color(0xFFD97706)];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FF),
        title: Text(widget.profilePhoto ? 'Upload Foto Profil' : 'Upload KTP'),
        elevation: 0,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: widget.profilePhoto ? 'Lanjut ke Rekening' : 'Lanjut ke Foto Profil',
          icon: Icons.arrow_forward_rounded,
          onPressed: _submit,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          MobileFlowStepper(
            steps: const ['Data Diri', 'KTP', 'Foto', 'Rekening'],
            currentStep: stepIndex,
          ),
          const SizedBox(height: AppSpacing.lg),
          // Hero card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: AppRadius.extraLarge,
              boxShadow: [
                BoxShadow(
                  color: gradientColors.last.withValues(alpha: 0.28),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: AppRadius.large,
                  ),
                  child: Icon(
                    widget.profilePhoto
                        ? Icons.portrait_rounded
                        : Icons.credit_card_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Langkah ${stepIndex + 1} dari 4',
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        widget.profilePhoto ? 'Foto Profil Teknisi' : 'Verifikasi Identitas KTP',
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        widget.profilePhoto
                            ? 'Foto ini tampil ke customer saat Anda memberi penawaran.'
                            : 'KTP hanya dilihat admin untuk verifikasi identitas.',
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.extraLarge,
              border: Border.all(color: const Color(0xFFE0E7FF)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                ImageUploadField(
                  title: widget.profilePhoto ? 'Foto Profil Teknisi' : 'Foto KTP',
                  description: widget.profilePhoto
                      ? 'Foto ini akan tampil pada penawaran dan dapat dilihat pelanggan.'
                      : 'Foto KTP hanya digunakan admin untuk proses verifikasi.',
                  bytes: selectedBytes,
                  aspectRatio: widget.profilePhoto ? 1 : 16 / 10,
                  onSelected: (bytes) {
                    final controller = ref.read(technicianImageProvider.notifier);
                    if (widget.profilePhoto) {
                      controller.setProfile(bytes);
                    } else {
                      controller.setKtp(bytes);
                    }
                  },
                ),
                if (selectedBytes == null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.errorContainer,
                      borderRadius: AppRadius.medium,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline_rounded,
                            color: AppColors.errorText, size: 16),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Foto wajib diunggah sebelum melanjutkan',
                          style: textTheme.labelSmall?.copyWith(
                              color: AppColors.errorText),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.infoContainer,
              borderRadius: AppRadius.large,
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, color: AppColors.infoText, size: 18),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    widget.profilePhoto
                        ? 'Gunakan foto wajah yang jelas dan profesional.'
                        : 'Pastikan seluruh data KTP terbaca dengan jelas.',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.infoText,
                      height: 1.4,
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

class TechnicianBankInformationScreen extends ConsumerStatefulWidget {
  const TechnicianBankInformationScreen({super.key});
  @override
  ConsumerState<TechnicianBankInformationScreen> createState() =>
      _TechnicianBankInformationScreenState();
}

class _TechnicianBankInformationScreenState
    extends ConsumerState<TechnicianBankInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankCtrl = TextEditingController();
  final _rekeningCtrl = TextEditingController();
  final _pemilikCtrl = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _bankCtrl.dispose();
    _rekeningCtrl.dispose();
    _pemilikCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda harus menyetujui pernyataan kebenaran data.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      context.go(AppRoutes.technicianVerification);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FF),
        title: const Text('Informasi Rekening'),
        elevation: 0,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: 'Kirim Pengajuan',
          icon: Icons.send_rounded,
          onPressed: _submit,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            MobileFlowStepper(
              steps: const ['Data Diri', 'KTP', 'Foto', 'Rekening'],
              currentStep: 3,
            ),
            const SizedBox(height: AppSpacing.lg),
            // Hero card
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF065F46), Color(0xFF059669)],
                ),
                borderRadius: AppRadius.extraLarge,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withValues(alpha: 0.25),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: AppRadius.large,
                    ),
                    child: const Icon(
                      Icons.account_balance_rounded,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Langkah terakhir!',
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'Rekening Pencairan Dana',
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'Pastikan rekening aktif dan atas nama sendiri.',
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.extraLarge,
                border: Border.all(color: const Color(0xFFE0E7FF)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(label: 'Detail Rekening Bank', icon: Icons.credit_card_outlined),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    controller: _bankCtrl,
                    label: 'Nama Bank',
                    hintText: 'Contoh: BCA, BNI, Mandiri',
                    prefixIcon: const Icon(Icons.account_balance_outlined),
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Nama bank wajib diisi' : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    controller: _rekeningCtrl,
                    label: 'Nomor Rekening',
                    hintText: 'Masukkan nomor rekening',
                    prefixIcon: const Icon(Icons.pin_outlined),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Nomor rekening wajib diisi';
                      if (v.trim().length < 6) return 'Nomor rekening tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    controller: _pemilikCtrl,
                    label: 'Nama Pemilik Rekening',
                    hintText: 'Sesuai buku tabungan',
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    textInputAction: TextInputAction.done,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Nama pemilik wajib diisi' : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Agreement
            GestureDetector(
              onTap: () => setState(() => _agreed = !_agreed),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: _agreed
                      ? AppColors.successContainer
                      : AppColors.surfaceMuted,
                  borderRadius: AppRadius.large,
                  border: Border.all(
                    color: _agreed
                        ? AppColors.success.withValues(alpha: 0.4)
                        : AppColors.border,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox.square(
                      dimension: 28,
                      child: Checkbox(
                        value: _agreed,
                        onChanged: (v) => setState(() => _agreed = v ?? false),
                        activeColor: AppColors.success,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Saya menyatakan data rekening di atas adalah benar dan atas nama saya sendiri.',
                        style: textTheme.bodySmall?.copyWith(
                          color: _agreed
                              ? AppColors.successText
                              : AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.warningContainer,
                borderRadius: AppRadius.large,
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppColors.warningText, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Rekening yang salah dapat menyebabkan kegagalan pencairan dana.',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.warningText,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
  });
  final String title, button;
  final List<Widget> children;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF5F7FF),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF5F7FF),
      title: Text(title),
      elevation: 0,
    ),
    bottomNavigationBar: SafeArea(
      minimum: const EdgeInsets.all(AppSpacing.screenPadding),
      child: PrimaryButton(label: button, onPressed: onPressed),
    ),
    body: ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      children: children,
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: AppRadius.small,
          ),
          child: Icon(icon, color: AppColors.primary, size: 16),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
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

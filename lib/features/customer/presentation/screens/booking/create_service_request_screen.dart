import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/image_upload_field.dart';
import '../../../../../shared/widgets/safe_image.dart';
import '../../../data/customer_dummy_data.dart';

class CreateServiceRequestScreen extends ConsumerStatefulWidget {
  const CreateServiceRequestScreen({required this.serviceId, super.key});

  final String serviceId;

  @override
  ConsumerState<CreateServiceRequestScreen> createState() =>
      _CreateServiceRequestScreenState();
}

class _CreateServiceRequestScreenState
    extends ConsumerState<CreateServiceRequestScreen> {
  Uint8List? _damagePhoto;

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(customerServicesProvider);
    final service = services.firstWhere(
      (item) => item.id == widget.serviceId,
      orElse: () => services.first,
    );
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Buat Permintaan')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: 'Kirim Request',
          icon: Icons.send_rounded,
          onPressed: () => context.go(AppRoutes.customerRequestSuccess),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          const MobileFlowStepper(
            steps: ['Detail', 'Penawaran', 'Bayar', 'Lacak'],
            currentStep: 0,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Ceritakan kebutuhan Anda',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Informasi yang lengkap membantu teknisi memberi estimasi yang tepat.',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3FF),
              borderRadius: AppRadius.large,
              border: Border.all(color: const Color(0xFFC5CADF)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.medium,
                  child: SafeImage(
                    assetPath: service.imageAsset,
                    width: 64,
                    height: 64,
                    fallbackIcon: service.icon,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.title, style: textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'Estimasi mulai ${formatRupiah(service.basePrice)}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          CustomTextField(
            label: 'Lokasi Servis',
            hintText: 'Jl. Merdeka No. 12, Bandung',
            prefixIcon: const Icon(Icons.location_on_outlined),
            suffixIcon: IconButton(
              tooltip: 'Pilih lokasi',
              onPressed: () => context.push(AppRoutes.customerLocation),
              icon: const Icon(Icons.map_outlined),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.md),
          const CustomTextField(
            label: 'Jadwal Kunjungan',
            hintText: 'Hari ini, 14:00',
            prefixIcon: Icon(Icons.event_rounded),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.md),
          const CustomTextField(
            label: 'Deskripsi Masalah',
            hintText: 'Ceritakan kerusakan perangkat secara singkat',
            prefixIcon: Icon(Icons.notes_rounded),
            maxLines: 4,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: AppSpacing.lg),
          ImageUploadField(
            title: 'Foto Kerusakan',
            description:
                'Tambahkan foto yang jelas agar teknisi dapat memberi estimasi lebih akurat.',
            bytes: _damagePhoto,
            onSelected: (bytes) => setState(() => _damagePhoto = bytes),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.infoContainer,
              borderRadius: AppRadius.medium,
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, color: AppColors.infoText),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Permintaan akan dikirim ke teknisi terverifikasi di sekitar lokasi Anda.',
                    style: TextStyle(color: AppColors.infoText),
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

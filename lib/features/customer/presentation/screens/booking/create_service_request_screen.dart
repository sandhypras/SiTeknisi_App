import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/utils/auth_guard.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../shared/widgets/mobile_flow_stepper.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/image_upload_field.dart';
import '../../../../../shared/widgets/safe_image.dart';
import '../../../data/customer_dummy_data.dart';
import '../../../data/service_request_repository.dart';
import '../../../data/service_mapper.dart';
import '../../providers/service_request_providers.dart';

class CreateServiceRequestScreen extends ConsumerStatefulWidget {
  const CreateServiceRequestScreen({required this.serviceId, super.key});

  final String serviceId;

  @override
  ConsumerState<CreateServiceRequestScreen> createState() =>
      _CreateServiceRequestScreenState();
}

class _CreateServiceRequestScreenState
    extends ConsumerState<CreateServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _scheduleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Uint8List? _damagePhoto;

  @override
  void dispose() {
    _locationController.dispose();
    _scheduleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(customerServicesProvider);
    final service = services.firstWhere(
      (item) => item.id == widget.serviceId,
      orElse: () => services.first,
    );
    final textTheme = Theme.of(context).textTheme;
    final isLoading = ref.watch(serviceRequestLoadingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Buat Permintaan')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: 'Kirim Request',
          icon: Icons.send_rounded,
          isLoading: isLoading,
          onPressed: isLoading ? null : () => _submitRequest(context, service),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
            controller: _locationController,
            label: 'Lokasi Servis',
            hintText: 'Jl. Merdeka No. 12, Bandung',
            prefixIcon: const Icon(Icons.location_on_outlined),
            suffixIcon: IconButton(
              tooltip: 'Pilih lokasi',
              onPressed: () => context.push(AppRoutes.customerLocation),
              icon: const Icon(Icons.map_outlined),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Lokasi servis harus diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          CustomTextField(
            controller: _scheduleController,
            label: 'Jadwal Kunjungan',
            hintText: 'Hari ini, 14:00',
            prefixIcon: const Icon(Icons.event_rounded),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.md),
          CustomTextField(
            controller: _descriptionController,
            label: 'Deskripsi Masalah',
            hintText: 'Ceritakan kerusakan perangkat secara singkat',
            prefixIcon: const Icon(Icons.notes_rounded),
            maxLines: 4,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Deskripsi masalah harus diisi';
              }
              if (value.trim().length < 10) {
                return 'Deskripsi minimal 10 karakter';
              }
              return null;
            },
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
      ),
    );
  }

  Future<void> _submitRequest(
    BuildContext context,
    CustomerService service,
  ) async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check authentication - simplified
    ref.checkAuthBeforeAction(
      context,
      returnUrl: '/customer/request/${widget.serviceId}',
      onAuthenticated: () {},
    );

    if (!context.mounted) return;

    final storageService = ref.read(storageServiceProvider);
    final repository = ref.read(serviceRequestRepositoryProvider);

    if (repository == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap login terlebih dahulu'),
            backgroundColor: AppColors.errorText,
          ),
        );
      }
      return;
    }

    // Start loading
    ref.read(serviceRequestLoadingProvider.notifier).setLoading(true);

    try {
      // Get real service ID from database
      final serviceMapper = ServiceMapper(repository.client);
      final realServiceId = await serviceMapper.getServiceIdByDummyId(
        widget.serviceId,
      );

      if (realServiceId == null) {
        throw ServiceRequestException(
          'Layanan tidak ditemukan di database. Pastikan services sudah di-seed.',
        );
      }

      // Upload photo if exists
      String? photoUrl;
      if (_damagePhoto != null && storageService != null) {
        photoUrl = await storageService.uploadRequestPhoto(
          bytes: _damagePhoto!,
          fileName: 'damage_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      }

      // Create service request
      final request = await repository.createRequest(
        serviceId: realServiceId,
        title: service.title,
        description: _descriptionController.text.trim(),
        address: _locationController.text.trim(),
        photoUrl: photoUrl,
        preferredSchedule: _scheduleController.text.isNotEmpty
            ? DateTime.now() // TODO: Parse schedule properly
            : null,
      );

      // Success
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permintaan servis berhasil dibuat!'),
            backgroundColor: AppColors.success,
          ),
        );
        // Navigate to success screen with request ID
        context.go(
          '${AppRoutes.customerRequestSuccess}?requestId=${request.id}',
        );
      }
    } on ServiceRequestException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.errorText,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: $e'),
            backgroundColor: AppColors.errorText,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        ref.read(serviceRequestLoadingProvider.notifier).setLoading(false);
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../data/customer_dummy_data.dart';

class CreateServiceRequestScreen extends ConsumerWidget {
  const CreateServiceRequestScreen({required this.serviceId, super.key});

  final String serviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(customerServicesProvider);
    final service = services.firstWhere(
      (item) => item.id == serviceId,
      orElse: () => services.first,
    );
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Request Service')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenPadding),
        child: PrimaryButton(
          label: 'Kirim Request',
          icon: Icons.send_rounded,
          onPressed: () => context.go(AppRoutes.customerOffers),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3FF),
              borderRadius: AppRadius.large,
              border: Border.all(color: const Color(0xFFC5CADF)),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Icon(service.icon, color: AppColors.surface),
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
          const CustomTextField(
            label: 'Lokasi Servis',
            hintText: 'Jl. Merdeka No. 12, Bandung',
            prefixIcon: Icon(Icons.location_on_outlined),
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
          Text('Foto Kerusakan', style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: 128,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.large,
              border: Border.all(color: AppColors.border),
            ),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Upload foto masih dummy.')),
                );
              },
              borderRadius: AppRadius.large,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: AppColors.primary,
                    size: 34,
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text('Upload Damage Photo'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

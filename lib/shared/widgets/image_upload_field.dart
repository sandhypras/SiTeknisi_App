import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import 'safe_image.dart';

class ImageUploadField extends StatelessWidget {
  const ImageUploadField({
    required this.title,
    required this.description,
    required this.onSelected,
    super.key,
    this.bytes,
    this.aspectRatio = 16 / 10,
  });

  final String title;
  final String description;
  final Uint8List? bytes;
  final double aspectRatio;
  final ValueChanged<Uint8List> onSelected;

  Future<void> _pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 82,
        maxWidth: 1600,
      );
      if (image == null) return;

      final selectedBytes = await image.readAsBytes();
      if (selectedBytes.isEmpty) {
        throw const FormatException('File gambar kosong.');
      }
      onSelected(selectedBytes);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gambar tidak dapat dibaca. Pilih file JPG atau PNG.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = bytes != null && bytes!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(
          description,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        AspectRatio(
          aspectRatio: aspectRatio,
          child: Material(
            color: AppColors.surface,
            borderRadius: AppRadius.large,
            child: InkWell(
              onTap: () => _pickImage(context),
              borderRadius: AppRadius.large,
              child: ClipRRect(
                borderRadius: AppRadius.large,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                  ),
                  child: hasImage
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            SafeImage(bytes: bytes),
                            Positioned(
                              right: AppSpacing.sm,
                              bottom: AppSpacing.sm,
                              child: FilledButton.tonalIcon(
                                onPressed: () => _pickImage(context),
                                icon: const Icon(Icons.edit_rounded),
                                label: const Text('Ganti'),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 52,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            const Text(
                              'Pilih gambar dari galeri',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

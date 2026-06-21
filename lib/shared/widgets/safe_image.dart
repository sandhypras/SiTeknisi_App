import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SafeImage extends StatelessWidget {
  const SafeImage({
    super.key,
    this.bytes,
    this.assetPath,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallbackIcon = Icons.image_outlined,
  });

  final Uint8List? bytes;
  final String? assetPath;
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final validAsset = assetPath?.trim().isNotEmpty ?? false;
    final validUrl = imageUrl?.trim().isNotEmpty ?? false;

    if (bytes != null && bytes!.isNotEmpty) {
      return Image.memory(
        bytes!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _fallback(),
      );
    }
    if (validAsset) {
      return Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _fallback(),
      );
    }
    if (validUrl) {
      return Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _fallback(),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    return SizedBox(
      width: width,
      height: height,
      child: ColoredBox(
        color: AppColors.primaryLight,
        child: Icon(fallbackIcon, color: AppColors.primary),
      ),
    );
  }
}

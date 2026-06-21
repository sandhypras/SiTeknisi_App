import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siteknisi_apps/features/technician/presentation/providers/technician_image_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('technician images are stored and exposed to customer screens', () {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(technicianImageProvider).profileBytes, isNull);

    final profile = Uint8List.fromList([1, 2, 3]);
    final offer = Uint8List.fromList([4, 5, 6]);
    final controller = container.read(technicianImageProvider.notifier);

    controller.setProfile(profile);
    controller.setOffer(offer);

    expect(container.read(technicianImageProvider).profileBytes, profile);
    expect(container.read(technicianImageProvider).offerBytes, offer);
  });

  test('technician images are restored after app restart', () async {
    final profile = Uint8List.fromList([10, 20, 30]);
    SharedPreferences.setMockInitialValues({
      'technician_profile_image': base64Encode(profile),
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(technicianImageProvider);
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(container.read(technicianImageProvider).profileBytes, profile);
  });
}

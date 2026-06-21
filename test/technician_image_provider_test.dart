import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siteknisi_apps/features/technician/presentation/providers/technician_image_provider.dart';

void main() {
  test('technician images are stored and exposed to customer screens', () {
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
}

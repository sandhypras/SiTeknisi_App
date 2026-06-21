import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/customer_home_screen.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/customer_profile_screen.dart';
import 'package:siteknisi_apps/features/technician/presentation/screens/technician_screens.dart';

void main() {
  Future<void> pumpMobileScreen(
    WidgetTester tester,
    Widget screen, {
    Size size = const Size(390, 844),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: screen)));
    await tester.pumpAndSettle();
  }

  testWidgets('customer home has no layout overflow on Android viewport', (
    tester,
  ) async {
    await pumpMobileScreen(
      tester,
      const CustomerHomeScreen(),
      size: const Size(360, 800),
    );

    expect(find.text('Kategori Layanan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('technician dashboard has no layout overflow', (tester) async {
    await pumpMobileScreen(tester, const TechnicianDashboardScreen());

    expect(find.text('Dashboard Teknisi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('customer profile remains tidy on narrow Android viewport', (
    tester,
  ) async {
    await pumpMobileScreen(
      tester,
      const CustomerProfileScreen(),
      size: const Size(360, 800),
    );

    expect(find.text('Profil Saya'), findsOneWidget);
    expect(
      find.text('Akun terverifikasi · Bergabung Mei 2026'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(find.text('Punya keahlian servis?'), 420);
    await tester.pumpAndSettle();

    expect(find.text('Keluar dari akun'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

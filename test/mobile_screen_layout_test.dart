import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/customer_home_screen.dart';
import 'package:siteknisi_apps/features/technician/presentation/screens/technician_screens.dart';

void main() {
  Future<void> pumpMobileScreen(WidgetTester tester, Widget screen) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: screen)));
    await tester.pumpAndSettle();
  }

  testWidgets('customer home has no layout overflow on Android viewport', (
    tester,
  ) async {
    await pumpMobileScreen(tester, const CustomerHomeScreen());

    expect(find.text('Kategori Layanan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('technician dashboard has no layout overflow', (tester) async {
    await pumpMobileScreen(tester, const TechnicianDashboardScreen());

    expect(find.text('Dashboard Teknisi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

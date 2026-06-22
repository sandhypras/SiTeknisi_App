import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/customer_home_screen.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/customer_profile_screen.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/search_service_screen.dart';
import 'package:siteknisi_apps/features/technician/presentation/screens/technician_screens.dart';
import 'package:siteknisi_apps/features/technician/presentation/screens/technician_detail_screens.dart';

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

    expect(find.text('Selamat pagi, Andi'), findsOneWidget);
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

  testWidgets('technician profile remains tidy on narrow Android viewport', (
    tester,
  ) async {
    await pumpMobileScreen(
      tester,
      const TechnicianProfileScreen(),
      size: const Size(360, 800),
    );

    expect(find.text('Andi Kurniawan'), findsOneWidget);
    expect(find.text('Profil profesional 90%'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Beralih ke Mode Customer'), 420);
    await tester.pumpAndSettle();

    expect(find.text('Identitas terverifikasi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('search screen keeps customer bottom navigation visible', (
    tester,
  ) async {
    await pumpMobileScreen(
      tester,
      const SearchServiceScreen(),
      size: const Size(360, 800),
    );

    expect(find.text('Cari Layanan'), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Aktivitas'), findsOneWidget);
    expect(find.text('Cari'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('technician earnings follows payout workflow without overflow', (
    tester,
  ) async {
    await pumpMobileScreen(
      tester,
      const TechnicianEarningsScreen(),
      size: const Size(360, 800),
    );

    expect(find.text('Saldo dapat dicairkan'), findsOneWidget);
    expect(find.text('Tarik Saldo'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(find.text('Transaksi Terbaru'), 420);
    await tester.pumpAndSettle();

    expect(find.text('Servis Laptop'), findsOneWidget);
    expect(find.text('Lihat Semua'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

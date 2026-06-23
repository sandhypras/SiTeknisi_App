import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:siteknisi_apps/core/router/app_router.dart';
import 'package:siteknisi_apps/features/admin/presentation/screens/admin_login_screen.dart';
import 'package:siteknisi_apps/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/customer_home_screen.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/customer_profile_screen.dart';
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

  testWidgets('admin forgot password opens reset screen and returns to admin login', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: AppRoutes.adminLogin,
      routes: [
        GoRoute(
          path: AppRoutes.adminLogin,
          builder: (context, state) => const AdminLoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          builder: (context, state) => ForgotPasswordScreen(
            isAdmin: state.uri.queryParameters['from'] == 'admin',
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(child: MaterialApp.router(routerConfig: router)),
    );

    await tester.tap(find.text('Lupa password?'));
    await tester.pumpAndSettle();

    expect(find.text('Lupa Password Admin'), findsOneWidget);

    await tester.tap(find.text('Kembali ke Login Admin'));
    await tester.pumpAndSettle();

    expect(find.text('Masuk ke Dashboard'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

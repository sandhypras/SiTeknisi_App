import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:siteknisi_apps/core/router/app_router.dart';
import 'package:siteknisi_apps/features/admin/presentation/screens/admin_login_screen.dart';
import 'package:siteknisi_apps/features/auth/presentation/screens/forgot_password_screen.dart';
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

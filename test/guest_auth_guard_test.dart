import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siteknisi_apps/features/customer/presentation/screens/booking/payment_screen.dart';

void main() {
  Future<void> pumpScreen(WidgetTester tester, Widget screen) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: screen)));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'Guest menekan Bayar memunculkan dialog Login Diperlukan',
    (tester) async {
      await pumpScreen(tester, const PaymentScreen());

      await tester.tap(find.widgetWithText(FilledButton, 'Bayar'));
      await tester.pumpAndSettle();

      expect(find.text('Login Diperlukan'), findsOneWidget);
      expect(
        find.text(
          'Anda harus login terlebih dahulu untuk menggunakan fitur ini.',
        ),
        findsOneWidget,
      );
      expect(find.widgetWithText(FilledButton, 'Login'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Daftar'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Nanti'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('menekan Nanti menutup dialog tanpa error', (tester) async {
    await pumpScreen(tester, const PaymentScreen());

    await tester.tap(find.widgetWithText(FilledButton, 'Bayar'));
    await tester.pumpAndSettle();
    expect(find.text('Login Diperlukan'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Nanti'));
    await tester.pumpAndSettle();

    expect(find.text('Login Diperlukan'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

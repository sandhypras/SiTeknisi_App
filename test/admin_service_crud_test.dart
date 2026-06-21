import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siteknisi_apps/features/admin/data/admin_mock_store.dart';
import 'package:siteknisi_apps/features/admin/presentation/screens/admin_dashboard_screen.dart';

void main() {
  test('admin dapat menambah, mengubah, dan menghapus layanan', () {
    final store = AdminMockStore.instance;
    final initialCount = store.records('services').length;
    const serviceName = 'Servis Printer Uji CRUD';

    store.create('services', {
      'name': serviceName,
      'category': 'Printer',
      'description': 'Data sementara untuk pengujian CRUD',
      'basePrice': '125.000',
      'estimatedTime': '1-2 jam',
      'imageUrl': 'assets/images/categories/printer.jpg',
      'status': 'Aktif',
    });

    final created = store.records('services').first;
    expect(store.records('services'), hasLength(initialCount + 1));
    expect(created.values['name'], serviceName);

    store.update('services', created.id, {
      ...created.values,
      'basePrice': '135.000',
      'status': 'Nonaktif',
    });

    final updated = store
        .records('services')
        .firstWhere((record) => record.id == created.id);
    expect(updated.values['basePrice'], '135.000');
    expect(updated.values['status'], 'Nonaktif');

    store.delete('services', created.id);
    expect(store.records('services'), hasLength(initialCount));
    expect(
      store.records('services').any((record) => record.id == created.id),
      isFalse,
    );
  });

  testWidgets('form layanan menampilkan seluruh data katalog', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: AdminDashboardScreen(section: 'services')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Manajemen Layanan'), findsOneWidget);
    expect(find.text('Servis Printer'), findsOneWidget);

    await tester.tap(find.text('Tambah Layanan'));
    await tester.pumpAndSettle();

    expect(find.text('Kategori perangkat'), findsWidgets);
    expect(find.text('Deskripsi layanan'), findsWidgets);
    expect(find.text('Harga mulai'), findsWidgets);
    expect(find.text('Estimasi pengerjaan'), findsWidgets);
    expect(find.text('URL atau path gambar'), findsWidgets);
    expect(find.text('Status'), findsWidgets);
    expect(find.text('Simpan'), findsOneWidget);
  });
}

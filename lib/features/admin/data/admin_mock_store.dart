import 'package:flutter/foundation.dart';

class AdminRecord {
  AdminRecord({required this.id, required Map<String, String> values})
    : values = Map<String, String>.from(values);

  final String id;
  final Map<String, String> values;

  AdminRecord copyWith({Map<String, String>? values}) {
    return AdminRecord(id: id, values: values ?? this.values);
  }
}

class AdminMockStore extends ChangeNotifier {
  AdminMockStore._();

  static final AdminMockStore instance = AdminMockStore._();

  int _sequence = 1000;

  final Map<String, List<AdminRecord>> _records = {
    'users': [
      AdminRecord(
        id: 'USR-001',
        values: {
          'name': 'Budi Santoso',
          'contact': 'budi@email.com',
          'role': 'Customer',
          'joined': '12 Jun 2026',
          'status': 'Aktif',
        },
      ),
      AdminRecord(
        id: 'USR-002',
        values: {
          'name': 'Andi Kurniawan',
          'contact': '0812 4455 9012',
          'role': 'Teknisi',
          'joined': '10 Jun 2026',
          'status': 'Aktif',
        },
      ),
      AdminRecord(
        id: 'USR-003',
        values: {
          'name': 'Rina Amelia',
          'contact': 'rina@email.com',
          'role': 'Customer',
          'joined': '08 Jun 2026',
          'status': 'Nonaktif',
        },
      ),
    ],
    'technicians': [
      AdminRecord(
        id: 'TEC-021',
        values: {
          'name': 'Dimas Pratama',
          'expertise': 'Printer & Komputer',
          'experience': '5 tahun',
          'submitted': 'Hari ini',
          'bank': 'BCA • 7620192231',
          'profilePhotoUrl': '',
          'ktpPhotoUrl': '',
          'status': 'Menunggu',
        },
      ),
      AdminRecord(
        id: 'TEC-022',
        values: {
          'name': 'Sari Dewi',
          'expertise': 'Laptop & Komputer',
          'experience': '3 tahun',
          'submitted': 'Kemarin',
          'bank': 'BRI • 11820094233',
          'profilePhotoUrl': '',
          'ktpPhotoUrl': '',
          'status': 'Menunggu',
        },
      ),
      AdminRecord(
        id: 'TEC-023',
        values: {
          'name': 'Agus Setiawan',
          'expertise': 'Printer & Laptop',
          'experience': '7 tahun',
          'submitted': '16 Jun 2026',
          'bank': 'Mandiri • 132001902182',
          'profilePhotoUrl': '',
          'ktpPhotoUrl': '',
          'status': 'Disetujui',
        },
      ),
    ],
    'services': [
      AdminRecord(
        id: 'SRV-001',
        values: {
          'name': 'Servis Printer',
          'description': 'Perawatan dan perbaikan printer',
          'technicians': '48',
          'created': '02 Mei 2026',
          'status': 'Aktif',
        },
      ),
      AdminRecord(
        id: 'SRV-002',
        values: {
          'name': 'Servis Komputer',
          'description': 'Perbaikan semua tipe mesin',
          'technicians': '32',
          'created': '02 Mei 2026',
          'status': 'Aktif',
        },
      ),
      AdminRecord(
        id: 'SRV-003',
        values: {
          'name': 'Servis Laptop',
          'description': 'Hardware dan software',
          'technicians': '41',
          'created': '03 Mei 2026',
          'status': 'Aktif',
        },
      ),
    ],
    'bookings': [
      AdminRecord(
        id: 'BKG-260618-041',
        values: {
          'customer': 'Budi Santoso',
          'technician': 'Andi Kurniawan',
          'service': 'Servis Laptop',
          'payment': 'Lunas',
          'status': 'Dikerjakan',
        },
      ),
      AdminRecord(
        id: 'BKG-260618-038',
        values: {
          'customer': 'Rina Amelia',
          'technician': 'Sari Dewi',
          'service': 'Servis Laptop',
          'payment': 'Lunas',
          'status': 'Menuju Lokasi',
        },
      ),
      AdminRecord(
        id: 'BKG-260617-129',
        values: {
          'customer': 'Fajar Putra',
          'technician': 'Dimas Pratama',
          'service': 'Servis Printer',
          'payment': 'Pending',
          'status': 'Menunggu',
        },
      ),
    ],
    'payments': [
      AdminRecord(
        id: 'MT-932891',
        values: {
          'booking': 'BKG-260618-041',
          'method': 'QRIS',
          'amount': 'Rp350.000',
          'commission': 'Rp35.000',
          'status': 'Lunas',
        },
      ),
      AdminRecord(
        id: 'MT-932874',
        values: {
          'booking': 'BKG-260618-038',
          'method': 'BCA VA',
          'amount': 'Rp475.000',
          'commission': 'Rp47.500',
          'status': 'Lunas',
        },
      ),
      AdminRecord(
        id: 'MT-932810',
        values: {
          'booking': 'BKG-260617-129',
          'method': 'GoPay',
          'amount': 'Rp225.000',
          'commission': 'Rp22.500',
          'status': 'Pending',
        },
      ),
    ],
    'invoices': [
      AdminRecord(
        id: 'INV-20260618-041',
        values: {
          'booking': 'BKG-260618-041',
          'customer': 'Budi Santoso',
          'technician': 'Andi Kurniawan',
          'total': 'Rp350.000',
          'status': 'Terbit',
        },
      ),
      AdminRecord(
        id: 'INV-20260618-038',
        values: {
          'booking': 'BKG-260618-038',
          'customer': 'Rina Amelia',
          'technician': 'Sari Dewi',
          'total': 'Rp475.000',
          'status': 'Terbit',
        },
      ),
    ],
  };

  List<AdminRecord> records(String section) =>
      List<AdminRecord>.unmodifiable(_records[section] ?? const []);

  void create(String section, Map<String, String> values) {
    final prefix = switch (section) {
      'users' => 'USR',
      'technicians' => 'TEC',
      'services' => 'SRV',
      'bookings' => 'BKG',
      'payments' => 'MT',
      'invoices' => 'INV',
      _ => 'REC',
    };
    _sequence++;
    _records
        .putIfAbsent(section, () => [])
        .insert(0, AdminRecord(id: '$prefix-$_sequence', values: values));
    notifyListeners();
  }

  void update(String section, String id, Map<String, String> values) {
    final list = _records[section];
    if (list == null) return;
    final index = list.indexWhere((record) => record.id == id);
    if (index == -1) return;
    list[index] = list[index].copyWith(values: values);
    notifyListeners();
  }

  void delete(String section, String id) {
    _records[section]?.removeWhere((record) => record.id == id);
    notifyListeners();
  }

  void setStatus(String section, String id, String status) {
    final record = _records[section]
        ?.where((item) => item.id == id)
        .firstOrNull;
    if (record == null) return;
    update(section, id, {...record.values, 'status': status});
  }
}

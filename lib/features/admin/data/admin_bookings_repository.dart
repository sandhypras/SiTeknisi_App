import 'package:supabase_flutter/supabase_flutter.dart';

class AdminBooking {
  final String id;
  final String customerId;
  final String customerName;
  final String? technicianId;
  final String? technicianName;
  final String serviceName;
  final String status;
  final String paymentStatus;
  final DateTime createdAt;
  
  AdminBooking({
    required this.id,
    required this.customerId,
    required this.customerName,
    this.technicianId,
    this.technicianName,
    required this.serviceName,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
  });
  
  factory AdminBooking.fromJson(Map<String, dynamic> json) => AdminBooking(
    id: json['id'] as String,
    customerId: json['customer_id'] as String,
    customerName: json['customer_name'] as String? ?? 'N/A',
    technicianId: json['technician_id'] as String?,
    technicianName: json['technician_name'] as String?,
    serviceName: json['service_name'] as String? ?? 'N/A',
    status: _mapStatus(json['status'] as String?),
    paymentStatus: _mapPaymentStatus(json['payment_status'] as String?),
    createdAt: DateTime.parse(json['created_at'] as String),
  );
  
  static String _mapStatus(String? dbStatus) {
    switch (dbStatus) {
      case 'pending': return 'Menunggu';
      case 'on_the_way': return 'Menuju Lokasi';
      case 'in_progress': return 'Dikerjakan';
      case 'completed': return 'Selesai';
      case 'cancelled': return 'Dibatalkan';
      default: return 'Menunggu';
    }
  }
  
  static String _mapPaymentStatus(String? status) {
    switch (status) {
      case 'pending': return 'Pending';
      case 'paid': return 'Lunas';
      case 'failed': return 'Gagal';
      default: return 'Pending';
    }
  }
}

class AdminBookingsRepository {
  final SupabaseClient _client;
  
  AdminBookingsRepository(this._client);
  
  Future<List<AdminBooking>> getBookings({String? status}) async {
    var query = _client
        .from('service_requests')
        .select('''
          *,
          customer:profiles!customer_id(full_name),
          technician:profiles!technician_id(full_name),
          service:services(name)
        ''');
    
    if (status != null && status != 'Semua') {
      final dbStatus = _statusToDb(status);
      query = query.eq('status', dbStatus);
    }
    
    final response = await query.order('created_at', ascending: false);
    return (response as List).map((json) {
      return AdminBooking.fromJson({
        ...json,
        'customer_name': json['customer']?['full_name'],
        'technician_name': json['technician']?['full_name'],
        'service_name': json['service']?['name'],
      });
    }).toList();
  }
  
  static String _statusToDb(String uiStatus) {
    switch (uiStatus) {
      case 'Menunggu': return 'pending';
      case 'Menuju Lokasi': return 'on_the_way';
      case 'Dikerjakan': return 'in_progress';
      case 'Selesai': return 'completed';
      case 'Dibatalkan': return 'cancelled';
      default: return 'pending';
    }
  }
}

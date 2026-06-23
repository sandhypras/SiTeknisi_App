import 'package:supabase_flutter/supabase_flutter.dart';

class TechnicianApplication {
  final String id;
  final String userId;
  final String fullName;
  final String expertise;
  final String experience;
  final String? bankAccount;
  final DateTime submittedAt;
  final String status;
  
  TechnicianApplication({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.expertise,
    required this.experience,
    this.bankAccount,
    required this.submittedAt,
    required this.status,
  });
  
  factory TechnicianApplication.fromJson(Map<String, dynamic> json) => TechnicianApplication(
    id: json['user_id'] as String,
    userId: json['user_id'] as String,
    fullName: json['full_name'] as String? ?? 'N/A',
    expertise: json['specialization'] as String? ?? '-',
    experience: json['experience_years']?.toString() ?? '0',
    bankAccount: json['bank_account'] as String?,
    submittedAt: DateTime.parse(json['created_at'] as String),
    status: _mapStatus(json['verification_status'] as String?),
  );
  
  static String _mapStatus(String? dbStatus) {
    switch (dbStatus) {
      case 'pending': return 'Menunggu';
      case 'approved': return 'Disetujui';
      case 'rejected': return 'Ditolak';
      default: return 'Menunggu';
    }
  }
  
  static String _mapStatusToDb(String uiStatus) {
    switch (uiStatus) {
      case 'Menunggu': return 'pending';
      case 'Disetujui': return 'approved';
      case 'Ditolak': return 'rejected';
      default: return 'pending';
    }
  }
}

class AdminTechniciansRepository {
  final SupabaseClient _client;
  
  AdminTechniciansRepository(this._client);
  
  Future<List<TechnicianApplication>> getTechnicians({String? status}) async {
    var query = _client.from('technician_profiles').select('*, profiles!inner(full_name)');
    
    if (status != null && status != 'Semua') {
      final dbStatus = TechnicianApplication._mapStatusToDb(status);
      query = query.eq('verification_status', dbStatus);
    }
    
    final response = await query.order('created_at', ascending: false);
    return (response as List).map((json) {
      return TechnicianApplication.fromJson({
        ...json,
        'full_name': json['profiles']['full_name'],
      });
    }).toList();
  }
  
  Future<void> updateTechnicianStatus(String userId, String status) async {
    final dbStatus = TechnicianApplication._mapStatusToDb(status);
    await _client.from('technician_profiles').update({
      'verification_status': dbStatus,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('user_id', userId);
  }
}

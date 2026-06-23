import 'package:supabase_flutter/supabase_flutter.dart';

class AdminUser {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String role;
  final DateTime createdAt;
  
  AdminUser({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    required this.role,
    required this.createdAt,
  });
  
  factory AdminUser.fromJson(Map<String, dynamic> json) => AdminUser(
    id: json['id'] as String,
    email: json['email'] as String,
    fullName: json['full_name'] as String,
    phone: json['phone'] as String?,
    role: json['role'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
  );
}

class AdminUsersRepository {
  final SupabaseClient _client;
  
  AdminUsersRepository(this._client);
  
  Future<List<AdminUser>> getUsers({String? status}) async {
    var query = _client.from('profiles').select();
    
    if (status != null && status != 'Semua') {
      // Map status UI ke database
      final isActive = status == 'Aktif';
      query = query.eq('is_active', isActive);
    }
    
    final response = await query.order('created_at', ascending: false);
    return (response as List).map((json) => AdminUser.fromJson(json)).toList();
  }
  
  Future<void> updateUserStatus(String userId, bool isActive) async {
    await _client.from('profiles').update({
      'is_active': isActive,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }
  
  Future<void> deleteUser(String userId) async {
    await _client.from('profiles').delete().eq('id', userId);
  }
}

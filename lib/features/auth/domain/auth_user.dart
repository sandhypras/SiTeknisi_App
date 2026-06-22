/// Role of an authenticated user, mirroring the `user_role` enum in
/// supabase/migrations/20260622083000_initial_schema.sql.
enum UserRole {
  customer,
  technician,
  admin;

  static UserRole fromName(String? value) {
    switch (value) {
      case 'technician':
        return UserRole.technician;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.customer;
    }
  }
}

/// Lightweight view of the signed-in user combining the Supabase auth identity
/// with the `profiles` row.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.phone,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final UserRole role;
  final String? phone;
  final String? avatarUrl;
}

import 'package:flutter_test/flutter_test.dart';
import 'package:siteknisi_apps/features/auth/domain/auth_user.dart';

void main() {
  group('UserRole.fromName', () {
    test('maps known role names', () {
      expect(UserRole.fromName('customer'), UserRole.customer);
      expect(UserRole.fromName('technician'), UserRole.technician);
      expect(UserRole.fromName('admin'), UserRole.admin);
    });

    test('falls back to customer for null or unknown values', () {
      expect(UserRole.fromName(null), UserRole.customer);
      expect(UserRole.fromName(''), UserRole.customer);
      expect(UserRole.fromName('superuser'), UserRole.customer);
    });
  });
}

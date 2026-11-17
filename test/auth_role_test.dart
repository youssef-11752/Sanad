import 'package:flutter_test/flutter_test.dart';
import 'package:sanad/features/auth/data/model/user_role.dart';

void main() {
  // Unit tests for turning raw role labels into the two app roles.
  group('AuthRole.normalize', () {
    // Database role labels may be stored in English or in the UI's Arabic wording.
    test('maps customer labels from user_types to customer', () {
      expect(AuthRole.normalize('Customer'), 'customer');
      expect(AuthRole.normalize(' client '), 'customer');
      expect(AuthRole.normalize('محتاج خدمة'), 'customer');
      expect(AuthRole.normalize('محتاج خدمه'), 'customer');
      expect(AuthRole.normalize('عميل'), 'customer');
    });

    test('maps provider labels from user_types to provider', () {
      expect(AuthRole.normalize('Provider'), 'provider');
      expect(AuthRole.normalize('Service Provider'), 'provider');
      expect(AuthRole.normalize('مقدم الخدمة'), 'provider');
      expect(AuthRole.normalize('مقدم خدمه'), 'provider');
    });

    // Admin is a separate database role and must not enter either user flow.
    test('rejects unknown roles instead of granting a default role', () {
      expect(AuthRole.normalize('admin'), isNull);
      expect(AuthRole.normalize('administrator'), isNull);
      expect(AuthRole.normalize(null), isNull);
      expect(AuthRole.normalize(''), isNull);
      expect(AuthRole.normalize('   '), isNull);
    });
  });
}

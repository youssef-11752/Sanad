import 'package:flutter_test/flutter_test.dart';
import 'package:sanad/features/auth/data/model/user_role.dart';

void main() {
  group('AuthRole.normalize', () {
    test('maps customer labels from user_types to customer', () {
      expect(AuthRole.normalize('Customer'), 'customer');
      expect(AuthRole.normalize(' client '), 'customer');
      expect(AuthRole.normalize('محتاج خدمة'), 'customer');
      expect(AuthRole.normalize('عميل'), 'customer');
    });

    test('maps provider labels from user_types to provider', () {
      expect(AuthRole.normalize('Provider'), 'provider');
      expect(AuthRole.normalize('Service Provider'), 'provider');
      expect(AuthRole.normalize('مقدم الخدمة'), 'provider');
    });

    test('rejects unknown roles instead of granting a default role', () {
      expect(AuthRole.normalize('admin'), isNull);
      expect(AuthRole.normalize(null), isNull);
      expect(AuthRole.normalize(''), isNull);
    });
  });
}

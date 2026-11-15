abstract final class AuthRole {
  static String? normalize(Object? value) {
    final normalized = value?.toString().trim().toLowerCase();

    switch (normalized) {
      case 'customer':
      case 'client':
      case 'محتاج خدمة':
      case 'محتاج خدمه':
      case 'عميل':
        return 'customer';
      case 'provider':
      case 'service provider':
      case 'مقدم الخدمة':
      case 'مقدم خدمه':
        return 'provider';
      default:
        return null;
    }
  }
}

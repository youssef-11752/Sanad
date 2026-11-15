/// Converts role labels returned by Supabase into the app's two supported roles.
/// Unknown roles (including admin) deliberately remain unsupported by customer/provider login.
abstract final class AuthRole {
  static String? normalize(Object? value) {
    // Normalize case and whitespace before comparing English or Arabic labels.
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
        // Do not silently treat an unknown or admin role as a regular user.
        return null;
    }
  }
}

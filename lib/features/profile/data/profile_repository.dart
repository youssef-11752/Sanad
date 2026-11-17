import 'package:sanad/core/models/profile_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Contract for loading and saving the signed-in user's profile, so screens do not depend on Supabase directly.
abstract interface class ProfileRepository {
  Future<ProfileData> loadCurrentProfile();

  Future<void> saveCustomerProfile(ProfileData profile);
}

/// Supabase-backed implementation. Reads the row from the `users` table and falls back to auth metadata.
class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository({this.client});

  final SupabaseClient? client;

  // use the injected client (handy for tests), otherwise the global Supabase instance
  SupabaseClient get _client => client ?? Supabase.instance.client;

  @override
  Future<ProfileData> loadCurrentProfile() async {
    // profile data only exists for a signed-in user
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('No signed-in user is available.');
    }

    // fetch name and phone from the users table
    final row = await _client
        .from('users')
        .select('full_name, phone')
        .eq('id', user.id)
        .maybeSingle();
    if (row == null) {
      throw StateError('The signed-in user profile was not found.');
    }

    // city and region are stored in auth metadata rather than the table
    final metadata = user.userMetadata ?? const <String, dynamic>{};
    return ProfileData(
      // take the first non-empty value so older accounts with missing fields still show a name
      fullName: _firstNonEmpty([
        row['full_name'],
        metadata['full_name'],
        metadata['name'],
        user.email,
      ]),
      phoneNumber: _firstNonEmpty([
        row['phone'],
        user.phone,
        metadata['phone'],
      ]),
      city: _stringValue(metadata['city']),
      district: _stringValue(metadata['region']),
    );
  }

  @override
  Future<void> saveCustomerProfile(ProfileData profile) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('No signed-in user is available.');
    }

    // trim input so stray spaces are not stored
    final fullName = profile.fullName.trim();
    final phone = profile.phoneNumber.trim();
    // update the table row; maybeSingle returns null if no row matched
    final row = await _client
        .from('users')
        .update({'full_name': fullName, 'phone': phone})
        .eq('id', user.id)
        .select('id')
        .maybeSingle();
    if (row == null) {
      throw StateError('The signed-in user profile could not be updated.');
    }

    // keep auth metadata in sync with the table, including city and region
    await _client.auth.updateUser(
      UserAttributes(
        data: {
          'full_name': fullName,
          'name': fullName,
          'city': profile.city.trim(),
          'region': profile.district.trim(),
        },
      ),
    );
  }

  /// Returns the first value that is a non-blank string, or an empty string.
  String _firstNonEmpty(Iterable<Object?> values) {
    for (final value in values) {
      final string = _stringValue(value);
      if (string.isNotEmpty) return string;
    }
    return '';
  }

  // anything that is not a String becomes an empty string
  String _stringValue(Object? value) => value is String ? value.trim() : '';
}

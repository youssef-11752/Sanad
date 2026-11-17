/// Personal details shown in the customer profile.
///
/// Keeping these values together makes it clear which fields are edited and
/// lets every screen render the same saved profile.
class ProfileData {
  final String fullName;
  final String phoneNumber;
  final String city;
  final String district;

  const ProfileData({
    required this.fullName,
    required this.phoneNumber,
    required this.city,
    required this.district,
  });

  // Placeholder profile used until real data is loaded.
  static const sample = ProfileData(
    fullName: 'مريم حسن',
    phoneNumber: '01135045965',
    city: 'القاهرة',
    district: 'مدينة نصر',
  );

  // City and district joined for display, skipping empty parts.
  String get location =>
      [city, district].where((part) => part.trim().isNotEmpty).join(' • ');

  // Builds a profile from a single free-text location such as "City, District",
  // splitting on Latin/Arabic commas or a bullet.
  factory ProfileData.fromLocation({
    required String fullName,
    required String phoneNumber,
    required String location,
  }) {
    final parts = location.split(RegExp(r'[,،•]'));
    return ProfileData(
      fullName: fullName,
      phoneNumber: phoneNumber,
      city: parts.isNotEmpty ? parts.first.trim() : '',
      district: parts.length > 1 ? parts.skip(1).join(' ').trim() : '',
    );
  }

  // Returns a copy with only the given fields replaced (the class is immutable).
  ProfileData copyWith({
    String? fullName,
    String? phoneNumber,
    String? city,
    String? district,
  }) {
    return ProfileData(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }
}

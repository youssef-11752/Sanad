/// Builds the address line shown in the home header from the user's auth metadata.
/// Joins region and city with an Arabic comma, skipping blank values, and uses [fallback] if neither exists.
String serviceAddressFromMetadata(
  Map<String, dynamic>? metadata, {
  required String fallback,
}) {
  final region = metadata?['region'];
  final city = metadata?['city'];
  // Collect only non-empty string values so a missing or blank field doesn't leave a stray separator.
  final addressParts = [
    if (region is String && region.trim().isNotEmpty) region.trim(),
    if (city is String && city.trim().isNotEmpty) city.trim(),
  ];

  return addressParts.isEmpty ? fallback : addressParts.join('، ');
}

/// Plain data holder for a service provider shown in the recommended providers list.
class ProviderModel {
  final String id;
  final String name; // provider name
  final String initial; // first letters from the provider name
  // rating is kept as a string, already formatted for display (e.g. "4.9").
  final String rating;
  final int reviewCount;
  final int experienceYears;
  final bool availableToday;
  final int price; // price for the visit

  const ProviderModel({
    required this.id,
    required this.name,
    required this.initial,
    required this.rating,
    required this.reviewCount,
    required this.experienceYears,
    required this.availableToday,
    required this.price,
  });
}

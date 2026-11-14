class ProviderModel {
  final String id;
  final String name; // provider name
  final String initial; // first letters from the provider name
  final String speciality; // provider proffision
  final String rating; // provider rating
  final String experience; // experience for how long
  final String availablity; // provider is available when?
  final int price; // price for the visit

  const ProviderModel({
    required this.id,
    required this.name,
    required this.initial,
    required this.speciality,
    required this.rating,
    required this.experience,
    required this.availablity, 
    required this.price,
  });
}

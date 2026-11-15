class ProviderModel {
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

  final String id;
  final String name;
  final String initial;
  final String speciality;
  final String rating;
  final String experience;
  final String availablity;
  final int price;
}

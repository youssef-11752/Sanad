/// Simple data holder for one service category shown in the list.
class ServiceCategory {
  const ServiceCategory({
    required this.title,
    required this.description,
    required this.iconAsset,
  });

  final String title;
  final String description;
  final String iconAsset;
}

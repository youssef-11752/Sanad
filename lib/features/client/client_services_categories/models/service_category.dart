import 'package:material_ui/material_ui.dart';

/// Simple data holder for one service category shown in the list.
class ServiceCategory {
  const ServiceCategory({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}

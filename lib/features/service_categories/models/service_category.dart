import 'package:flutter/material.dart';

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

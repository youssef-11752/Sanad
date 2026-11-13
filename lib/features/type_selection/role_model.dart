import 'package:flutter/material.dart';

// we used enum here as there are only 2 possibilities types of users 1)client 2)provider
enum UserRoleType {
  client,
  provider,
}

class RoleModel {
  UserRoleType type; // the enum "client or provider"
  String title;  // title of card
  String subtitle; // subtitle of card
  String selectedBadgeText; // card badge
  String buttonText; // main btn that changes according to the role that user chose
  IconData icon; // card icon

  RoleModel({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.selectedBadgeText,
    required this.buttonText,
    required this.icon,
  });
}
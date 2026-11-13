
import 'package:flutter/material.dart';
import 'package:flutter_intern_sprint_one/features/typeSelection/data/models/role_model.dart';

class RoleSelectionProvider extends ChangeNotifier {

  // store the selected role from the model file "enum that has only 2 possibilities"
  UserRoleType selectedRole = UserRoleType.client;

  // list contains the user roles
  final List<RoleModel> roles = [
    RoleModel(
      type: UserRoleType.client,
      title: 'محتاج خدمة',
      subtitle: 'اطلب صيانة، اختار متخصص، وتابع الزيارة',
      selectedBadgeText: 'العميل • محدد',
      buttonText: 'متابعة كعميل',
      icon: Icons.home_outlined,
    ),
    RoleModel(
      type: UserRoleType.provider,
      title: 'أنا مقدم خدمة',
      subtitle: 'حدد صنعتك واستقبل طلبات تناسب خبرتك',
      selectedBadgeText: 'مقدم خدمة • محدد',
      buttonText: 'متابعة كمقدم خدمة',
      icon: Icons.work_outline_rounded,
    ),
  ];

  // get the model of the selected type
  RoleModel get activeRoleModel {
    return roles.firstWhere(
      (role) => role.type == selectedRole,
    );
  }

  // functon to change the selected role type
  void selectRole(UserRoleType role) {
    selectedRole = role;

    // notify the widgets that the selected role has changed
    notifyListeners();
  }
}

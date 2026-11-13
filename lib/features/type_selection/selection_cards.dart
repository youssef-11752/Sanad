import 'package:flutter/material.dart';
import '../../data/models/role_model.dart';

class SelectionCards extends StatelessWidget {
  final RoleModel role; // role from model file "client or provider"
  final bool isSelected; // boolean variable where we select one option
  final VoidCallback onTap; // when you press on the client role or provider role

  const SelectionCards({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.teal[700],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  role.icon, // role icon from model
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role.title, // role title from model
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        role.subtitle, // role subtitle from model
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                // selected part "circle with correct sign if you selected this"
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  // if this is selected show check icon in the container else show null in the container
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
            // spread operator add extra widget from this list to the children list "not completely understood for me"
            if (isSelected) ...[
              SizedBox(height: 14),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.redAccent[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    role.selectedBadgeText, // selected role badge appear in the selected option only
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 155, 31, 22),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
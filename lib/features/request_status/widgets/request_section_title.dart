import 'package:flutter/material.dart';
import 'package:sanad/features/request_status/widgets/request_status_colors.dart';

class RequestSectionTitle extends StatelessWidget {
  const RequestSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: requestTealColor,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

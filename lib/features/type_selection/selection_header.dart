import 'package:flutter/material.dart';

class SelectionHeader extends StatelessWidget {
  const SelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 155, 31, 22),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.home_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(width: 10),
        Text(
          'سند',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.teal[700],
          ),
        ),
      ],
    );
  }
}
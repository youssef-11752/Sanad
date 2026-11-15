import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          textDirection: TextDirection.ltr,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFC63922),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'عنوان الخدمة',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 3),
                Text(
                  'مدينة نصر، القاهرة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[700],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.location_on_outlined,
              color: Colors.teal[700],
              size: 26,
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'تدور على أي خدمة؟',
            hintTextDirection: TextDirection.rtl,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            prefixIcon: Icon(Icons.search_rounded, color: Colors.teal[700], size: 22),
            filled: true,
            fillColor: const Color(0xFFFFFCF5),
            contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
          ),
        ),
      ],
    );
  }
}

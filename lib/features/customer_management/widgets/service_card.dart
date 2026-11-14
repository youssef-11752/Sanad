
import 'package:flutter/material.dart';

import '../../data/models/service_model.dart';

class ServiceCards extends StatelessWidget {

  // list of services displayed in the gridview
  final List<ServiceModel> services;

  const ServiceCards({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      shrinkWrap: true, //take only the height it needs "not entire height of the screen"
      // number of service cards
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cards in each row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.55,
      ),
      // build each card using its index
      itemBuilder: (context, index) {
        final service = services[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF5),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color(0xFFE9DFC9),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                service.icon,
                color: const Color(0xFF57958A),
                size: 24,
              ),
              SizedBox(height: 8),
              Text(
                service.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

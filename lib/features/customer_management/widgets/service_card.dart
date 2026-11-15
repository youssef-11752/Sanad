import 'package:flutter/material.dart';
import 'package:sanad/features/customer_management/models/service_model.dart';

class ServiceCards extends StatelessWidget {
  const ServiceCards({required this.services, super.key});
  final List<ServiceModel> services;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.55,
      ),
      itemBuilder: (context, index) {
        final service = services[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF5),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFE9DFC9)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(service.icon, color: const Color(0xFF57958A), size: 24),
              const SizedBox(height: 8),
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

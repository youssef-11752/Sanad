import 'package:flutter/material.dart';
import 'package:sanad/features/customer_management/models/provider_model.dart';

class ProviderCards extends StatelessWidget {
  const ProviderCards({required this.providers, super.key});
  final List<ProviderModel> providers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: providers.map((provider) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE9DFC9)),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFE3E8D4),
                child: Text(
                  provider.initial,
                  style: const TextStyle(color: Color(0xFF00564F)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      provider.name,
                      style: TextStyle(
                        color: Colors.teal[700],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      provider.speciality,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black54, fontSize: 10),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '★ ' + provider.rating,
                      style: TextStyle(color: Colors.teal[700], fontSize: 10),
                    ),
                    const SizedBox(height: 7),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _ProviderTag(text: provider.experience),
                        _ProviderTag(text: provider.availablity),
                        _ProviderTag(text: 'ج.م ' + provider.price.toString() + ' للزيارة'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ProviderTag extends StatelessWidget {
  const _ProviderTag({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE4EEDC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.teal[700],
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

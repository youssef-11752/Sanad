import 'package:flutter/material.dart';

import '../../data/models/provider_model.dart';

class ProviderCards extends StatelessWidget {
  final List<ProviderModel> providers; // providers list from model file

  const ProviderCards({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: providers.map((provider) {
        // map loops on list and create new card for each item
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE9DFC9)),
          ),
          child: Row( // i can't make the initials and text from right to left
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'الإتاحة: 30 د',
                    style: TextStyle(color: Colors.black45, fontSize: 10),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
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
                    SizedBox(height: 4),
                    Text(
                      provider.speciality,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '★ ${provider.rating}',
                      style: TextStyle(color: Colors.teal[700], fontSize: 10),
                    ),
                    SizedBox(height: 7),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE4EEDC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${provider.experience} , ${provider.availablity}',
                                style: TextStyle(
                                  color: Colors.teal[700],
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE4EEDC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                ' ج.م ${provider.price} للزيارة',
                                style: TextStyle(
                                  color: Colors.teal[700],
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EBD9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  provider.initial,
                  style: TextStyle(
                    color: Colors.teal[700],
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(), // convert map to list
    );
  }
}

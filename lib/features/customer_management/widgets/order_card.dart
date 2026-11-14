
import 'package:flutter/material.dart';

import '../../data/models/order_model.dart';

class OrderCards extends StatelessWidget {
  final List<OrderModel> orders; // orders list from model file

  const OrderCards({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orders.map((order) { // map loops through list items and create card for each one
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE9DFC9),
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4EEDC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order.status,
                      style: TextStyle(
                        color: Colors.teal[700],
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    order.id,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                order.title,
                style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 7),
              Text(
                order.details,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                ),
              ),
              SizedBox(height: 7),
              Text(
                order.date,
                style: const TextStyle(
                  color: Color(0xFF789187),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      }).toList(), // conver map to list
    );
  }
}

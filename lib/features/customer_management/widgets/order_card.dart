import 'package:flutter/material.dart';
import 'package:sanad/features/customer_management/models/order_model.dart';

class OrderCards extends StatelessWidget {
  const OrderCards({required this.orders, super.key});
  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orders.map((order) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE9DFC9)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
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
                  const Spacer(),
                  Text(order.id, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                order.title,
                style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(order.details, style: const TextStyle(color: Colors.black54, fontSize: 10)),
              const SizedBox(height: 7),
              Text(order.date, style: const TextStyle(color: Color(0xFF789187), fontSize: 10)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

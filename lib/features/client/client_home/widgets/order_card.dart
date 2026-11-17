import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/client/client_home/models/order_model.dart';

/// Renders a list of order cards: status badge, order id, title, details and date.
class OrderCards extends StatelessWidget {
  final List<OrderModel> orders; // orders list from model file

  const OrderCards({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orders.map((order) {
        // map loops through list items and create card for each one
        // Each card has a small bottom margin to separate it from the next one.
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppThemes.whiteColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppThemes.darkCremey),
          ),

          child: Column(
            // Cross-axis end alignment: the content is right-aligned for the Arabic layout.
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Status badge on one side, order id on the other.
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppThemes.privacyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order.status,
                      style: TextStyle(
                        color: AppThemes.greenColor,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    order.id,
                    style: TextStyle(color: AppThemes.hiAccount, fontSize: 10),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                order.title,
                style: TextStyle(
                  color: AppThemes.darkGreen,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 7),
              Text(
                order.details,
                style: TextStyle(color: AppThemes.hiAccount, fontSize: 10),
              ),
              SizedBox(height: 7),
              Text(
                order.date,
                style: TextStyle(color: AppThemes.hiAccount, fontSize: 10),
              ),
            ],
          ),
        );
      }).toList(), // conver map to list
    );
  }
}

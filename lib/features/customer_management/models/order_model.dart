class OrderModel {
  const OrderModel({
    required this.id,
    required this.title,
    required this.status,
    required this.date,
    required this.details,
  });

  final String id;
  final String title;
  final String status;
  final String date;
  final String details;
}

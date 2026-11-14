class OrderModel {
  final String id;
  final String title; // order name "cleaning , carpentering"
  final String status; // bending , done
  final String date; // date for the visit
  final String details; // location , provider name

  const OrderModel({
    required this.id,
    required this.title,
    required this.status,
    required this.date,
    required this.details,
  });
}

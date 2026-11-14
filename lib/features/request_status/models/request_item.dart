enum RequestStatus { pending, fulfilled }

class RequestItem {
  const RequestItem({
    required this.id,
    required this.status,
    required this.title,
    required this.provider,
    required this.date,
  });

  final String id;
  final RequestStatus status;
  final String title;
  final String provider;
  final String date;

  factory RequestItem.fromOrder(Map<String, dynamic> order) {
    final id = order['id'];
    if (id is! String || id.isEmpty) {
      throw const FormatException('Order is missing a valid id.');
    }

    final status = switch (order['status']) {
      'pending' => RequestStatus.pending,
      'fulfilled' => RequestStatus.fulfilled,
      final value => throw FormatException('Unsupported order status: $value'),
    };
    final notes = order['notes'];
    final issueId = order['issue_id'];
    final scheduledAt = order['scheduled_at'];
    final completedAt = order['completed_at'];
    final createdAt = order['created_at'];

    return RequestItem(
      id: id,
      status: status,
      title: notes is String && notes.trim().isNotEmpty
          ? notes
          : issueId?.toString() ?? id,
      provider: order['provider_id']?.toString() ?? '',
      date:
          (status == RequestStatus.pending
                  ? scheduledAt
                  : completedAt ?? scheduledAt ?? createdAt)
              ?.toString() ??
          '',
    );
  }
}

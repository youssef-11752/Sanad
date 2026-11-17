enum RequestStatus { pending, fulfilled }

class RequestItem {
  const RequestItem({
    required this.id,
    required this.status,
    required this.title,
    required this.provider,
    required this.date,
    this.canDelete = false,
  });

  final String id;
  final RequestStatus status;
  final String title;
  final String provider;
  final String date;
  final bool canDelete;

  factory RequestItem.fromOrder(Map<String, dynamic> order) {
    final id = order['id'];
    if (id is! String || id.isEmpty) {
      throw const FormatException('Order is missing a valid id.');
    }

    final status = switch (order['status']) {
      'pending' || 'accepted' || 'in_progress' => RequestStatus.pending,
      'completed' => RequestStatus.fulfilled,
      final value => throw FormatException('Unsupported order status: $value'),
    };
    final notes = order['notes'];
    final issue = order['issue'];
    final issueTitle = issue is Map ? issue['title'] : null;
    final issueId = order['issue_id'];
    final scheduledAt = order['scheduled_at'];
    final completedAt = order['completed_at'];
    final createdAt = order['created_at'];

    return RequestItem(
      id: id,
      status: status,
      title: issueTitle is String && issueTitle.trim().isNotEmpty
          ? issueTitle
          : notes is String && notes.trim().isNotEmpty
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

  factory RequestItem.fromIssue(Map<String, dynamic> issue) {
    final id = issue['id'];
    if (id is! String || id.isEmpty) {
      throw const FormatException('Issue is missing a valid id.');
    }

    final status = switch (issue['status']) {
      'pending' || 'accepted' || 'in_progress' => RequestStatus.pending,
      'completed' || 'fulfilled' || 'resolved' => RequestStatus.fulfilled,
      final value => throw FormatException('Unsupported issue status: $value'),
    };
    final title = issue['title'];
    if (title is! String || title.trim().isEmpty) {
      throw const FormatException('Issue is missing a valid title.');
    }

    return RequestItem(
      id: id,
      status: status,
      title: title.trim(),
      provider: issue['provider_id']?.toString() ?? '',
      date: issue['created_at']?.toString() ?? '',
      canDelete: issue['provider_id'] == null && issue['status'] == 'pending',
    );
  }
}

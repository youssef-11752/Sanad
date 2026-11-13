enum RequestStatus { scheduled, completed, completedRated, cancelled }

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

  bool get isCancelled => status == RequestStatus.cancelled;
}

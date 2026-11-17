import 'package:material_ui/material_ui.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_colors.dart';

class RequestSectionTitle extends StatelessWidget {
  const RequestSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: requestTealColor,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

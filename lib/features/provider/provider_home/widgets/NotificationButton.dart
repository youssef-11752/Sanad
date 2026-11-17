import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/constants/colors.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.notifications_outlined,
        size: 30,
        color: Rust,
      ),
    );
  }
}

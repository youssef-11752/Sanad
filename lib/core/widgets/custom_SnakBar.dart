import 'package:material_ui/material_ui.dart';

/// Shows a simple snackbar with the given message and background color.
void customSnakbar(BuildContext context, String text, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text), backgroundColor: backgroundColor),
  );
}

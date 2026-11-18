import 'package:material_ui/material_ui.dart';

void customSnakbar(BuildContext context, String text, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(textAlign: TextAlign.center, text),
      backgroundColor: backgroundColor,
    ),
  );
}

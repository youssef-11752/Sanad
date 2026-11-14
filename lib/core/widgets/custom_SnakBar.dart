import 'package:flutter/material.dart';

void customSnakbar(BuildContext context , String text ,Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text ) ,backgroundColor: backgroundColor,));
}

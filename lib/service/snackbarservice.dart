import 'package:flutter/material.dart';

class Snackbarservice {
  static ScaffoldFeatureController showSnackBar(
      BuildContext context, String message,
      {Color? color}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}

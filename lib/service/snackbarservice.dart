import 'package:flutter/material.dart';

class Snackbarservice {
  static ScaffoldFeatureController showSnackBar(BuildContext context,
      {Color? color, String? message, Widget? widget}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? "") ?? widget!,
      backgroundColor: color,
    ));
  }
}

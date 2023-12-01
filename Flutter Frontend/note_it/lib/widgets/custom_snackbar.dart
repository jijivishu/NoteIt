import 'package:flutter/material.dart';

class CustomSnackBar {
  final Color backgroundColor;
  final String content;

  CustomSnackBar({
    required this.backgroundColor,
    required this.content,
  });

  static void show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message),
      ),
    );
  }

  static void showFailure(BuildContext context, {required String message}) {
    show(context, message: message, backgroundColor: Colors.red.shade300);
  }

  static void showSuccess(BuildContext context, {required String message}) {
    show(context, message: message, backgroundColor: Colors.green.shade300);
  }
}

import 'package:flutter/material.dart';
import 'navigation_service.dart'; // to get navigatorKey

class CustomDialogService {
  static Future<void> showCustomDialog({
    required String title,
    required String content,
  }) {
    final context = NavigationService.navigatorKey.currentContext!;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
}
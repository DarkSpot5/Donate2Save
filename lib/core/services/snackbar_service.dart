import 'package:flutter/material.dart';
import 'navigation_service.dart';

class SnackbarService {
  static void showSnackbar(String message) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

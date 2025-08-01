import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Use when you want to *replace* the current page
  /// Example: after splash screen → go to login screen
  static Future<dynamic> navigateToReplacement(Widget page) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Use when you want to *replace* with a named route
  /// Example: after splash screen → go to /login
  static Future<dynamic> navigateToReplacementNamed(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  /// Use for standard navigation (adds to back stack)
  /// Example: login screen → go to home screen, so back button works
  static Future<dynamic> navigateTo(Widget page) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Use to push named route (adds to back stack)
  // Example: from home → go to /profile
  static Future<dynamic> navigateToNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  // Pops current screen
  // Example: from detail → go back to home
  static void goBack() {
    return navigatorKey.currentState!.pop();
  }

  // Clears the entire stack and navigates to a new screen
  // Example: after logout → go to login (no back to home allowed)
  static Future<dynamic> navigateAndRemoveUntil(Widget page) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  // Clears stack and navigates to a named route
  // Example: after logout → go to /login
  static Future<dynamic> navigateNamedAndRemoveUntil(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  // Use to show a generic dialog from anywhere
  // Example: forgot password success, error dialogs, alerts
  static Future<void> showCustomDialog({
    required String title,
    required String content,
  }) async {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
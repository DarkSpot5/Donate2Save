import 'package:flutter/material.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/services/navigation_service.dart';
import 'auth_controller.dart';
import '../../../../generated/l10n.dart';
//import '../../../dashboard/home/presentation/screens/home.dart';

class LoginController extends ChangeNotifier {

  final AuthController authController;
  final S localization; // Injected localization

  LoginController(this.authController, {required this.localization});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
  void forgotPassword() {
    NavigationService.navigateToNamed('/forgot-password');
  }
  void navigateToRegister() {
    NavigationService.navigateToNamed('/register');
  }
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      SnackbarService.showSnackbar(localization.errorAllFieldsRequired);
      return;
    }
    authController.login(email, password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
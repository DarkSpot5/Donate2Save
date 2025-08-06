import 'package:flutter/material.dart';
import '../../../../core/services/navigation_service.dart';
import 'auth_controller.dart';
import '../../../../core/errors/validation_errors.dart';
//import '../../../dashboard/home/presentation/screens/home.dart';

class LoginController extends ChangeNotifier {

  final AuthController authController;

  LoginController(this.authController);

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

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

  final isValid = ValidationErrors.validateLogin(email, password, context);
  if (!isValid) return;

    authController.login(email, password, context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
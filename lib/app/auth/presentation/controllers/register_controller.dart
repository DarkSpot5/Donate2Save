import 'package:flutter/material.dart';
import 'auth_controller.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';

class RegisterController extends ChangeNotifier {
  final AuthController authController;
  RegisterController(this.authController);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String selectedRole = 'User';
  bool isPasswordVisible = false;

  final generalModel = Model();
  final userModel = UserModel();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void updateSelectedRole(String role) {
    selectedRole = role;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      SnackbarService.showSnackbar('All fields are required.');
      return;
    }

    if (password != confirmPassword) {
      SnackbarService.showSnackbar('Passwords do not match.');
      return;
    }

    //saving data in model so all functions should use model instead of local variables.
    generalModel.fromJson({
      'Email': email,
      'Role': selectedRole,
    });

    //sending password as argument because we will not saving password in model, just sending to create account.
    authController.register(password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
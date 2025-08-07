import 'package:flutter/material.dart';
import 'auth_controller.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';
import '../../../../core/utils/errors/validation_errors.dart';

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
  final isValid = ValidationErrors().validateRegister(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
    confirmPassword: confirmPasswordController.text.trim(),
    selectedRole: selectedRole,
    context: context,
  );
  if (!isValid) return;

    //saving data in model so all functions should use model instead of local variables.
    generalModel.fromJson({
      'Email': emailController.text.trim(),
      'Role': selectedRole,
    });

    //sending password as argument because we will not saving password in model, just sending to create account.
    authController.register(passwordController.text.trim());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
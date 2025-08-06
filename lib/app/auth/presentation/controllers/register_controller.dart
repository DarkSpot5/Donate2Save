import 'package:flutter/material.dart';
import 'auth_controller.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';
import '../../../../generated/l10n.dart';

class RegisterController extends ChangeNotifier {
  final AuthController authController;
   final S localization; // Injected localization

  RegisterController(this.authController, {required this.localization});

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

  bool validateForm(){
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      SnackbarService.showSnackbar(localization.errorAllFieldsRequired);
      return false;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      SnackbarService.showSnackbar(localization.errorInvalidEmail);
      return false;
    }

    if (password != confirmPassword) {
      SnackbarService.showSnackbar(localization.errorPasswordsDoNotMatch);
      return false;
    }

    if(password.length < 8) {
      SnackbarService.showSnackbar(localization.errorPasswordTooShort);
      return false;
    }

    if(password.contains(RegExp(r'[A-Z]')) && 
       password.contains(RegExp(r'[a-z]')) && 
       password.contains(RegExp(r'[0-9]')) && 
       password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      // Password is strong
    } else {
      SnackbarService.showSnackbar(localization.errorPasswordRequirements);
      return false;
    }

    if (selectedRole.isEmpty) {
      SnackbarService.showSnackbar(localization.errorRoleNotSelected);
      return false;
    }

    return true;
  }

  Future<void> register(BuildContext context) async {
    if (!validateForm()) return;

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
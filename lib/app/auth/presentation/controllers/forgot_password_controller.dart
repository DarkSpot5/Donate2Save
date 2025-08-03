import 'package:flutter/material.dart';
import 'auth_controller.dart';
import '../../../../core/services/snackbar_service.dart';

class ForgotPasswordController {

  final AuthController authController;
  ForgotPasswordController(this.authController);
  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();
    
    if (email.isEmpty) {
      SnackbarService.showSnackbar('Please enter your email address');
      return;
    }
    authController.sendResetEmail(email);
    }
  }
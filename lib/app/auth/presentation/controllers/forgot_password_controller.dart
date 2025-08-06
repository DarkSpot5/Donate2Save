import 'package:flutter/material.dart';
import 'auth_controller.dart';
import '../../../../core/errors/validation_errors.dart';

class ForgotPasswordController {

  final AuthController authController;

  ForgotPasswordController(this.authController);
  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetEmail(BuildContext context) async {
    final email = emailController.text.trim();
   
    final isValid = ValidationErrors.validateForgotPassword(email, context);
    if (!isValid) return;


    authController.sendResetEmail(email);
    }
  }
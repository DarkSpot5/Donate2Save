import 'package:flutter/material.dart';
import 'auth_controller.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../generated/l10n.dart';

class ForgotPasswordController {

  final AuthController authController;
  final S localization; // Injected localization

  ForgotPasswordController(this.authController, {required this.localization});
  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();
    
    if (email.isEmpty) {
      SnackbarService.showSnackbar(localization.errorEnterEmail);
      return;
    }
    authController.sendResetEmail(email);
    }
  }
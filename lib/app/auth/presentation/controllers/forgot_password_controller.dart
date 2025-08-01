import 'package:flutter/material.dart';
import 'auth_controller.dart';
import '../../../../core/state/loading_controller.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';

class ForgotPasswordController extends LoadingController {
  
  final authController = AuthController();
  final generalModel = Model();
  final userModel = UserModel();

  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetEmail(BuildContext context) async {
    final email = emailController.text.trim();
    
    if (email.isEmpty) {
      SnackbarService.showSnackbar('Please enter your email address.');
      return;
    }
    authController.sendResetEmail(email, context);
    }
  }
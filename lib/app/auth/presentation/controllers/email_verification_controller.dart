import 'package:flutter/material.dart';

import 'auth_controller.dart';

class EmailVerificationController {

  final AuthController authController;
  EmailVerificationController(this.authController);

  Future<void> checkVerificationStatus(BuildContext context) async {
    authController.checkVerificationStatus(context);
  }

  Future<void> resendVerificationEmail() async {
    authController.resendVerificationEmail();
  }
  
}
import 'auth_controller.dart';

class EmailVerificationController {

  final AuthController authController;
  EmailVerificationController(this.authController);

  Future<void> checkVerificationStatus() async {
    authController.checkVerificationStatus();
  }

  Future<void> resendVerificationEmail() async {
    authController.resendVerificationEmail();
  }
  
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/presentation/controllers/register_controller.dart';
import '../auth/presentation/screens/register.dart';
import '../auth/presentation/controllers/email_verification_controller.dart';
import '../auth/presentation/screens/email_verification.dart';
import '../auth/presentation/controllers/forgot_password_controller.dart';
import '../auth/presentation/screens/forgot_password.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get all => {
       // '/': (_) => const LoginPage(),
      '/': (_) => ChangeNotifierProvider(
          create: (_) => RegisterController(),
          child: const RegistrationPage(),
            ),

      '/email-verification': (_) => ChangeNotifierProvider(
              create: (_) => EmailVerificationController(),
              child: const EmailVerificationScreen(),
            ),
      
      '/forgot-password': (_) => ChangeNotifierProvider(create: 
          (_) => ForgotPasswordController(),
          child: const ForgotPasswordPage(),
        ),
      };
}
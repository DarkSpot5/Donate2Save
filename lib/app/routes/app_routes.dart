import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/presentation/controllers/auth_controller.dart';
import '../auth/presentation/controllers/register_controller.dart';
import '../auth/presentation/screens/register.dart';
import '../auth/presentation/controllers/email_verification_controller.dart';
import '../auth/presentation/screens/email_verification.dart';
import '../auth/presentation/controllers/login_controller.dart';
import '../auth/presentation/screens/login.dart';
import '../auth/presentation/controllers/forgot_password_controller.dart';
import '../auth/presentation/screens/forgot_password.dart';
import '../auth/presentation/controllers/user_profile_setup_controller.dart';
import '../auth/presentation/screens/user_profile_setup.dart';
import '../auth/presentation/controllers/hospital_profile_setup_controller.dart';
import '../auth/presentation/screens/hospital_profile_setup.dart';
import '../dashboard/home/presentation/controllers/home_controller.dart';
import '../dashboard/home/presentation/screens/home.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get all => {
      '/': (_) => ChangeNotifierProvider(
          create: (context) => LoginController(
            Provider.of<AuthController>(context, listen: false)),
          child: const LoginPage(),
        ),

      '/login': (_) => ChangeNotifierProvider(
          create: (context) => LoginController(
            Provider.of<AuthController>(context, listen: false)),
          child: const LoginPage(),
        ),

      '/register': (_) => ChangeNotifierProvider(
          create: (context) => RegisterController(
            Provider.of<AuthController>(context, listen: false)),
          child: const RegistrationPage(),
            ),

      '/email-verification': (_) => Provider(
              create: (context) => EmailVerificationController(
                Provider.of<AuthController>(context, listen: false),),
              child: const EmailVerificationScreen(),
            ),
      
      '/forgot-password': (_) => Provider(
        create: (context) => ForgotPasswordController(
          Provider.of<AuthController>(context, listen: false)),
          child: const ForgotPasswordPage(),
        ),
      
      '/user-profile-setup': (_) => ChangeNotifierProvider(
          create: (context) => UserProfileSetupController(
            Provider.of<AuthController>(context, listen: false)),
          child: const UserProfileSetupPage(),
        ),

      '/hospital-profile-setup': (_) => ChangeNotifierProvider(
          create: (context) => HospitalProfileSetupController(
            Provider.of<AuthController>(context, listen: false)),
          child: const HospitalProfileSetupPage(),
        ),

      '/home': (_) => ChangeNotifierProvider(
          create: (context) => HomeController(
            Provider.of<AuthController>(context, listen: false),),
          child: const HomeScreen(),
        ),
      };
}
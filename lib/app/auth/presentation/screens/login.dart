import 'package:donate2save/core/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/login_controller.dart';
import '../../../../../providers/locale_providers.dart' as langprovider;
import '../../../../generated/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return LoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              tooltip: S.of(context).languageToggle,
              onPressed: () {
                Provider.of<langprovider.LocaleProvider>(context, listen: false).toggleLocale();
              },
            )
          ],
        ),
        body: Stack(
          children: [
            // Main content with scrolling
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
                  children: [
                    const SizedBox(height: 40),

                    // Logo Section
                      CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/heart_logo.png',
                        height: 120,
                        width: 120,
                       ),
                      
                    ),
                    const SizedBox(height: 20),

                    // Title Section
                    Stack(
                      children: [
                        // App title
                        Text(
                          S.of(context).appTitle, // Use localized app name
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.yellowAccent), // Darker title color
                        ),
                        // "Health Care" positioned at bottom-right of the title
                        Positioned(
                          right: 0,
                          bottom: -20,
                          child: Text(
                            S.of(context).appSubtitle, // Use localized subtitle
                            style: const TextStyle(
                              color: Colors.white70, // Lighter color for subtitle
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 80),

                    // Email Input Field
                    TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: S.of(context).emailLabel,
                        prefixIcon: const Icon(Icons.email),
                      ),
                    style: const TextStyle(color: Colors.black),
                    ),

                    const SizedBox(height: 20),

                    // Password Input Field
                    TextField(
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: S.of(context).passwordLabel,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: controller.togglePasswordVisibility, // Toggle password visibility
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 5),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          controller.forgotPassword(); // Navigate to forgot password page
                        },
                        child: Text(
                          S.of(context).forgotPasswordLink,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10), // Spacing before login button

                    // Login button
                    SizedBox(
                      width: double.infinity, // Makes the button fill the available width
                      child: ElevatedButton(
                        onPressed: () {
                          controller.login(context); // Calls the login function
                          },
                        child: Text(S.of(context).loginButton), // Use localized login button text
                      ),
                    ),
                    const SizedBox(height: 10), // Spacing before the "or" divider
                    // Divider with "or" in the middle
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: Colors.white54)), // Left divider
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            S.of(context).orDivider, // Use localized "or" text
                            style: Theme.of(context).textTheme.bodySmall, // Small text style
                          ),
                        ),
                        const Expanded(
                            child: Divider(color: Colors.white54)), // Right divider
                      ],
                    ),
                    const SizedBox(height: 10), // Spacing before the register button
                    // Registration button with same style as login button
                    SizedBox(
                      width: double.infinity, // Makes the button fill the available width
                      child: ElevatedButton(
                        onPressed: () {
                          controller.navigateToRegister(); // Calls the function to navigate to register page
                        },
                        child: Text(S.of(context).registerButton), // Use localized register button text
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
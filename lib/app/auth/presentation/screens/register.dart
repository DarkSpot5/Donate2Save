import 'package:donate2save/core/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/register_controller.dart';
import '../../../../../providers/locale_providers.dart' as langprovider;
import '../../../../generated/l10n.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RegisterController>(context);
    return LoadingOverlay(
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).registerTitle),
        actions: [ 
        IconButton(
          icon: const Icon(Icons.language),
          tooltip: S.of(context).languageToggle,
          onPressed: () {
            Provider.of<langprovider.LocaleProvider>(context, listen: false).toggleLocale();
          },
        )
      ]),
        body: Stack(
          children: [
            // Main content with scrolling
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
                  children: [
                    const SizedBox(height: 30),
                    // App Logo
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
                    // Title
                    Text(
                      S.of(context).registerCreateAccount,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: Colors.yellowAccent),
                    ),
                    const SizedBox(height: 40),
                    // Email input field
                    TextField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: S.of(context).emailLabel,
                        prefixIcon: const Icon(Icons.email),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    // Password input field
                    TextField(
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: S.of(context).passwordLabel,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    // Confirm Password input field
                    TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: S.of(context).confirmPasswordLabel,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    // Role selection dropdown
                    DropdownButtonFormField<String>(
                      value: controller.selectedRole,
                      items: <String>["User","Hospital"]
                          .map((String role) => DropdownMenuItem<String>(
                                value: role,
                                child: Text(role),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        controller.updateSelectedRole(newValue ?? 'User');
                      },
                      decoration: InputDecoration(
                        labelText: S.of(context).selectRoleLabel,
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Register button
                    SizedBox(
                      width: double.infinity, // Ensures full width like in login page
                      child: ElevatedButton(
                        onPressed: () => controller.register(context),
                        child: Text(
                          S.of(context).registerButton,
                          style: TextStyle(fontSize: 18),
                        ),
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
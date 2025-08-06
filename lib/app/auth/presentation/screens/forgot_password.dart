import 'package:donate2save/core/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/forgot_password_controller.dart';
import '../../../../../providers/locale_providers.dart' as langprovider;
import '../../../../generated/l10n.dart';

class ForgotPasswordPage extends StatelessWidget {
const ForgotPasswordPage({super.key});

@override
Widget build(BuildContext context) {
  final controller = Provider.of<ForgotPasswordController>(context);
  return LoadingOverlay(
    child: Scaffold(
    appBar: AppBar(title: Text(S.of(context).forgotPassword),
    actions: [ 
        IconButton(
          icon: const Icon(Icons.language),
          tooltip: S.of(context).languageToggle,
          onPressed: () {
            Provider.of<langprovider.LocaleProvider>(context, listen: false).toggleLocale();
          },
        )
      ]
      ),
      
    body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Page Title
            Text(
              S.of(context).resetYourPassword,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.yellow),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

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

                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.sendResetEmail(context),
                      child: Text(
                        S.of(context).sendResetEmail,
                        style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          )
        )
      )
    );
  }
}
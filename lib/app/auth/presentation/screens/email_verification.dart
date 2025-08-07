import 'package:donate2save/core/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import '../controllers/email_verification_controller.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/locale_providers.dart' as langprovider;
import '../../../../generated/l10n.dart';


class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<EmailVerificationController>(context, listen: false);
    return LoadingOverlay(
      child: Scaffold(
       appBar: AppBar(
        title: Text(S.of(context).emailVerificationTitle),
        actions: [ 
        IconButton(
          icon: const Icon(Icons.language),
          tooltip: S.of(context).languageToggle,
          onPressed: () {
            Provider.of<langprovider.LocaleProvider>(context, listen: false).toggleLocale();
          },
        )
      ]),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).emailVerificationTextTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  
                  const SizedBox(height: 20),

                    Text(
                      S.of(context).emailVerificationTextSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),

                  const SizedBox(height: 40),

                  // "I Verified My Email" Button
                  ElevatedButton(
                    onPressed: () async {
                        await controller.checkVerificationStatus(context);   
                            },
                    child: Text(
                      S.of(context).iVerifiedMyEmail,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "Resend Verification Email" Button
                  TextButton(
                    onPressed: () async {
                      await controller.resendVerificationEmail();
                    },
                    child: Text(
                      S.of(context).resendVerificationEmail,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      )
                    )
                  )
                ]
            )
          )
        )
      )
    );
  }
}
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/auth/presentation/controllers/auth_controller.dart';
import 'loading_spinner.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main page content
        child,

        // **Loading Spinner Overlay**
        Consumer<AuthController>(
          builder: (context, authProvider, child) {
            if (!authProvider.isLoading) return const SizedBox.shrink();

            return Positioned.fill(
              child: Stack(
                children: [
                  // Blur effect over the screen
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  
                  // **Centered Loading Spinner**
                  const Center(child: CustomLoader(useLottie: true)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  final bool useLottie; // Toggle between Lottie or SpinKit
  const CustomLoader({this.useLottie = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: useLottie
          ? Lottie.asset(
              'assets/animations/loading_heart.json',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            )
          : SpinKitFadingCircle(
              color: Colors.yellow, // Blood donation theme
              size: 80.0,
            ),
    );
  }
}
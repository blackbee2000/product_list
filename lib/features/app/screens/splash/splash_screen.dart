import 'package:flutter/material.dart';
import 'package:product_list/features/app/controllers/splash_controller.dart';
import 'package:product_list/features/app/screens/base_screen.dart';

class SplashScreen extends BaseScreen<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: const Center(
          child: Text(
            'PLD',
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.w700,
              fontSize: 50,
              letterSpacing: 5,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_yoga_mat/features/home/home_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      Future.delayed(const Duration(seconds: 2), () {
        Utils.go(
          context: context,
          screen: HomeScreen(),
          replace: true,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lotties/yoga.json', // Make sure to add your Lottie JSON file to assets
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

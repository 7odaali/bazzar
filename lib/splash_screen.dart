import 'package:bazzar/core/theming/colors.dart';
import 'package:bazzar/features/set_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SetUpScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/splash.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
              child: Image.asset(
            "assets/Logo.png",
            width: 120.w,
            fit: BoxFit.cover,
          )),
        ],
      ),
    );
  }
}


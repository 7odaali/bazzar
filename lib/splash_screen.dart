import 'package:flutter/material.dart';
import 'my_home_page.dart';

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
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Color(0xFF041A31),
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
            width: 0.3 * w,
            fit: BoxFit.cover,
          )),
        ],
      ),
    );
  }
}


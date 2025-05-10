import 'dart:async';
import 'package:flutter/material.dart';
import 'package:translator_app/view/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset("assets/images/splash_screen.png", fit: BoxFit.cover),

          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

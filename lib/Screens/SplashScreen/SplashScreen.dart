import 'dart:async';
import 'package:flutter/material.dart';
import 'package:instachat/Appwrite/Authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserSession().then((value) {
      if (value) {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/app_icon.png', height: 120, width: 120),
      ),
    );
  }
}

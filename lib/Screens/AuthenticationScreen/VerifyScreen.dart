import 'dart:async';
import 'package:flutter/material.dart';
import 'package:instachat/Appwrite/AppwriteService.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  Future<void> _checkVerificationStatus() async {
    final user = await getUser();
    if (user != null && user.emailVerification == true) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/app_icon.png', height: 120, width: 120),
              const SizedBox(height: 20),
              const Text(
                'Pending Approval',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your account is under review.\n\nPlease wait while an administrator verifies your email and activates your account. You will be automatically logged in once approved.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(color: Colors.amber),
            ],
          ),
        ),
      ),
    );
  }
}

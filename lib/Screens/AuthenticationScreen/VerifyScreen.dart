import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instachat/Appwrite/AppwriteService.dart';
import 'package:instachat/Appwrite/Authentication.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool showResetButton = false;

  @override
  void initState() {
    super.initState();

    getUser().then((value) {
      if (value != null && value.emailVerification == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            backgroundColor: Colors.amber,
            behavior: SnackBarBehavior.floating,
            content: Text('We have sent a verification link to ${value.email}'),
            duration: Duration(seconds: 2),
          ),
        );

        sendVerificationEmail().then((success) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                backgroundColor: Colors.amber,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Please check your email for the verification link.',
                ),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            setState(() {
              showResetButton = true;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                content: Text('Failed to send verification email.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        });
      } else {
        // Redirect only if we are sure email is verified
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  Future<void> resendEmail() async {
    bool result = await sendVerificationEmail();
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          backgroundColor: Colors.amber,
          behavior: SnackBarBehavior.floating,
          content: Text('Verification email resent.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text('Failed to resend verification email.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/app_icon.png', height: 120, width: 120),
            const SizedBox(height: 20),
            const Text(
              'Verify your email address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'A verification link has been sent to your email address. Please check your inbox and click the link to verify your account.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            showResetButton
                ? ElevatedButton(
                  onPressed: resendEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  child: Text(
                    'Resend Email Verification',
                    style: TextStyle(color: Colors.white),
                  ),
                )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

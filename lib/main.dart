import 'package:flutter/material.dart';
import 'package:instachat/Screens/AuthenticationScreen/ForgotPassword.dart';
import 'package:instachat/Screens/AuthenticationScreen/LoginScreen.dart';
import 'package:instachat/Screens/AuthenticationScreen/SignupScreen.dart';
import 'package:instachat/Screens/AuthenticationScreen/VerifyScreen.dart';
import 'package:instachat/Screens/HomeScreen/HomeScreen.dart';
import 'package:instachat/Screens/SplashScreen/SplashScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: Instachat()));
}

class Instachat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instachat',
      theme: ThemeData(primarySwatch: Colors.yellow),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot-password': (context) => const ForgotPasswordDialog(),
        '/home': (context) => const HomeScreen(),
        '/verify': (context) => const VerifyScreen(),
      },
    );
  }
}

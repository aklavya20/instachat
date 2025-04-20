import 'package:flutter/material.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Reset Password"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Enter your email address to receive a reset link."),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: 'Enter your email',
              hintStyle: const TextStyle(color: Colors.grey),
              labelStyle: const TextStyle(color: Colors.grey),
              floatingLabelStyle: const TextStyle(color: Colors.amber),
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: Colors.amber, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final email = _emailController.text.trim();
            print("Send reset email to $email");
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          child: const Text(
            "Reset Password",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

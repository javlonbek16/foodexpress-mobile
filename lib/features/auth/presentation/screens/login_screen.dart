import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              const Text(
                "FOOD EXPRESSGA KIRING!",
                style: TextStyle(fontSize: 26),
                textAlign: .center,
              ),
              const SizedBox(height: 50),
              TextFormField(decoration: InputDecoration(hintText: "Email kiriting ... ")),
              TextFormField(decoration: InputDecoration(hintText: "Parolni kiriting ... ")),
              const SizedBox(height: 100),
              FilledButton(onPressed: () {}, child: Text("Kirish ")),
            ],
          ),
        ),
      ),
    );
  }
}

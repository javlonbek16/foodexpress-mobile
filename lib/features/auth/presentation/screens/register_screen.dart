import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              const Text(
                "FOOD EXPRESSDA RO'YXATDAN O'TING!",
                style: TextStyle(fontSize: 26),
                textAlign: .center,
              ),
              const SizedBox(height: 50),
              TextFormField(decoration: InputDecoration(hintText: "Email kiriting ... ")),
              TextFormField(decoration: InputDecoration(hintText: "Parol kiriting ... ")),
              TextFormField(decoration: InputDecoration(hintText: "Parolni qayta kiriting ... ")),
              const SizedBox(height: 100),
              FilledButton(onPressed: () {}, child: const Text("Ro'yxatdan o'ting")),
            ],
          ),
        ),
      ),
    );
  }
}

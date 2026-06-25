import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Express",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

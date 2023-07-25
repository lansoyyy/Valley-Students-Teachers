import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/screens/auth/landing_screen.dart';
import 'package:valley_students_and_teachers/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LandingScreen(),
      routes: {
        Routes().landingscreen: (context) => const LandingScreen(),
      },
    );
  }
}

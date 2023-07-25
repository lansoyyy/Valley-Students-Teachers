import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/screens/auth/landing_screen.dart';
import 'package:valley_students_and_teachers/screens/auth/students_login_screen.dart';
import 'package:valley_students_and_teachers/screens/auth/teachers_login_screen.dart';
import 'package:valley_students_and_teachers/screens/student_home_screen.dart';
import 'package:valley_students_and_teachers/screens/teachers_home_screen.dart';
import 'package:valley_students_and_teachers/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valley - Students and Teachers',
      home: const LandingScreen(),
      routes: {
        Routes().landingscreen: (context) => const LandingScreen(),
        Routes().studentsloginscreen: (context) => const StudentsLoginScreen(),
        Routes().teachersloginscreen: (context) => const TeachersLoginScreen(),
        Routes().studenthomescreen: (context) => const StudentHomeScreen(),
        Routes().teacherhomescreen: (context) => const TeachersHomeScreen(),
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/screens/auth/landing_screen.dart';
import 'package:valley_students_and_teachers/screens/auth/students_login_screen.dart';
import 'package:valley_students_and_teachers/screens/auth/teachers_login_screen.dart';
import 'package:valley_students_and_teachers/screens/student_home_screen.dart';
import 'package:valley_students_and_teachers/screens/teachers_home_screen.dart';
import 'package:valley_students_and_teachers/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          authDomain: 'valley-9b203.firebaseapp.com',
          apiKey: "AIzaSyBYw1II0TSmA-HXeU1NJI1WF2xzyPFIhdQ",
          appId: "1:354930278705:web:420cec9df723d977173010",
          messagingSenderId: "354930278705",
          projectId: "valley-9b203",
          storageBucket: "valley-9b203.appspot.com"));
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

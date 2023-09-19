import 'package:flutter/material.dart';

class AdminTeachersScreen extends StatefulWidget {
  const AdminTeachersScreen({super.key});

  @override
  State<AdminTeachersScreen> createState() => _AdminTeachersScreenState();
}

class _AdminTeachersScreenState extends State<AdminTeachersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            opacity: 200,
            image: AssetImage(
              'assets/images/back.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

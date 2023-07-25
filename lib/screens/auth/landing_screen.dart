import 'package:flutter/material.dart';

import '../../utils/routes.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            opacity: 110,
            image: AssetImage(
              'assets/images/back.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextBold(
                text: 'CAMARINES SUR',
                fontSize: 14,
                color: Colors.white,
              ),
              TextBold(
                text: 'POLYTECHNIC COLLEGES',
                fontSize: 14,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBold(
                text: 'COLLEGE of',
                fontSize: 48,
                color: Colors.white,
              ),
              TextBold(
                text: 'COMPUTER STUDIES',
                fontSize: 48,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 250,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(
                    fontColor: Colors.black,
                    radius: 100,
                    height: 60,
                    color: Colors.white,
                    label: 'Faculty Schedule',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes().homescreen);
                    },
                  ),
                  ButtonWidget(
                    fontColor: Colors.black,
                    radius: 100,
                    height: 60,
                    color: Colors.white,
                    label: 'Student Attendance',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes().attendancescreen);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

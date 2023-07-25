import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/widgets/textfield_widget.dart';

import '../../utils/routes.dart';
import '../../widgets/button_widget.dart';

class TeachersLoginScreen extends StatefulWidget {
  const TeachersLoginScreen({super.key});

  @override
  State<TeachersLoginScreen> createState() => _TeachersLoginScreenState();
}

class _TeachersLoginScreenState extends State<TeachersLoginScreen> {
  final idcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 500,
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        TextFieldWidget(
                            label: 'ID Number', controller: idcontroller),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                            isObscure: true,
                            isPassword: true,
                            label: 'Password',
                            controller: passwordcontroller),
                        const SizedBox(
                          height: 50,
                        ),
                        ButtonWidget(
                          fontColor: Colors.black,
                          radius: 100,
                          height: 60,
                          color: Colors.white,
                          label: 'Login',
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes().teacherhomescreen);
                          },
                        ),
                      ],
                    ),
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

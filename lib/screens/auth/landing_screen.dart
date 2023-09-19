import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/widgets/text_widget.dart';
import 'package:valley_students_and_teachers/widgets/toast_widget.dart';

import '../../utils/routes.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/textfield_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final passController = TextEditingController();

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
                          height: 250,
                        ),
                        ButtonWidget(
                          fontColor: Colors.black,
                          radius: 100,
                          height: 60,
                          color: Colors.white,
                          label: 'Students',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes().studentsloginscreen);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                          fontColor: Colors.black,
                          radius: 100,
                          height: 60,
                          color: Colors.white,
                          label: 'Teachers',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes().teachersloginscreen);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                          fontColor: Colors.black,
                          radius: 100,
                          height: 60,
                          color: Colors.white,
                          label: 'Admin',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: TextRegular(
                                    color: Colors.black,
                                    text: 'Enter Admin Password',
                                    fontSize: 18,
                                  ),
                                  content: SizedBox(
                                    height: 100,
                                    child: TextFieldWidget(
                                        label: 'Password',
                                        isObscure: true,
                                        controller: passController),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        if (passController.text ==
                                            'admin-password') {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, Routes().adminhome);
                                        } else {
                                          Navigator.pop(context);
                                          showToast('Invalid admin password!');
                                        }
                                        // Navigator.of(context).pushReplacement(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const AdminHomeScreen()));
                                      },
                                      child: TextRegular(
                                        text: 'Continue',
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                            // Navigator.pushNamed(
                            //     context, Routes().teachersloginscreen);
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

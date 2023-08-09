import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/widgets/textfield_widget.dart';

import '../../services/add_user.dart';
import '../../utils/routes.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

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
                            login();
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
                          label: 'Signup',
                          onPressed: () {
                            registerDialog();
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

  final nameController = TextEditingController();

  final idnumberController = TextEditingController();

  final passwordController = TextEditingController();

  registerDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.white.withOpacity(0.8),
              child: Container(
                color: Colors.white.withOpacity(0.5),
                height: 375,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                          label: 'Full Name', controller: nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'ID Number', controller: idnumberController),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          isPassword: true,
                          isObscure: true,
                          label: 'Password',
                          controller: passwordController),
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonWidget(
                          color: Colors.black,
                          label: 'Register',
                          onPressed: (() async {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email:
                                          '${idnumberController.text}@teacher.com',
                                      password: passwordController.text);
                              // addUser(
                              //     newNameController
                              //         .text,
                              //     newEmailController
                              //         .text,
                              //     newPassController
                              //         .text);
                              addUser(
                                  nameController.text,
                                  '${idnumberController.text}@teacher.com',
                                  passwordController.text,
                                  'Teacher');
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: TextRegular(
                                      text: 'Account created succesfully!',
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: TextRegular(
                                      text: e.toString(),
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              );
                            }
                          })),
                    ],
                  ),
                ),
              ));
        });
  }

  login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '${idcontroller.text}@teacher.com',
          password: passwordcontroller.text);

      Navigator.pushReplacementNamed(context, Routes().teacherhomescreen);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextRegular(
              text: e.toString(), fontSize: 14, color: Colors.white),
        ),
      );
    }
  }
}

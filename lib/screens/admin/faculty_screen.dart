import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/routes.dart';
import '../../widgets/text_widget.dart';

class FacultyScreen extends StatelessWidget {
  final box = GetStorage();

  FacultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(box.read('id'))
        .snapshots();
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
        child: StreamBuilder<DocumentSnapshot>(
            stream: userData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else if (snapshot.hasError) {
                return const SizedBox();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              dynamic data = snapshot.data;
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 175,
                    ),
                    TextBold(
                      text: 'Available',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/profile.png',
                                height: 200),
                            const SizedBox(
                              height: 20,
                            ),
                            TextBold(
                              text: data['name'],
                              fontSize: 38,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextBold(
                              text: data['idNumber'].split('@')[0],
                              fontSize: 28,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextBold(
                              text: data['avail'],
                              fontSize: 28,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, Routes().schedulescreen);
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.white,
                                    size: 42,
                                  ),
                                  label: TextBold(
                                    text: 'View Schedule',
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      Routes().availabilityscreen,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.schedule_outlined,
                                    color: Colors.white,
                                    size: 42,
                                  ),
                                  label: TextBold(
                                    text: 'View Availability',
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Expanded(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes().adminhome);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                          label: TextBold(
                            text: 'Back',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

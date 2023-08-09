import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/widgets/schedule_dialog.dart';
import 'package:valley_students_and_teachers/widgets/text_widget.dart';
import 'package:valley_students_and_teachers/widgets/textfield_widget.dart';
import 'package:valley_students_and_teachers/widgets/toast_widget.dart';

class TeachersHomeScreen extends StatefulWidget {
  const TeachersHomeScreen({super.key});

  @override
  State<TeachersHomeScreen> createState() => _TeachersHomeScreenState();
}

class _TeachersHomeScreenState extends State<TeachersHomeScreen> {
  bool isSchedule = true;
  bool isAvailability = false;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: 400,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextBold(
                    text: 'Welcome!',
                    fontSize: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/avatar.png',
                    height: 125,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextBold(
                    text: 'John Doe',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextBold(
                    text: '2020300527',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAvailability = false;
                        isSchedule = true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: isSchedule ? Colors.white : Colors.grey,
                          size: 48,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextBold(
                          text: 'Schedule',
                          fontSize: 24,
                          color: isSchedule ? Colors.white : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 75, right: 75),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAvailability = true;
                        isSchedule = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.schedule,
                          color: isAvailability ? Colors.white : Colors.grey,
                          size: 48,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextBold(
                          text: 'Availability',
                          fontSize: 24,
                          color: isAvailability ? Colors.white : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isSchedule ? schedule() : availability(),
          ],
        ),
      ),
    );
  }

  Widget schedule() {
    return SizedBox(
      width: 800,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 32,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: ListTile(
                      leading: const Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                      title: TextBold(
                          text: 'Name of Notification',
                          fontSize: 16,
                          color: Colors.black),
                      subtitle: TextRegular(
                          text: 'Date and Time',
                          fontSize: 12,
                          color: Colors.black),
                    ))
                  ];
                },
              )),
          const SizedBox(
            height: 20,
          ),
          TextBold(
            text: 'Schedule',
            fontSize: 32,
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const ScheduleDialog();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      label: TextBold(
                        text: 'Add schedule',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Schedules')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Error'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                          );
                        }

                        final data = snapshot.requireData;
                        return Expanded(
                          child: SizedBox(
                            child: ListView.builder(
                              itemCount: data.docs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextBold(
                                          text: data.docs[index]['name'],
                                          fontSize: 22,
                                          color: Colors.black),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      TextBold(
                                          text: data.docs[index]['section'],
                                          fontSize: 22,
                                          color: Colors.black),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      TextBold(
                                          text:
                                              '${data.docs[index]['day']} ${data.docs[index]['timeFrom']} - ${data.docs[index]['timeTo']}',
                                          fontSize: 22,
                                          color: Colors.black),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final availController = TextEditingController();

  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  Widget availability() {
    return StreamBuilder<DocumentSnapshot>(
        stream: userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              width: 800,
            );
          } else if (snapshot.hasError) {
            return const SizedBox(
              width: 800,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              width: 800,
            );
          }
          dynamic data = snapshot.data;
          availController.text = data['avail'];
          return SizedBox(
            width: 800,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.black,
                        size: 32,
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              child: ListTile(
                            leading: const Icon(
                              Icons.notifications,
                              color: Colors.black,
                            ),
                            title: TextBold(
                                text: 'Name of Notification',
                                fontSize: 16,
                                color: Colors.black),
                            subtitle: TextRegular(
                                text: 'Date and Time',
                                fontSize: 12,
                                color: Colors.black),
                          ))
                        ];
                      },
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextBold(
                  text: 'Availability',
                  fontSize: 32,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFieldWidget(
                                label: '',
                                controller: availController,
                                height: 200,
                                width: 400,
                                maxLine: 5),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, bottom: 20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: TextButton.icon(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(data.id)
                                    .update({
                                  'avail': availController.text,
                                });
                                showToast('Saved Succesfully!');
                              },
                              icon: const Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                              label: TextBold(
                                text: 'Save',
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

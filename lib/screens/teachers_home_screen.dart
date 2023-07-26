import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/widgets/text_widget.dart';

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
                      onPressed: () {},
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
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBold(
                                    text: 'Mac Laboratory',
                                    fontSize: 22,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 50,
                                ),
                                TextBold(
                                    text: 'BSIT 3B',
                                    fontSize: 22,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 50,
                                ),
                                TextBold(
                                    text: 'Monday 8:30AM - 4:30PM',
                                    fontSize: 22,
                                    color: Colors.black),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget availability() {
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
                      TextBold(
                        text: 'AVAILABLE',
                        fontSize: 28,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextBold(
                        text: 'Tommorow @3:30PM to 5:00PM',
                        fontSize: 28,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextBold(
                        text: 'You can come to my office @CS Office',
                        fontSize: 28,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton.icon(
                        onPressed: () {},
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
  }
}

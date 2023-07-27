import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/widgets/reservation_dialog.dart';
import 'package:valley_students_and_teachers/widgets/text_widget.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
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
                          Icons.email_outlined,
                          color: isSchedule ? Colors.white : Colors.grey,
                          size: 48,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextBold(
                          text: 'Consultation',
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
                          Icons.calendar_month_outlined,
                          color: isAvailability ? Colors.white : Colors.grey,
                          size: 48,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextBold(
                          text: 'Reservation',
                          fontSize: 24,
                          color: isAvailability ? Colors.white : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isSchedule ? consultation() : reservation(),
          ],
        ),
      ),
    );
  }

  Widget consultation() {
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
                        createGroupDialog();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      label: TextBold(
                        text: 'Create group',
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.chat,
                                  size: 48,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                TextBold(
                                    text: 'Last Message here...',
                                    fontSize: 16,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 50,
                                ),
                                TextRegular(
                                    text: 'Date and Time',
                                    fontSize: 14,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 30,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final searchController = TextEditingController();

  String nameSearched = '';

  createGroupDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            height: 50,
            width: 180,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  nameSearched = value;
                });
              },
              decoration: const InputDecoration(
                  hintText: 'Search member',
                  hintStyle: TextStyle(fontFamily: 'QRegular'),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  )),
              controller: searchController,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.account_circle_outlined,
                  size: 32,
                ),
                title: TextBold(
                    text: 'John Doe', fontSize: 16, color: Colors.black),
                trailing: TextRegular(
                    text: 'BSIT - 2A', fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextBold(
                text: 'Close',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextBold(
                text: 'Create',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget reservation() {
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
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  size: 48,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                TextBold(
                                    text: 'Name of Reservation',
                                    fontSize: 16,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 50,
                                ),
                                TextRegular(
                                    text: 'Date and Time',
                                    fontSize: 14,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 30,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const ReservationDialog();
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        label: TextBold(
                          text: 'Create',
                          fontSize: 18,
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

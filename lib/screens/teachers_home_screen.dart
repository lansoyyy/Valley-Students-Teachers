import 'package:cell_calendar/cell_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valley_students_and_teachers/widgets/add_event_dialog.dart';
import 'package:valley_students_and_teachers/widgets/event_dialog.dart';
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
  @override
  void initState() {
    super.initState();
    getEvents();
  }

  List<CalendarEvent> events = [];
  bool hasLoaded = false;

  getEvents() async {
    await FirebaseFirestore.instance
        .collection('Events')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        events.add(CalendarEvent(
            eventName: doc['name'],
            eventDate: doc['date'].toDate(),
            eventTextStyle: const TextStyle(fontFamily: 'Bold')));
      }

      setState(() {
        hasLoaded = true;
      });
    });
  }

  bool isSchedule = true;
  bool isAvailability = false;
  bool isworkLoad = false;

  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  String myName = '';

  String myId = '';

  String myRole = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isworkLoad
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddEventDialog();
                  },
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
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
            StreamBuilder<DocumentSnapshot>(
                stream: userData,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else if (snapshot.hasError) {
                    return const SizedBox();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  dynamic data = snapshot.data;
                  return Container(
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
                          text: data['name'],
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextBold(
                          text: data['idNumber'].split('@')[0],
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
                              isworkLoad = false;
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
                              isworkLoad = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.schedule,
                                color:
                                    isAvailability ? Colors.white : Colors.grey,
                                size: 48,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextBold(
                                text: 'Availability',
                                fontSize: 24,
                                color:
                                    isAvailability ? Colors.white : Colors.grey,
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
                              isAvailability = false;
                              isSchedule = false;
                              isworkLoad = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work,
                                color: isworkLoad ? Colors.white : Colors.grey,
                                size: 48,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextBold(
                                text: 'Workload',
                                fontSize: 24,
                                color: isworkLoad ? Colors.white : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            isSchedule
                ? schedule()
                : isworkLoad
                    ? workload()
                    : availability(),
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
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .where('membersId',
                      arrayContains: FirebaseAuth.instance.currentUser!.uid)
                  .where('creator',
                      isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton(
                      icon: Badge(
                        backgroundColor: Colors.red,
                        label: TextRegular(
                            text: data.docs.length.toString(),
                            fontSize: 14,
                            color: Colors.white),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                      itemBuilder: (context) {
                        return [
                          for (int i = 0; i < data.docs.length; i++)
                            PopupMenuItem(
                                onTap: () {
                                  chatroomDialog(data.docs[i].id);
                                  chatroomDialog(data.docs[i].id);
                                },
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.notifications,
                                    color: Colors.black,
                                  ),
                                  title: TextBold(
                                      text:
                                          'You have been added to a consultation',
                                      fontSize: 16,
                                      color: Colors.black),
                                  subtitle: TextRegular(
                                      text: DateFormat.yMMMd().add_jm().format(
                                          data.docs[i]['dateTime'].toDate()),
                                      fontSize: 12,
                                      color: Colors.black),
                                ))
                        ];
                      },
                    ));
              }),
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
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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

  Widget availability() {
    return StreamBuilder<DocumentSnapshot>(
        stream: userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              width: 800,
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
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
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Chats')
                        .where('membersId',
                            arrayContains:
                                FirebaseAuth.instance.currentUser!.uid)
                        .where('creator',
                            isNotEqualTo:
                                FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                        );
                      }

                      final data = snapshot.requireData;
                      return Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton(
                            icon: Badge(
                              backgroundColor: Colors.red,
                              label: TextRegular(
                                  text: data.docs.length.toString(),
                                  fontSize: 14,
                                  color: Colors.white),
                              child: const Icon(
                                Icons.notifications,
                                color: Colors.black,
                                size: 32,
                              ),
                            ),
                            itemBuilder: (context) {
                              return [
                                for (int i = 0; i < data.docs.length; i++)
                                  PopupMenuItem(
                                      onTap: () {
                                        chatroomDialog(data.docs[i].id);
                                        chatroomDialog(data.docs[i].id);
                                      },
                                      child: ListTile(
                                        leading: const Icon(
                                          Icons.notifications,
                                          color: Colors.black,
                                        ),
                                        title: TextBold(
                                            text:
                                                'You have been added to a consultation',
                                            fontSize: 16,
                                            color: Colors.black),
                                        subtitle: TextRegular(
                                            text: DateFormat.yMMMd()
                                                .add_jm()
                                                .format(data.docs[i]['dateTime']
                                                    .toDate()),
                                            fontSize: 12,
                                            color: Colors.black),
                                      ))
                              ];
                            },
                          ));
                    }),
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

  final msgController = TextEditingController();

  chatroomDialog(String docId) {
    final Stream<DocumentSnapshot> chatrooms =
        FirebaseFirestore.instance.collection('Chats').doc(docId).snapshots();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 500,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton(
                        icon: const Icon(
                          Icons.groups_2_outlined,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: TextRegular(
                                text: 'John Doe',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  StreamBuilder<DocumentSnapshot>(
                      stream: chatrooms,
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Expanded(child: SizedBox());
                        } else if (snapshot.hasError) {
                          return const Expanded(child: SizedBox());
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        dynamic data = snapshot.data;
                        List msgs = data['messages'];

                        return Expanded(
                          child: SizedBox(
                            child: ListView.separated(
                              itemCount: msgs.length,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(Icons.message),
                                  title: TextRegular(
                                    text: msgs[index]['msg'],
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  subtitle: TextRegular(
                                    text: msgs[index]['name'],
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  trailing: TextRegular(
                                    text: DateFormat.yMMMd()
                                        .add_jm()
                                        .format(msgs[index]['date'].toDate()),
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                  const Divider(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextFormField(
                      controller: msgController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('Chats')
                                .doc(docId)
                                .update({
                              'messages': FieldValue.arrayUnion([
                                {
                                  'name': myName,
                                  'userId':
                                      FirebaseAuth.instance.currentUser!.uid,
                                  'msg': msgController.text,
                                  'date': DateTime.now(),
                                }
                              ]),
                            });
                            msgController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget workload() {
    return Center(
      child: SizedBox(
        width: 500,
        height: 500,
        child: CellCalendar(
          events: events,
          onCellTapped: (date) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Events')
                        .where('year', isEqualTo: date.year)
                        .where('month', isEqualTo: date.month)
                        .where('day', isEqualTo: date.day)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print('error');
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                        );
                      }

                      final data = snapshot.requireData;
                      return EventDialog(
                        events: [
                          for (int i = 0; i < data.docs.length; i++)
                            {
                              'title': data.docs[i]['name'],
                              'date': DateFormat.yMMMd()
                                  .add_jm()
                                  .format(data.docs[i]['date'].toDate()),
                              'id': data.docs[i].id,
                              'details': data.docs[i]['details'],
                            },
                        ],
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }
}

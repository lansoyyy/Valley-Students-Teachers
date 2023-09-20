import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/widgets/text_widget.dart';
import 'package:valley_students_and_teachers/widgets/toast_widget.dart';

class AdminStudentsScreen extends StatefulWidget {
  const AdminStudentsScreen({super.key});

  @override
  State<AdminStudentsScreen> createState() => _AdminStudentsScreenState();
}

class _AdminStudentsScreenState extends State<AdminStudentsScreen> {
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(250, 75, 250, 75),
            child: Column(
              children: [
                TextBold(
                  text: 'Student Reversations',
                  fontSize: 24,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Reservations')
                        .where('status', isEqualTo: 'Pending')
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
                      return Expanded(
                        child: SizedBox(
                          width: 500,
                          height: 300,
                          child: Card(
                            child: ListView.builder(
                              itemCount: data.docs.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  tileColor: Colors.white,
                                  leading: const Icon(Icons.book),
                                  title: TextBold(
                                      text: data.docs[index]['name'],
                                      fontSize: 18,
                                      color: Colors.black),
                                  subtitle: TextBold(
                                      text:
                                          '${data.docs[index]['date']} - ${data.docs[index]['time']}',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Reservations')
                                          .doc(data.docs[index].id)
                                          .update({'status': 'Accepted'});
                                      showToast('Reservation approved!');
                                    },
                                    icon: const Icon(
                                      Icons.check_circle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          )),
    );
  }
}

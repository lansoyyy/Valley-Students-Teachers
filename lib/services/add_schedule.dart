import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addSchedule(name, section, day, timeFrom, timeTo) async {
  final docUser = FirebaseFirestore.instance.collection('Schedules').doc();

  final json = {
    'name': name,
    'section': section,
    'day': day,
    'timeFrom': timeFrom,
    'timeTo': timeTo,
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addReservation(name, date, time) async {
  final docUser = FirebaseFirestore.instance.collection('Reservations').doc();

  final json = {
    'name': name,
    'date': date,
    'time': time,
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'dateTime': DateTime.now(),
    'status': 'Pending'
  };

  await docUser.set(json);
}

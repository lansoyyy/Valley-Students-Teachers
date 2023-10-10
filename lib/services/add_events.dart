import 'package:cloud_firestore/cloud_firestore.dart';

Future addEvents(name, details, date, day, month, year) async {
  final docUser = FirebaseFirestore.instance.collection('Events').doc();

  final json = {
    'name': name,
    'details': details,
    'date': date,
    'day': day,
    'month': month,
    'year': year,
  };

  await docUser.set(json);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(name, idNumber, password, role) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'idNumber': idNumber,
    'password': password,
    'role': role,
    'avail': '',
    'isActive': true
  };

  await docUser.set(json);
}

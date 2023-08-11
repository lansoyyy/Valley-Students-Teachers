import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addChatroom(List members) async {
  final docUser = FirebaseFirestore.instance.collection('Chats').doc();

  final json = {
    'messages': [],
    'members': [],
    'creator': FirebaseAuth.instance.currentUser!.uid,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}

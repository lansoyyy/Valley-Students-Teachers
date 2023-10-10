import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/widgets/text_widget.dart';
import 'package:valley_students_and_teachers/widgets/textfield_widget.dart';
import 'package:valley_students_and_teachers/widgets/toast_widget.dart';

class EventDialog extends StatefulWidget {
  final List<Map<String, dynamic>> events;

  const EventDialog({super.key, required this.events});

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  Widget wids(id, name) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const SizedBox();
    }

    return SizedBox(
      width: 100,
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: ((context) {
                  final formKey = GlobalKey<FormState>();
                  final TextEditingController emailController =
                      TextEditingController();

                  return AlertDialog(
                    backgroundColor: Colors.grey[100],
                    title: TextRegular(
                      text: 'Editing event',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    content: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFieldWidget(
                            hint: name,
                            label: 'Event Name',
                            controller: emailController,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        child: TextRegular(
                          text: 'Cancel',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: (() async {
                          try {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            await FirebaseFirestore.instance
                                .collection('Events')
                                .doc(id)
                                .update({'name': emailController.text});
                          } catch (e) {
                            showToast(e);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        }),
                        child: TextBold(
                          text: 'Continue',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text(
                          'Delete Confirmation',
                          style: TextStyle(
                              fontFamily: 'QBold', fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'Are you sure you want delete this data?',
                          style: TextStyle(fontFamily: 'QRegular'),
                        ),
                        actions: <Widget>[
                          MaterialButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                  fontFamily: 'QRegular',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              await FirebaseFirestore.instance
                                  .collection('Events')
                                  .doc(id)
                                  .delete();
                            },
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  fontFamily: 'QRegular',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ));
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('List of Workload'),
      content: SizedBox(
        width: 300,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.events.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.events[index]['title']),
                    Text(
                      'Description: ${widget.events[index]['details']}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                subtitle: Text(widget.events[index]['date']),
                trailing: wids(
                    widget.events[index]['id'], widget.events[index]['title']));
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

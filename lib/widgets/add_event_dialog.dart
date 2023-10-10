import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valley_students_and_teachers/services/add_events.dart';
import 'package:valley_students_and_teachers/widgets/text_widget.dart';

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({super.key});

  @override
  _AddEventDialogState createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  List<String> districts = [
    'For All Disctricts',
    'St. John',
    'St. Luke',
    'St. Mark',
    'St. Matthias',
    'St. Matthew',
    'St. Paul',
  ];
  String district = 'St. John';

  int dropdownValue = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Workload'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Workload Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Workload Description',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Workload Date: '),
                Expanded(
                  child: TextButton(
                    child: Builder(builder: (context) {
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      final String formattedDate =
                          formatter.format(_selectedDate);
                      return Text(
                        formattedDate.toString(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () {
            // Do something with the input data, such as saving it to a database
            String title = _titleController.text;
            String description = _descriptionController.text;
            DateTime date = _selectedDate;

            addEvents(
                title, description, date, date.day, date.month, date.year);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

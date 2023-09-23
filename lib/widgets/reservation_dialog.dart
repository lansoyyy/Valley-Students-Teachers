import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:valley_students_and_teachers/services/add_reservation.dart';

class ReservationDialog extends StatefulWidget {
  const ReservationDialog({super.key});

  @override
  _ReservationDialogState createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Make a Reservation',
        style: TextStyle(
          fontFamily: 'QRegular',
          fontSize: 18,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name for the reservation';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Reservation Name',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : 'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                  style: const TextStyle(
                    fontFamily: 'QRegular',
                    fontSize: 14,
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    _pickDate(context);
                  },
                  child: const Text(
                    'Pick Date',
                    style: TextStyle(
                      fontFamily: 'QRegular',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime == null
                      ? 'Select Time'
                      : 'Time: ${_selectedTime!.format(context)}',
                  style: const TextStyle(
                    fontFamily: 'QRegular',
                    fontSize: 14,
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    _pickTime(context);
                  },
                  child: const Text(
                    'Pick Time',
                    style: TextStyle(
                      fontFamily: 'QRegular',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
                fontFamily: 'QRegular', fontSize: 14, color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black)),
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                _selectedDate != null &&
                _selectedTime != null) {
              addReservation(
                  _nameController.text,
                  DateFormat('yyyy-MM-dd').format(_selectedDate!),
                  _selectedTime!.format(context));

              launchEmail(
                  mailPath: 'roseanntejanoo3021@gmail.com',
                  body:
                      'Reservation Name: ${_nameController.text}\nI wanted to make a reservation on ${DateFormat('yyyy-MM-dd').format(_selectedDate!)} at _selectedTime!.format(context))',
                  subject: 'Requesting a reservation');
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            'Make Reservation',
            style: TextStyle(
              fontFamily: 'QRegular',
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void launchEmail(
      {String? subject, String? body, required String mailPath}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mailPath,
      queryParameters: {'subject': subject ?? '', 'body': body ?? ''},
    );
    if (await canLaunchUrlString(emailLaunchUri.toString())) {
      await launchUrlString(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}

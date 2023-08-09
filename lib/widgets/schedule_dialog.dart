import 'package:flutter/material.dart';
import 'package:valley_students_and_teachers/services/add_schedule.dart';
import 'package:valley_students_and_teachers/widgets/toast_widget.dart';

class ScheduleDialog extends StatefulWidget {
  const ScheduleDialog({super.key});

  @override
  _ScheduleDialogState createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();

  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Make a Schedule',
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
                  return 'Please enter a name for the laboratory';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Reservation Name',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _sectionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name of section';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Section Name',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dayController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name of the day';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: '(ex. Monday/Tuesday/Wednesday...)',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime1 == null
                      ? 'Select Time From'
                      : 'Time: ${_selectedTime1!.format(context)}',
                  style: const TextStyle(
                    fontFamily: 'QRegular',
                    fontSize: 14,
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    _pickTime1(context);
                  },
                  child: const Text(
                    'Time From',
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
                      ? 'Select Time To'
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
                    'Time To',
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
                _selectedTime1 != null &&
                _selectedTime != null) {
              addSchedule(
                  _nameController.text,
                  _sectionController.text,
                  _dayController.text,
                  _selectedTime1!.format(context),
                  _selectedTime!.format(context));
              Navigator.of(context).pop();
              showToast('Schedule Added!');
            }
          },
          child: const Text(
            'Continue',
            style: TextStyle(
              fontFamily: 'QRegular',
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
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

  Future<void> _pickTime1(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime1 ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime1 = pickedTime;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_app/resources/firestor_methods.dart';
import 'package:zoom_app/utils/colors.dart';
import 'package:zoom_app/widgets/custom_button.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({Key? key}) : super(key: key);

  @override
  _ScheduleMeetingScreenState createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  final TextEditingController _meetingNameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Meeting Name:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _meetingNameController,
              decoration: const InputDecoration(
                hintText: 'Enter meeting name',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Date:',
              style: TextStyle(fontSize: 18),
            ),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Text(
                DateFormat.yMd().format(_selectedDate),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Time:',
              style: TextStyle(fontSize: 18),
            ),
            InkWell(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (pickedTime != null && pickedTime != _selectedTime) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
              child: Text(
                _selectedTime.format(context),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
                text: 'Schedule Meeting',
                onPressed: () {
                  _scheduleMeeting();
                  Navigator.pop(context);
                },
                btncolor: buttonColor)
          ],
        ),
      ),
    );
  }

  void _scheduleMeeting() {
    String meetingName = _meetingNameController.text;
    DateTime scheduledDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    FirestoreMethods().scheduleMeeting(
      meetingName: meetingName,
      scheduledDateTime: scheduledDateTime,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Meeting scheduled successfully!'),
      ),
    );
  }
}

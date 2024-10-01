// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:workshop_mobi/controller/teacher/add_workshop_controller.dart';
import 'package:workshop_mobi/model/workshopResquest.dart';
import 'package:intl/intl.dart';

class LocationPage extends StatefulWidget {
  const LocationPage(
      {Key? key,
      required this.controller,
      required this.token,
      required Null Function(CourseRequest workshop) onLocationChanged})
      : super(key: key);
  final String token;
  final AddWorkshopController controller; // Add this line

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController areaController = TextEditingController();
  final TextEditingController scheduleDateController = TextEditingController();

  DateTime? selectedScheduleDate;

  Future<void> _selectedScheduleDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: (widget.controller.startDate)
          .value, // Extract DateTime value from Rx stream
      lastDate: (widget.controller.endDate).value,
    );
    if (picked != null && picked != selectedScheduleDate) {
      if (picked.isAfter((widget.controller.startDate).value) &&
          picked.isBefore((widget.controller.endDate).value)) {
        setState(() {
          selectedScheduleDate = picked;
          scheduleDateController.text = DateFormat('yyyy-MM-dd').format(picked);
          updateController(); // Call updateController here
        });
      } else {
        // Show an error message or handle the case where the selected date
        // is outside the range of Start Date and End Date
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Schedule Date'),
            content: Text(
                'Schedule Date must be within the range of Start Date and End Date.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers
    areaController.addListener(updateController);
  }

  void updateController() {
    if (areaController.text.isNotEmpty && selectedScheduleDate != null) {
      widget.controller.addCourseLocation(
        area: areaController.text,
        scheduleDate: selectedScheduleDate!,
      );

      print(
          'widget.controller.courseLocation (from controller): ${widget.controller.courseLocation}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: areaController,
              decoration: const InputDecoration(
                labelText: 'Area',
                hintText: 'Enter Area',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Area cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: scheduleDateController,
              onTap: () => _selectedScheduleDate(context),
              decoration: InputDecoration(
                labelText: 'Schedule Date', 
                hintText: 'Select Schedule Date',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

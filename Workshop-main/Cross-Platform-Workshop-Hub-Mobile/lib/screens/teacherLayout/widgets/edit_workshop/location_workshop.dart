// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/controller/teacher/edit_profile_teacher_controller.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:intl/intl.dart';
import 'package:workshop_mobi/model/workshopUpdateRequest.dart';

class LocationPage extends StatefulWidget {
  const LocationPage(
      {Key? key,
      required this.controller,
      required this.token,
      required Null Function(CourseUpdateRequest workshop) onLocationChanged,
      required this.workshopId})
      : super(key: key);
  final String token;
  final int workshopId;

  final EditWorkshopController controller; // Add this line

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController scheduleDateController = TextEditingController();

  DateTime? selectedScheduleDate;

  Future<void> _selectedScheduleDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null && picked != selectedScheduleDate) {
      setState(() {
        selectedScheduleDate = picked;
        scheduleDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeWorkshopData();
  }

  Future<void> fetchWorkshopData(int workshopId, String token) async {
    try {
      List<CourseResponses> workshopList =
          await ApiService().getWorkshopById(workshopId, token);

      // Check if the list is not empty before accessing the first item
      if (workshopList.isNotEmpty) {
        CourseResponses workshop = workshopList.first;

        // Set initial values for the controllers
        setState(() {
          idController.text = workshop.id.toString();
          areaController.text = workshop.courseLocations[0].area;
          selectedScheduleDate = workshop.courseLocations[0].schedule_Date;
          scheduleDateController.text =
              DateFormat('yyyy-MM-dd').format(selectedScheduleDate!);
        });

        updateController();
      } else {
        // Handle the case where the list is empty
        print('Empty workshop list');
      }
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error fetching workshop data: $error');
    }
  }

  Future<void> _initializeWorkshopData() async {
    try {
      await fetchWorkshopData(widget.workshopId, widget.token);
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error initializing workshop data: $error');
    }
  }

  void updateController() {
    // Check if both area and scheduleDate are not empty
    if (idController.text.isNotEmpty &&
        areaController.text.isNotEmpty &&
        selectedScheduleDate != null) {
      widget.controller.addcourseLocations(
        id: int.tryParse(idController.text) ?? 0,
        area: areaController.text,
        scheduleDate: selectedScheduleDate!,
      );

      print(
          'widget.controller.courseLocation (from controller): ${widget.controller.courseLocations}');
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
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Area',
                hintText: 'Enter Area',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color:
                    Colors.grey, // Set the text color to grey for a muted look
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: scheduleDateController,
              enabled: false,
              onTap: () => _selectedScheduleDate(context),
              decoration: InputDecoration(
                labelText: 'Schedule Date',
                hintText: 'Select Schedule Date',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color:
                    Colors.grey, // Set the text color to grey for a muted look
              ),
            ),
          ],
        ),
      ),
    );
  }
}

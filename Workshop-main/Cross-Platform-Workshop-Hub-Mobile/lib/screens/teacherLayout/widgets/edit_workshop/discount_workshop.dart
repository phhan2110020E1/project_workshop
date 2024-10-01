// ignore_for_file: library_private_types_in_public_api, unnecessary_brace_in_string_interps, avoid_print, prefer_const_constructors, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/controller/teacher/edit_profile_teacher_controller.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:intl/intl.dart';
import 'package:workshop_mobi/model/workshopUpdateRequest.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({
    Key? key,
    required this.controller,
    required this.token,
    required Null Function(CourseUpdateRequest workshop) onDiscountChanged,
    required this.workshopId,
  }) : super(key: key);

  final String token;
  final int workshopId;
  final EditWorkshopController controller;

  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController remainingUsesController = TextEditingController();
  final TextEditingController valueDiscountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController redemptionDateController =
      TextEditingController();

  DateTime? selectedRedemptionDate;

  Future<void> _selectedRedemptionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null && picked != selectedRedemptionDate) {
      setState(() {
        selectedRedemptionDate = picked;
        redemptionDateController.text = DateFormat('yyyy-MM-dd').format(picked);
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
        print('Workshop Name: ${workshop}');
        // Update the state with the fetched workshop data
        setState(() {
          nameController.text = workshop.discountDTOS[0].name;
          descriptionController.text = workshop.discountDTOS[0].description;
          quantityController.text =
              workshop.discountDTOS[0].quantity.toString();
          idController.text = workshop.discountDTOS[0].id.toString();
          remainingUsesController.text =
              workshop.discountDTOS[0].remainingUses.toString();
          valueDiscountController.text =
              workshop.discountDTOS[0].valueDiscount.toString();
          redemptionDateController.text = DateFormat('yyyy-MM-dd')
              .format(workshop.discountDTOS[0].redemptionDate);

          // Update the controllers in your EditWorkshopController
          widget.controller.addDiscountDTO(
            id: int.tryParse(idController.text) ?? 0,
            quantity: int.tryParse(quantityController.text) ?? 0,
            redemptionDate: selectedRedemptionDate ?? DateTime.now(),
            valueDiscount: int.tryParse(valueDiscountController.text) ?? 0,
            name: nameController.text,
            description: descriptionController.text,
            remainingUses: int.tryParse(remainingUsesController.text) ?? 0,
          );
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
    if (idController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        valueDiscountController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        remainingUsesController.text.isNotEmpty) {
      widget.controller.addDiscountDTO(
        id: int.tryParse(idController.text) ?? 0,
        quantity: int.tryParse(quantityController.text) ?? 0,
        redemptionDate: selectedRedemptionDate ?? DateTime.now(),
        valueDiscount: int.tryParse(valueDiscountController.text) ?? 0,
        name: nameController.text,
        description: descriptionController.text,
        remainingUses: int.tryParse(remainingUsesController.text) ?? 0,
      );

      print(
          'quantity (from controller): ${widget.controller.discountDTOS[0]['quantity']}');
      print(
          'name (from controller): ${widget.controller.discountDTOS[0]['name']}');

      print(
          'redemptionDate (from controller): ${widget.controller.discountDTOS[0]['redemptionDate']}');
      print(
          'valueDiscount (from controller): ${widget.controller.discountDTOS[0]['valueDiscount']}');
      print(
          'description (from controller): ${widget.controller.discountDTOS[0]['description']}');
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
            TextField(
              controller: nameController,
              enabled: false,
              onChanged: (value) {
                // Gọi hàm updateController khi giá trị thay đổi
                updateController();
              },
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter Name',
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
              controller: descriptionController,
              enabled: false,
              onChanged: (value) {
                // Gọi hàm updateController khi giá trị thay đổi
                updateController();
              },
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter Description',
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
              controller: redemptionDateController,
              enabled: false,
              onChanged: (value) {
                // Gọi hàm updateController khi giá trị thay đổi
                updateController();
              },
              onTap: () => _selectedRedemptionDate(context),
              decoration: InputDecoration(
                labelText: 'Redemption Date',
                hintText: 'Redemption Date',
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
              controller: valueDiscountController,
              enabled: false,
              onChanged: (value) {
                // Gọi hàm updateController khi giá trị thay đổi
                updateController();
              },
              decoration: InputDecoration(
                labelText: 'Value Discount ',
                hintText: 'Value Discount',
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
              controller: quantityController,
              enabled: false,
              onChanged: (value) {
                // Gọi hàm updateController khi giá trị thay đổi
                updateController();
                print('Value changed: $value');
              },
              decoration: InputDecoration(
                labelText: 'Quantity  ',
                hintText: 'Quantity ',
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

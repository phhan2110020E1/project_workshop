// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_local_variable

import 'package:flutter/material.dart';

class DiscountWidget extends StatefulWidget {
  final String paymentMethod;

  const DiscountWidget({Key? key, required this.paymentMethod})
      : super(key: key);

  @override
  _DiscountWidgetState createState() => _DiscountWidgetState();
}

class _DiscountWidgetState extends State<DiscountWidget> {
  TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discount for ${widget.paymentMethod} Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'You are paying with ${widget.paymentMethod}.',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: discountController,
              decoration: const InputDecoration(
                labelText: 'Enter Discount Code',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle discount application logic here
                String discountCode = discountController.text;
                // Apply the discount and perform any necessary actions
                // For simplicity, I'm just printing the discount code here
                // print('Discount Code Applied: $discountCode');
              },
              child: const Text('Apply Discount'),
            ),
          ],
        ),
      ),
    );
  }
}
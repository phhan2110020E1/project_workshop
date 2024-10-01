// ignore_for_file: unnecessary_string_interpolations, avoid_print, use_build_context_synchronously, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/widgets/paypal.dart';

class DepositButton extends StatelessWidget {
  const DepositButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            List<String> denominations = [
              '10',
              '20',
              '50',
              '100',
              '200',
              '500'
            ];
            String selectedDenomination =
                denominations.first; // Default to the first denomination

            return AlertDialog(
              title: const Text('Deposit Information'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.5,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: denominations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        selectedDenomination = denominations[index];
                        Navigator.of(context).pop();
                        handleDeposit(context, selectedDenomination);
                      },
                      child: Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.attach_money), // Dollar icon
                              const SizedBox(
                                  height: 5), // Spacing between icon and text
                              Text(
                                  '${denominations[index]}'), // Denomination value
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: const Text(
        'Deposit Now',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  void handleDeposit(BuildContext context, String selectedDenomination) async {
    final storage = const FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'token');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PayPalNative(
          value: double.parse(selectedDenomination),
          token: accessToken,
        ),
      ),
    );
  }
}
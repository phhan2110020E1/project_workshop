// ignore_for_file: unnecessary_string_interpolations, avoid_print, use_build_context_synchronously, prefer_const_declarations, prefer_const_constructors

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/api/api_service.dart';

class WithdrawButton extends StatelessWidget {
  const WithdrawButton({
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
              title: const Text('Withdraw Information'),
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
                        handleWithdraw(context, selectedDenomination);
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
        'Withdraw Now',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Success',
           message: message,
          contentType: ContentType.success,
          inMaterialBanner: true,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
      ),
    );
  }

  void _showUnsuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Unsuccess',
           message:message,
          contentType: ContentType.failure,
          inMaterialBanner: true,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
      ),
    );
  }

  Future<void> handleWithdraw(
      BuildContext context, String selectedDenomination) async {
    print('Withdraw $selectedDenomination VND');
    final storage = const FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'token');

    // Call your withdraw API here using the provided token and denomination
    try {
     final ApiService apiService = ApiService();

      // Assuming your API function is named "withdraw"
      var statusCode = await apiService.withdraw(double.parse(selectedDenomination), accessToken);

      // Check the status code and handle accordingly
      if (statusCode == 200) {
        // Successful withdrawal
       _showSuccessSnackBar(context,'Withdrawal request sent successfully. Please wait for approval.');
        
      } else {
        // Handle other status codes
       _showUnsuccessSnackBar(context,' Withdrawal failed. Please try again.');
      }
    } catch (error) {
      // Handle API call errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    }
  }
}
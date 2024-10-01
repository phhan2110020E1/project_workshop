// Import the necessary packages
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_paypal_native/flutter_paypal_native.dart';
import 'package:flutter_paypal_native/models/custom/currency_code.dart';
import 'package:flutter_paypal_native/models/custom/environment.dart';
import 'package:flutter_paypal_native/models/custom/order_callback.dart';
import 'package:flutter_paypal_native/models/custom/user_action.dart';
import 'package:flutter_paypal_native/str_helper.dart';
import 'package:flutter_paypal_native/models/custom/purchase_unit.dart';
import 'package:workshop_mobi/api/api_service.dart';

class PayPalNative extends StatefulWidget {
  final double value;
  final String? token;
  const PayPalNative({Key? key, required this.value, required this.token})
      : super(key: key);

  @override
  State<PayPalNative> createState() => _PayPalNativeState();
}

class _PayPalNativeState extends State<PayPalNative> {
  final _flutterPaypalNativePlugin = FlutterPaypalNative.instance;
  final ApiService apiService = ApiService();
  List<String> logQueue = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initPayPal();
  }

  void initPayPal() async {
    setState(() {
      isLoading = true;
    });

    FlutterPaypalNative.isDebugMode = true;
    await _flutterPaypalNativePlugin.init(
      returnUrl: "com.workshop.infinity.connect://paypalpay",
      clientID:
          "AX3wyBHHGct3PPoIpC1DUhfa0YwIB69w-MM9SqQDyPD7jIqrYrVL_oXHbTXWcgd_hTkuLXTvOXf_4MsR",
      payPalEnvironment: FPayPalEnvironment.sandbox,
      currencyCode: FPayPalCurrencyCode.usd,
      action: FPayPalUserAction.payNow,
    );

    // Callbacks for payment
    _flutterPaypalNativePlugin.setPayPalOrderCallback(
      callback: FPayPalOrderCallback(
        onCancel: () {
        },
        onSuccess: (data) async {
          _flutterPaypalNativePlugin.removeAllPurchaseItems();
    
        //  Navigator.pop(context);
          int valueResult = await apiService.deposit(widget.value, widget.token);
          if(valueResult == 202){
              Navigator.pop(context);
          }
        },
        onError: (data) {
          // An error occurred
          showResult("Error: ${data.reason}");
        },
        onShippingChange: (data) {
          // The user updated the shipping address
          showResult(
            "Shipping change: ${data.shippingChangeAddress?.adminArea1 ?? ""}",
          );
        },
      ),
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayPal Method'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Giá Trị Thanh Toán',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '\$${widget.value}',
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Bạn đang tiến hành thanh toán \$${widget.value} qua PayPal.',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_flutterPaypalNativePlugin.canAddMorePurchaseUnit) {
                          _flutterPaypalNativePlugin.addPurchaseUnit(
                            FPayPalPurchaseUnit(
                              amount: widget.value,
                              referenceId: FPayPalStrHelper.getRandomString(16),
                            ),
                          );
                        }
                        _flutterPaypalNativePlugin.makeOrder(
                          action: FPayPalUserAction.payNow,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                            255, 35, 168, 230), // Màu đỏ cho nút hủy
                      ),
                      child: const Text(
                        'Payment confirmation',
                        style: TextStyle(
                          color: Colors.white, // Màu chữ trắng
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Xử lý khi nút hủy được nhấn
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Màu đỏ cho nút hủy
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white, // Màu chữ trắng
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    for (String t in logQueue) Text(t),
                  ],
                ),
              ),
      ),
    );
  }

  void showResult(String text) {
    logQueue.add(text);
    setState(() {});
  }
}

// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_paypal_native/flutter_paypal_native.dart';
import 'package:flutter_paypal_native/models/custom/currency_code.dart';
import 'package:flutter_paypal_native/models/custom/environment.dart';
import 'package:flutter_paypal_native/models/custom/order_callback.dart';
import 'package:flutter_paypal_native/models/custom/user_action.dart';
import 'package:flutter_paypal_native/str_helper.dart';
import 'package:flutter_paypal_native/models/custom/purchase_unit.dart';

class PayPalPaymentButton extends StatefulWidget {
  final double value;
  final Function(bool, String) onResult;

  const PayPalPaymentButton({
    Key? key,
    required this.value,
    required this.onResult,
  }) : super(key: key);

  @override
  _PayPalPaymentButtonState createState() => _PayPalPaymentButtonState();
}

class _PayPalPaymentButtonState extends State<PayPalPaymentButton> {
  final _flutterPaypalNativePlugin = FlutterPaypalNative.instance;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initPayPal();
  }

  Future<void> _initPayPal() async {
    setState(() {
      _isLoading = true;
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

    setState(() {
      _isLoading = false;
    });
  }

  void _makePayment() {
    if (!_isLoading && _flutterPaypalNativePlugin.canAddMorePurchaseUnit) {
       setState(() {
      _isLoading = true; // Set loading to true just before making the payment
    });
      _flutterPaypalNativePlugin.addPurchaseUnit(
        FPayPalPurchaseUnit(
          amount: widget.value,
          referenceId: FPayPalStrHelper.getRandomString(16),
        ),
      );

      _flutterPaypalNativePlugin.makeOrder(
        action: FPayPalUserAction.payNow,
      );

      _flutterPaypalNativePlugin.setPayPalOrderCallback(
        callback: FPayPalOrderCallback(
          onCancel: () {
             _isLoading = false;
             _flutterPaypalNativePlugin.removeAllPurchaseItems();
            widget.onResult(false, "Payment Cancelled");
          },
          onSuccess: (data) async {
             _isLoading = false;
            _flutterPaypalNativePlugin.removeAllPurchaseItems();
              widget.onResult(true, "Payment Successful");
          },
          onError: (data) {
             _isLoading = false;
             _flutterPaypalNativePlugin.removeAllPurchaseItems();
            widget.onResult(false, "Error: ${data.reason}");
          },
          // Add other necessary callbacks if needed
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _makePayment,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Customize button style as needed
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text('Pay \$${widget.value.toStringAsFixed(2)} With PayPal',style: const TextStyle(
                            color: Colors.white,
                          ),),
             
    );
  }
}

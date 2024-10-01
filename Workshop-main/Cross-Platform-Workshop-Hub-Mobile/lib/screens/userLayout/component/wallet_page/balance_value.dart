import 'package:flutter/material.dart';
import 'package:workshop_mobi/model/student/wallet.dart';

class BalanceValue extends StatefulWidget {
  const BalanceValue({
    super.key,
    required this.fem,
    required this.wallet,
    required this.ffem,
  });
  final double fem;
  final walletResponses? wallet;
  final double ffem;

  @override
  State<BalanceValue> createState() => _BalanceValueState();
}

class _BalanceValueState extends State<BalanceValue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          0 * widget.fem, 0 * widget.fem, 0 * widget.fem, 0 * widget.fem),
      height: 35 * widget.fem,
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Text(
                '${widget.wallet?.current_balance ?? 0}',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 42 * widget.ffem,
                  fontWeight: FontWeight.bold,
                  height: 0.8125 * widget.ffem / widget.fem,
                  letterSpacing:
                      0.0320000005 * widget.fem,
                  color: const Color(0xff0f172a),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
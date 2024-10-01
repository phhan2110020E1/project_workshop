// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:workshop_mobi/model/student/wallet.dart';
import 'package:timeago/timeago.dart' as timeago;

class LastTransaction extends StatelessWidget {
  final double fem;
  final double ffem;
  final walletResponses wallet;

  const LastTransaction({
    super.key,
    required this.fem,
    required this.ffem,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0 * fem,
      top:MediaQuery.of(context).size.height / 3,
          height: 400* fem,

      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 0 * fem, 42 * fem),
          width: 430 * fem,
          height: 668 * fem,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50 * fem),
              topRight: Radius.circular(50 * fem),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x3f000000),
                offset: Offset(0 * fem, 4 * fem),
                blurRadius: 2 * fem,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(ffem: ffem, fem: fem),
              if (wallet.transactions.isEmpty)
                Text(
                  'There are no transactions yet',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff9294a3),
                  ),
                )
              else
                 Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var transaction in wallet.transactions)
                          Container(
                            margin: EdgeInsets.only(bottom: 10 * fem),
                            padding: EdgeInsets.symmetric(
                              horizontal: 25 * fem,
                              vertical: 15.33 * fem,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 19 * fem),
                                  width: 50 * fem,
                                  height: 50 * fem,
                                  child: Image.asset(
                                    'lib/assets/neo.png',
                                    width: 50 * fem,
                                    height: 50 * fem,
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction.type ?? '',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333 * ffem / fem,
                                          letterSpacing: 0.0180000003 * fem,
                                          color: Color(0xff0f172a),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${transaction.status}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 7 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5 * ffem / fem,
                                          color:
                                              Color.fromARGB(255, 88, 102, 211),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${transaction.amount ?? 0}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5 * ffem / fem,
                                          color: Color(0xff26273c),
                                        ),
                                      ),
                                      Text(
                                        timeago.format(
                                          transaction.transaction_date,
                                          locale: 'en',
                                        ),
                                        textAlign: TextAlign.right,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5 * ffem / fem,
                                          color: Color(0xff9294a3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.ffem,
    required this.fem,
  });

  final double ffem;
  final double fem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Last Transaction',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20 * ffem,
            fontWeight: FontWeight.w500,
            height: 1.5 * ffem / fem,
            color: Color(0xff191c32),
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/student/wallet.dart';
import 'package:workshop_mobi/screens/userLayout/component/wallet_page/back_ground.dart';
import 'package:workshop_mobi/screens/userLayout/component/wallet_page/deposit_button.dart';
import 'package:workshop_mobi/screens/userLayout/component/wallet_page/last_transaction.dart';

import '../component/wallet_page/balance_value.dart';

class StudentWalletPage extends StatefulWidget {
  final String? token;
  const StudentWalletPage({Key? key, required this.token}) : super(key: key);
  @override
  State<StudentWalletPage> createState() => _StudentWalletPageState();
}

class _StudentWalletPageState extends State<StudentWalletPage> {
  late Future<walletResponses?> _walletFuture;

  @override
  void initState() {
    super.initState();
    _walletFuture = fetchWalletResponses(widget.token!);
  }

  Future<walletResponses?> fetchWalletResponses(String token) async {
    try {
      if (token.isNotEmpty) {
        final apiService = ApiService();
        final wallet = await apiService.walletStudent(token);
        print(wallet);
        return wallet;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching walletResponses: $e');
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
 
    return FutureBuilder<walletResponses?>(
      future: _walletFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading wallet: ${snapshot.error}'));
        } else {
          walletResponses? wallet = snapshot.data;
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: 770 * fem,
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Stack(
                  children: [
                    const Background(),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    19 * fem, 10 * fem, 32 * fem, 555 * fem),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                                      height: 27 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Balance',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 22 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3 * ffem / fem,
                                              letterSpacing: 0.0200000003 * fem,
                                              color: Color(0xff0f172a),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BalanceValue(fem: fem, wallet: wallet, ffem: ffem),
                                    Container(
                                      padding: const EdgeInsets.all(2.0),
                                      margin: const EdgeInsets.only(
                                        left: 0,
                                        right: 25,
                                        top: 0,
                                      ),
                                      child: DepositButton(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    LastTransaction(
                      fem: fem,
                      ffem: ffem,
                      wallet: wallet ??
                          walletResponses(current_balance: 0, transactions: []),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}



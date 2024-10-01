// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_nullable_for_final_variable_declarations

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';
import 'package:workshop_mobi/screens/auth/login_or_register.dart';
import 'package:workshop_mobi/widgets/app_bar.dart';
import 'package:workshop_mobi/screens/userLayout/widgets/drawer.dart';
import 'package:workshop_mobi/screens/home_page.dart';
import 'package:workshop_mobi/screens/userLayout/widgets/workshop_enroll.dart';
import 'package:workshop_mobi/screens/userLayout/widgets/wallet_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/screens/userLayout/widgets/workshop_manager.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final apiService = ApiService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  UserInfoResponse? userInfo;

  bool showLoginPage = true;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      var accessToken = await _secureStorage.read(key: 'token');
      UserInfoResponse response =
          await apiService.getinforStudent(accessToken!);
      setState(() {
        userInfo = response;
      });
    } catch (error) {
      // print('Error loading user info: $error');
    }
  }
  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Color.fromARGB(255, 38, 55, 202),
          animationDuration: Duration(milliseconds: 300),
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const <Widget>[
            Icon(Icons.home) ,
            Icon(Icons.home_work_rounded),
            Icon(Icons.workspaces),
            Icon(Icons.wallet)
          ]),
      
      appBar:  CustomAppBar(user: userInfo,),

      drawer: MyDrawer(
        onLogout: () async {
          final SharedPreferences? prefs = await _prefs;
          prefs?.clear();
          const storage = FlutterSecureStorage();
          await storage.delete(key: 'token');
          await storage.deleteAll();
          Get.offAll(const LoginOrReg());
        },
        userInfo: userInfo,
      ),
      body: pagesBuilder()[selectedIndex],
    );
  }

  List<Widget> pagesBuilder() {
    Future<String> getToken() async {
      return await _secureStorage.read(key: 'token') ?? '';
    }

    return [
      // Home page
      const PublicHomeLanding(),
      // Manage page
      FutureBuilder<String>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return ManagePage(
              token: snapshot.data ?? '',
            );
          }
        },
      ),
      FutureBuilder<String>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return WorkshopListScreen(
              token: snapshot.data ?? '',
            );
          }
        },
      ),
      FutureBuilder<String>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return StudentWalletPage(
                token: snapshot.data ?? '', key: UniqueKey());
          }
        },
      ),
    ];
  }
}
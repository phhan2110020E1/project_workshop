// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_nullable_for_final_variable_declarations
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';
import 'package:workshop_mobi/screens/auth/login_or_register.dart';
import 'package:workshop_mobi/screens/home_page.dart';
// import 'package:workshop_mobi/screens/teacherLayout/widgets/app_bar.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/drawer.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/qr_list_workshop.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/wallet_page.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/workshop_page.dart';
import 'package:workshop_mobi/widgets/app_bar.dart';
class TeacherHomeScreen extends StatefulWidget {
    final String initialPage;

   const TeacherHomeScreen({Key? key, this.initialPage = 'workshop'})
      : super(key: key);

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
    final GlobalKey<CurvedNavigationBarState> _navBarKey = GlobalKey();

    int selectedIndex = 0; 
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final apiService = ApiService();
  final storage = FlutterSecureStorage();
  UserInfoResponse? userInfo;

  List<Widget> pages = [];
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
     Future<String> getToken() async {
      return await storage.read(key: 'token') ?? '';
    }
    try {
      var accessToken = await storage.read(key: 'token');
      UserInfoResponse response =
          await apiService.getinforStudent(accessToken!);
      setState(() {
        
        userInfo = response;
        pages = [
          const PublicHomeLanding(),
         
          FutureBuilder<String>(
            future: getToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return WorkshopManager(
                  token: snapshot.data ?? '',
                  workshopList: const [],
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
            return TeacherWalletPage(
                token: snapshot.data ?? '', key: UniqueKey());
          }
        },
      ),
          // QRViewExample(token: accessToken),
          QrListWorkShop(
            token: accessToken,
          ),
        ];
      if (widget.initialPage == 'workshop') {
         setState(() {
          selectedIndex = 1; // Index for WorkshopManager
        }); // Index for WorkshopManager
        } else {
          // Handle other initialPage values if needed
        }
      });
    } catch (error) {
      print('Error loading user info: $error');
    }
  }

  bool showLoginPage = true;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return UnconstrainedBox(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        backgroundColor: Colors.grey[300],

        // bottomNavigationBar: MyBottomNavBar(
        //   onTabChange: (index) => navigateBottomBar(index),
        // ),
        bottomNavigationBar: CurvedNavigationBar(
            key: _navBarKey,
            height: 60,
            backgroundColor: Color.fromARGB(255, 38, 55, 202),
            // color: Color.fromARGB(255, 224, 224, 224),
            buttonBackgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: const <Widget>[
              Icon(
                Icons.home,
                size: 15,
              ),
              Icon(Icons.workspaces, size: 15),
              Icon(Icons.wallet, size: 15),
              Icon(Icons.qr_code, size: 15),
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
          userInfo: userInfo!,
        ),
        body: pages.isEmpty ? Container() : pages[selectedIndex],
      );
    }
  }
}

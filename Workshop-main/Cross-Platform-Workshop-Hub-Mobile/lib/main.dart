// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workshop_mobi/app_localizations.dart';
import 'package:workshop_mobi/app_state.dart';
import 'package:workshop_mobi/pages/boarding_screen.dart';
import 'package:workshop_mobi/screens/auth/login_or_register.dart';
import 'package:workshop_mobi/screens/teacherLayout/teacher_home.dart';
import 'package:workshop_mobi/screens/userLayout/user_home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  String? roles = await storage.read(key: 'roles');
  runApp(ChangeNotifierProvider(
      create: (context) => AppState(), child: MyApp(token, roles)));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? roles;
  const MyApp(this.token, this.roles, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token != null ? getHomeScreen() : const OnBoardingScreen(),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('vi', 'VN'), // Vietnamese
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(), // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: (context, child) {
        return Localizations.override(
          context: context,
          locale: Locale('vi', 'VN'), // Set the default locale
          child: child!,
        );
      },
    );
  }

  Widget getHomeScreen() {
    // print('Token trong app ${token}');
    if (token != null && roles == 'USER') {
      return const UserHomeScreen();
    } else if (token != null && roles == 'SELLER') {
      return const TeacherHomeScreen();
    } else {
      return const LoginOrReg();
    }
  }
}

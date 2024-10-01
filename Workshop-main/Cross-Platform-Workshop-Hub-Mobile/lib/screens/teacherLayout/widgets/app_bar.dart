// // ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workshop_mobi/api/api_service.dart';
// import 'package:workshop_mobi/controller/authentication/login_controller.dart';
// import 'package:workshop_mobi/screens/auth/login_or_register.dart';
// import 'package:workshop_mobi/screens/userLayout/widgets/custom_logo_appbar.dart';
// import 'package:workshop_mobi/screens/teacherLayout/widgets/studen_info.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     LoginController loginController = Get.put(LoginController());
//     final apiService = ApiService();
//     const storage = FlutterSecureStorage();
//     final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       leading: Builder(
//         builder: (context) => IconButton(
//           icon: const Icon(
//             Icons.menu_rounded,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//         ),
//       ),
//       title: CustomLogoAppBar(), // Customize the title as needed
//       actions: [
//         PopupMenuButton<String>(
//           onSelected: (value) {
//             // Handle the selected value if needed
//           },
//           icon: const Icon(
//             Icons.notifications,
//             color: Colors.black,
//           ),
//           offset: const Offset(
//             0,
//             60,
//           ), // Adjust the offset as needed
//           itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//             const PopupMenuItem<String>(
//               value: 'item1',
//               child: Text('Notification 1'),
//             ),
//             const PopupMenuItem<String>(
//               value: 'item2',
//               child: Text('Notification 2'),
//             ),
//           ],
//         ),

//         // Use PopupMenuButton for CircleAvatar options
//         PopupMenuButton<String>(
//           onSelected: (value) async {
//             if (value == 'profile') {
//               var accessToken = await storage.read(key: 'token');
//               // Use the token in your API request
//               var response = await apiService.getinforStudent(accessToken!);
//               // ignore: use_build_context_synchronously
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ProfilePage(
//                           userInfoResponse: response,
//                         )),
//               );
//             } else if (value == 'settings') {
//             } else if (value == 'logout') {
//               () async {
//                 final SharedPreferences? prefs = await _prefs;
//                 prefs?.clear();
//                 const storage = FlutterSecureStorage();
//                 await storage.delete(key: 'token');
//                 await storage.deleteAll();
//                 Get.offAll(const LoginOrReg());
//               }();
//             }
//           },
//           icon: CircleAvatar(
//             child: Obx(() {
//               print(loginController.imageUrl.value);
//               if (loginController.imageUrl.value.isNotEmpty) {
//                 return ClipOval(
//                   child: Image.network(
//                     loginController.imageUrl.value,
//                     fit: BoxFit.cover,
//                     width: 50, // Đặt kích thước mong muốn tại đây
//                     height: 50,
//                   ),
//                 );
//               } else if (loginController.image0AuthenUrl!.value.isNotEmpty) {
//                 return ClipOval(
//                   child: Image.network(
//                     loginController.image0AuthenUrl!.value,
//                     fit: BoxFit.cover,
//                     width: 50, // Đặt kích thước mong muốn tại đây
//                     height: 50,
//                   ),
//                 );
//               } else {
//                 return ClipOval(
//                   child: Image.asset(
//                     'lib/assets/Logo.png',
//                     fit: BoxFit.cover,
//                     width: 50, // Đặt kích thước mong muốn tại đây
//                     height: 50,
//                   ),
//                 );
//               }
//             }),
//           ),

//           offset: const Offset(
//             0,
//             60,
//           ), // Adjust the offset as needed
//           itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//             const PopupMenuItem<String>(
//               value: 'profile',
//               child: Text('Profile'),
//             ),
//             const PopupMenuItem<String>(
//               value: 'settings',
//               child: Text('Settings'),
//             ),
//             const PopupMenuItem<String>(
//               value: 'logout',
//               child: Text('Logout'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

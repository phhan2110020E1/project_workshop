// ignore_for_file: unnecessary_cast, avoid_print, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/app_localizations.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/studen_info.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onLogout;
  final UserInfoResponse userInfo;
  

  const MyDrawer({Key? key, required this.onLogout, required this.userInfo,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    const storage = FlutterSecureStorage();
    ImageProvider<Object>? backgroundImage;

    if (userInfo.image_url != null) {
      backgroundImage = NetworkImage(userInfo.image_url! as String);
    } else {
      backgroundImage = const AssetImage('lib/assets/user_emty.jpg');
    }
    print(userInfo.image_url);
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            // accountName: Text('Lê Thanh Hiếu'),
            accountName: Text(
              AppLocalizations.translateFullName(context, userInfo.full_name),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // accountEmail: Text('hieu64822@gmail.com'),
            accountEmail: Text(userInfo.email),

            currentAccountPicture: CircleAvatar(
              radius: 30,
              backgroundImage: backgroundImage,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                // ignore: unnecessary_const
                image: const DecorationImage(
                    image: AssetImage('lib/assets/background.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () async {
              try {
                var accessToken = await storage.read(key: 'token');

                // Kiểm tra xem accessToken có tồn tại không
                if (accessToken != null) {
                  // Gửi yêu cầu API để lấy thông tin sinh viên
                  var response = await apiService.getinforStudent(accessToken);

                  // Kiểm tra xem response có dữ liệu không
                  if (response != null) {
                    // Điều hướng đến trang ProfilePage và truyền dữ liệu userInfoResponse
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          userInfoResponse: response,
                        ),
                      ),
                      
                    );
                  } else {
                    // Xử lý trường hợp response không có dữ liệu
                    print('API response is null or empty');
                  }
                } else {
                  // Xử lý trường hợp accessToken không tồn tại
                  print('Access token is null');
                }
              } catch (e) {
                // Xử lý lỗi nếu có
                print('Error: $e');
              }
            },
          ),

          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite'),
            // ignore: avoid_print
            onTap: () => print('Favorite'),
          ),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            // ignore: avoid_print
            onTap: () => print('Upload tapped'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            // ignore: avoid_print
            onTap: () => print('Upload tapped'),
          ),
          const Spacer(), // Add Spacer to push "Sign Out" to the bottom
          Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: onLogout,
            ),
          ),
        ],
      ),
    );
  }
}

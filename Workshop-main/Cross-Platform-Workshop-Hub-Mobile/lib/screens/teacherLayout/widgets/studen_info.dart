// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, deprecated_member_use, avoid_print, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:workshop_mobi/app_localizations.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';
import 'package:workshop_mobi/screens/teacherLayout/edit_profile/edit_profile.dart';

class ProfilePage extends StatefulWidget {
  final UserInfoResponse userInfoResponse;

  const ProfilePage({Key? key, required this.userInfoResponse,})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
      // Access the userAddresses list from the widget
List<UserAddress> userAddresses = widget.userInfoResponse.userAddresses;

// Check if the list is not empty before accessing its elements
if (userAddresses.isNotEmpty) {
  // Access the first UserAddress object from the list
  UserAddress firstAddress = userAddresses[0];

  // Print or use the information as needed
  print('User Address Information:');
  print('ID: ${firstAddress.id}');
  print('State: ${firstAddress.state}');
  print('Address: ${firstAddress.address}');
  print('city: ${firstAddress.city}');
  print('Postal Code: ${firstAddress.postalCode}');
} else {
  print('No user addresses available.');
}

    return Scaffold(
      
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // User Image
            SizedBox(
              width: 150,
              height: 150,
              child: CircleAvatar(
                radius: 10,
                child: ClipOval(
                  child: widget.userInfoResponse.image_url != null &&
                          Uri.parse(widget.userInfoResponse.image_url!)
                              .isAbsolute
                      ? Image.network(
                          widget.userInfoResponse.image_url!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          widget.userInfoResponse.image_url ??
                              'lib/assets/user_emty.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // User Name
            Text(
              AppLocalizations.translateFullName(
                  context, widget.userInfoResponse.full_name),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildUserInfoRow('Email', widget.userInfoResponse.email),
            buildUserInfoRow(
                'Phone Number', widget.userInfoResponse.phoneNumber),
            buildUserInfoRow(
                'Balance', '\$${widget.userInfoResponse.balance.toString()}'),

            buildUserInfoRow('Gender', widget.userInfoResponse.gender),
            buildUserInfoRow('Roles', widget.userInfoResponse.roles.join(', ')),
            // User Addresses
            if(widget.userInfoResponse.userAddresses.length>0)
             buildAddressSection(
                  'User Addresses', widget.userInfoResponse.userAddresses[0]),
             
                  
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                        userInfoResponse: widget.userInfoResponse,),
                  ),
                );
              },
              child: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(primary: Colors.yellow),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildUserInfoRow(String label, String value) {
    if (label == 'Roles') {
      // Kiểm tra giá trị Roles và trả về chuỗi tương ứng
      String roleMessage = '';
      if (widget.userInfoResponse.roles.contains('USER')) {
        roleMessage = 'You are a Student';
      }
      if (widget.userInfoResponse.roles.contains('SELLER')) {
        roleMessage = 'You are a Teacher';
      }

      return ListTile(
        title: Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(roleMessage),
      );
    } else {
      // Nếu không phải là 'Roles', trả về thông tin bình thường
      return ListTile(
        title: Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      );
    }
  }



  Widget buildBankSection(String title, List<UserBank> banks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        for (var bank in banks)
          ListTile(
            title: Text(
              'Bank Name: ${bank.bankName}, Bank Account: ${bank.bankAccount}',
            ),
          ),
      ],
    );
  }
}
Widget buildAddressSection(String title, UserAddress address) {
  print('Address: ${address.address}/n city: ${address.city},/n State: ${address.state} /n,Postal Code: ${address.postalCode.toString()}');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),
      Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Address: ${address.address}',
              
            ),
          ),
          ListTile(
            title: Text(
              'city: ${address.city}',
            ),
          ),
          ListTile(
            title: Text(
              'State: ${address.state}',
            ),
          ),
          ListTile(
            title: Text(
              'Postal Code: ${address.postalCode.toString()}',
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ],
  );
}

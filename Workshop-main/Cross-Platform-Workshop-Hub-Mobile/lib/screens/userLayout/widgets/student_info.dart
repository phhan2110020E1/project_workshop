// // ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings, deprecated_member_use, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:workshop_mobi/app_localizations.dart';
// import 'package:workshop_mobi/model/userInforResponse.dart';

// class ProfilePage extends StatefulWidget {
//   final UserInfoResponse userInfoResponse;

//   const ProfilePage({Key? key, required this.userInfoResponse})
//       : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // User Image
//             SizedBox(
//               width: 150,
//               height: 150,
//               child: CircleAvatar(
//                 radius: 10,
//                 child: ClipOval(
//                   child: widget.userInfoResponse.image_url != null &&
//                           Uri.parse(widget.userInfoResponse.image_url!)
//                               .isAbsolute
//                       ? Image.network(
//                           widget.userInfoResponse.image_url!,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.asset(
//                           widget.userInfoResponse.image_url ??
//                               'lib/assets/user_emty.jpg',
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // User Name
//             Text(
//               AppLocalizations.translateFullName(
//                   context, widget.userInfoResponse.full_name),
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             buildUserInfoRow('Email', widget.userInfoResponse.email),
//             buildUserInfoRow(
//                 'Phone Number', '0' + widget.userInfoResponse.phoneNumber),
//             buildUserInfoRow(
//                 'Balance', '\$${widget.userInfoResponse.balance.toString()}'),
//             buildUserInfoRow('Gender', widget.userInfoResponse.gender),
//             buildUserInfoRow('Roles', widget.userInfoResponse.roles.join(', ')),
//             // User Addresses
//             if (widget.userInfoResponse.userAddresses.isNotEmpty)
//               buildAddressSection(
//                   'User Addresses', widget.userInfoResponse.userAddresses),
//             ElevatedButton(
//               onPressed: () {
//                 // Add logic to navigate or show a modal for adding a new address
//               },
//               child: const Text('Thêm Địa Chỉ'),
//               style: ElevatedButton.styleFrom(primary: Colors.yellow),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildUserInfoRow(String label, String value) {
//     if (label == 'Roles') {
//       // Kiểm tra giá trị Roles và trả về chuỗi tương ứng
//       String roleMessage = '';
//       if (widget.userInfoResponse.roles.contains('USER')) {
//         roleMessage = 'You are a Student';
//       }
//       if (widget.userInfoResponse.roles.contains('SELLER')) {
//         roleMessage = 'You are a Teacher';
//       }

//       return ListTile(
//         title: Text(
//           '$label: ',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(roleMessage),
//       );
//     } else {
//       return ListTile(
//         title: Text(
//           '$label: ',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(value),
//       );
//     }
//   }

//   Widget buildAddressSection(String title, List<UserAddress> addresses) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(
//           title,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         for (var address in addresses)
//           ListTile(
//             title: Text(
//               'Address: ${address.address}, City: ${address.city}, State: ${address.state}, Postal Code: ${address.postalCode.toString()}',
//             ),
//           ),
//       ],
//     );
//   }

//   Widget buildBankSection(String title, List<UserBank> banks) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(
//           title,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         for (var bank in banks)
//           ListTile(
//             title: Text(
//               'Bank Name: ${bank.bankName}, Bank Account: ${bank.bankAccount}',
//             ),
//           ),
//       ],
//     );
//   }
// }

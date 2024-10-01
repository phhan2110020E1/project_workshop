// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, deprecated_member_use, prefer_const_constructors, unnecessary_import, unnecessary_string_interpolations

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';
import 'package:workshop_mobi/screens/teacherLayout/edit_profile/add_date.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/resources/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class EditProfilePage extends StatefulWidget {
  final UserInfoResponse userInfoResponse;
  const EditProfilePage(
      {Key? key, required this.userInfoResponse,})
      : super(key: key);

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  final TextEditingController idAddressController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    // Set initial values
    fullNameController.text = widget.userInfoResponse.full_name;
    userNameController.text = widget.userInfoResponse.user_name;
    emailController.text = widget.userInfoResponse.email;
    phoneNumberController.text = widget.userInfoResponse.phoneNumber;
    balanceController.text = widget.userInfoResponse.balance.toString();
    imageUrlController.text = widget.userInfoResponse.image_url!;
    if (widget.userInfoResponse.userAddresses.isNotEmpty) {
      idAddressController.text = widget.userInfoResponse.userAddresses[0].id.toString();
      stateController.text = widget.userInfoResponse.userAddresses[0].state;
      addressController.text = widget.userInfoResponse.userAddresses[0].address;
      cityController.text = widget.userInfoResponse.userAddresses[0].city;
      postalCodeController.text =
          widget.userInfoResponse.userAddresses[0].postalCode.toString();
    }
  }

  Uint8List? _image;

  Future<void> selectImage() async {
    Uint8List? selectedImage = await pickImage(ImageSource.gallery);

    if (selectedImage != null) {
      // Upload the image to Firebase and get the download URL
      String imageUrl = await StoreData()
          .uploadImageToStorage('images/profileImage', selectedImage);

      // Update the controller with the image URL
      imageUrlController.text = imageUrl;

      // Update the UI to show the selected image
      setState(() {
        _image = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // User Image
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                NetworkImage("${imageUrlController.text}"),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter Full Name',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'FullName cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: userNameController,
              decoration: const InputDecoration(
                labelText: 'User Name',
                hintText: 'Enter User Name',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'User Name cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),

            const SizedBox(
              height: 24,
            ),

            TextFormField(
              controller: emailController,
              enabled: false,

              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter Email',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email cannot be empty';
                } else if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              style: TextStyle(
                color:
                    Colors.grey, // Set the text color to grey for a muted look
              ),
              autovalidateMode: AutovalidateMode.always,
            ),

            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                hintText: 'Enter Phone',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}$')), // Chỉ cho phép nhập số
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Price cannot be empty';
                }
                try {
                  final double price = double.parse(value);
                  if (price <= 0) {
                    throw FormatException();
                  }
                } catch (e) {
                  return 'Price must be a valid positive number';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),

            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: balanceController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Balance',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color:
                    Colors.grey, // Set the text color to grey for a muted look
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: stateController,
              decoration: const InputDecoration(
                labelText: 'State',
                hintText: 'Enter State',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'State cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                hintText: 'Enter Address',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Address cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                hintText: 'Enter City',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'City cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),

            TextFormField(
              controller: postalCodeController,
              decoration: const InputDecoration(
                labelText: 'Postal Code',
                hintText: 'Enter Postal Code',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}$')), // Chỉ cho phép nhập số
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Postal Code cannot be empty';
                }
                try {
                  final double price = double.parse(value);
                  if (price <= 0) {
                    throw FormatException();
                  }
                } catch (e) {
                  return 'Postal Code must be a valid positive number';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),

            const SizedBox(
              height: 24,
            ),
            // User Address

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Implement logic to update the profile
                _saveProfile();
              },
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  Widget buildTextFieldHidden(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
      ),
      style: TextStyle(
        color: Colors.grey, // Set the text color to grey for a muted look
      ),
    );
  }

  final ApiService apiService = ApiService();

  Future<void> _saveProfile() async {
    try {
      // Implement logic to update the profile
      await apiService.editProfile(
       
        id: int.parse(idAddressController.text),
        full_name: fullNameController.text,
        user_name: userNameController.text,
        email: emailController.text,
        phoneNumber: int.parse(phoneNumberController.text),
        image_url: imageUrlController.text,
        state: stateController.text,
        address: addressController.text,
        city: cityController.text,
        postalCode: int.parse(postalCodeController.text),
      );
      // Optionally show a success message or navigate to a different screen
    } catch (error) {
      // Handle errors, possibly show an error message
    }
  }
}

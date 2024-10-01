// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print, await_only_futures, deprecated_member_use, library_private_types_in_public_api, unnecessary_import

import 'dart:typed_data';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workshop_mobi/controller/teacher/add_workshop_controller.dart';
import 'package:workshop_mobi/model/workshopResquest.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/resources/add_date.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/resources/utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  final String token = await fetchToken();
  //   final AddWorkshopController myController = AddWorkshopController(token: token);();

  // runApp(DetailsPage(controller: myController));
}

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {Key? key,
      required this.controller,
      required this.token,
      required Null Function(CourseRequest workshop) onInfoChanged})
      : super(key: key);
  final String token;

  final AddWorkshopController controller; // Add this line

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  VideoPlayerController? _videoPlayerController;

  Uint8List? _image;
  Uint8List? _media;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController studentCountController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
bool isImageAndVideoSelected() {
  return _image != null && _media != null;
}
Future<void> _selectStartDate(BuildContext context) async {
   final DateTime tomorrow = DateTime.now().add(Duration(days: 1));
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: tomorrow,
    firstDate: tomorrow,
    lastDate: DateTime(DateTime.now().year + 5),
  );

  if (pickedDate != null) {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final DateTime picked = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Check if the selected date and time are in the past
      if (picked.isAfter(DateTime.now())) {
        // Rest of your code remains the same
        if (picked != selectedStartDate) {
          if (selectedEndDate == null || picked.isBefore(selectedEndDate!)) {
            setState(() {
              selectedStartDate = picked;
              startDateController.text = DateFormat('yyyy-MM-dd HH:mm').format(picked);
            });
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Invalid Date'),
                content: Text('Start Date must be before End Date.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      } else {
        // Show a message or perform other actions if the selected date and time are in the past
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Date'),
            content: Text('Selected date and time must be in the future.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}

// Similar changes for _selectEndDate function

Future<void> _selectEndDate(BuildContext context) async {
   final DateTime tomorrow = DateTime.now().add(Duration(days: 1));

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: tomorrow,
    firstDate: tomorrow,
    lastDate: DateTime(DateTime.now().year + 5),
  );

  if (pickedDate != null) {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final DateTime picked = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Check if the selected date and time are in the past
      if (picked.isAfter(DateTime.now())) {
        // Rest of your code remains the same
        if (picked != selectedEndDate) {
          if (selectedStartDate == null || picked.isAfter(selectedStartDate!)) {
            setState(() {
              selectedEndDate = picked;
              endDateController.text = DateFormat('yyyy-MM-dd HH:mm').format(picked);
            });
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Invalid Date'),
                content: Text('End Date must be after Start Date.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      } else {
        // Show a message or perform other actions if the selected date and time are in the past
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Date'),
            content: Text('Selected date and time must be in the future.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    widget.controller.type.value = "offline";
    // Add listeners to controllers
    nameController.addListener(updateController);
    descriptionController.addListener(updateController);
    priceController.addListener(updateController);
    startDateController.addListener(updateController);
    endDateController.addListener(updateController);
  }

  Future<void> selectImage() async {
    Uint8List? selectedImage = await pickImage(ImageSource.gallery);

    if (selectedImage != null) {
      // Upload the image to Firebase and get the download URL
      String imageUrl = await StoreData()
          .uploadImageToStorage('images/profileImage', selectedImage);

      // Update the controller with the image URL in the specific item of mediaInfoList
      if (widget.controller.mediaInfoList.isNotEmpty) {
        widget.controller.mediaInfoList[0]['urlImage'] = imageUrl;
        print(
            'image (from controller): ${widget.controller.mediaInfoList[0]['urlImage']}');
      } else {
        // Handle the case where the list is empty, possibly by adding a new item
        widget.controller.mediaInfoList.add({'urlImage': imageUrl});
        print(
            'image (from controller): ${widget.controller.mediaInfoList[0]['urlImage']}');
      }
      // Assuming you want to update the first item, adjust index as needed

      // Update the UI to show the selected image
      setState(() {
        _image = selectedImage;
      });

         if (isImageAndVideoSelected()) {
      // Both image and video are selected, perform additional actions if needed
    } else {
      // Display a message or handle incomplete selection accordingly
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both image and video.'),
        ),
      );
    }
    }
  }

  bool _isPlaying = false;
Future<void> selectVideo() async {
  Uint8List? selectedMedia = await pickVideo(ImageSource.gallery);

  if (selectedMedia != null) {
    // Upload the video to Firebase and get the download URL
    String videoUrl = await StoreData()
        .uploadVideoToStorage('images/profileMedia', selectedMedia);

    // Update the controller with the video URL in the specific item of mediaInfoList
    if (widget.controller.mediaInfoList.isNotEmpty) {
      widget.controller.mediaInfoList[0]['urlMedia'] = videoUrl;
      print(
          'video (from controller): ${widget.controller.mediaInfoList[0]['urlMedia']}');
    } else {
      // Handle the case where the list is empty, possibly by adding a new item
      widget.controller.mediaInfoList.add({'urlMedia': videoUrl});
      print(
          'video (from controller): ${widget.controller.mediaInfoList[0]['urlMedia']}');
    }

    // Update the UI to show the selected video
    setState(() {
      _media = selectedMedia;
    });

    // Check if both image and video are selected
    if (isImageAndVideoSelected()) {
      // Both image and video are selected, perform additional actions if needed
    } else {
      // Display a message or handle incomplete selection accordingly
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both image and video.'),
        ),
      );
    }
  }
}

  // Update the controller when any field changes
  void updateController() {
    widget.controller.name.value = nameController.text;
    widget.controller.description.value = descriptionController.text;
    // Handle price conversion
    final priceText = priceController.text.trim();
    if (priceText.isNotEmpty) {
      try {
        final price = double.parse(priceText);
        widget.controller.price.value = price;
        print('Price (from controller): $price');
      } catch (e) {
        print('Error parsing price: $e');
      }
    } else {
      print('Price is empty');
    }
    if (selectedStartDate != null) {
      widget.controller.startDate.value = selectedStartDate!;
    }

    if (selectedEndDate != null) {
      widget.controller.endDate.value = selectedEndDate!;
    }

    print('Name (from controller): ${widget.controller.name.value}');
    print(
        'Description (from controller): ${widget.controller.description.value}');
    print('Price (from controller): ${widget.controller.price.value}');
    print('Start Date (from controller): ${widget.controller.startDate.value}');
    print('End Date (from controller): ${widget.controller.endDate.value}');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            AssetImage('lib/assets/defaultImage.png'),
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

            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                _media != null
                    ? FutureBuilder<void>(
                        future: () async {
                          _videoPlayerController =
                              await VideoPlayerController.network(widget
                                  .controller.mediaInfoList[0]['urlMedia']);
                          await _videoPlayerController?.initialize();
                        }(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio:
                                  _videoPlayerController?.value.aspectRatio ??
                                      16 / 9,
                              child: VideoPlayer(_videoPlayerController!),
                            );
                          } else {
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey[300],
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      )
                    : Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Placeholder color
                        ),
                        child: Center(
                          child: Icon(
                            Icons.video_library,
                            size: 64,
                            color: Colors.grey[600], // Icon color
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 16,
                  left: 80,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            // Fix: Remove 'bool _isPlaying = false'
                            if (_isPlaying) {
                              _videoPlayerController?.pause();
                            } else {
                              _videoPlayerController?.play();
                            }
                            _isPlaying = !_isPlaying;
                          });
                        },
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: selectVideo,
                        icon: const Icon(Icons.video_library),
                        color: Colors.white, // Button color
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter Name',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||  value.trim().isEmpty) {
                  return 'Name cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter Description',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||  value.trim().isEmpty) {
                  return 'Description cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),

            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                hintText: 'Enter Price',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}$')), // Chỉ cho phép nhập số
              ],
              validator: (value) {
                if (value == null ||  value.trim().isEmpty) {
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
            TextField(
              controller: startDateController,
              onTap: () => _selectStartDate(context),
              decoration: InputDecoration(
                labelText: 'Start Date',
                hintText: 'Select Start Date',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: endDateController,
              onTap: () => _selectEndDate(context),
              decoration: InputDecoration(
                labelText: 'End Date',
                hintText: 'Select End Date',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),

            // const SizedBox(
            //   height: 24,
            // ),
            // ElevatedButton(
            //   onPressed: saveProfile,
            //   child: const Text('Save Profile'),
            // )
          ],
        ),
      ),
    );
  }
}

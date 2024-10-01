// ignore_for_file: avoid_print, prefer_const_constructors, deprecated_member_use, unnecessary_string_interpolations, unused_local_variable, duplicate_ignore, unnecessary_import, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:typed_data';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/controller/teacher/edit_profile_teacher_controller.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/model/workshopUpdateRequest.dart';
import 'package:intl/intl.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/resources/add_date.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/resources/utils.dart';
import 'package:flutter/services.dart';

class DetailsPage extends StatefulWidget {
  final int workshopId;
  const DetailsPage({
    Key? key,
    required this.controller,
    required this.token,
    required Null Function(CourseUpdateRequest workshop) onInfoChanged,
    required this.workshopId,
  }) : super(key: key);
  final String token;

  final EditWorkshopController controller; // Add this line

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late VideoPlayerController _videoPlayerController;

  Uint8List? _image;
  Uint8List? _media;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController studentCountController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController urlImageController = TextEditingController();
  final TextEditingController urlMediaController = TextEditingController();
  final TextEditingController thumbnailSrcController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController idMediaController = TextEditingController();
  
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

Future<void> _selectStartDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 5),
  );
  if (picked != null && picked != selectedStartDate) {
    // Kiểm tra nếu ngày chọn là hợp lệ và nhỏ hơn ngày "EndDate"
    if (selectedEndDate == null || picked.isBefore(selectedEndDate!)) {
      setState(() {
        selectedStartDate = picked;
        startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    } else {
      // Hiển thị thông báo hoặc thực hiện xử lý khác nếu ngày không hợp lệ
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
}
bool isImageAndVideoSelected() {
  return _image != null && _media != null;
}

Future<void> _selectEndDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 5),
  );
  if (picked != null && picked != selectedEndDate) {
    // Kiểm tra nếu ngày chọn là hợp lệ và lớn hơn ngày "StartDate"
    if (selectedStartDate == null || picked.isAfter(selectedStartDate!)) {
      setState(() {
        selectedEndDate = picked;
        endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    } else {
      // Hiển thị thông báo hoặc thực hiện xử lý khác nếu ngày không hợp lệ
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
}

  Future<void> fetchWorkshopData(int workshopId, String token) async {
    try {
      List<CourseResponses> workshopList =
          await ApiService().getWorkshopById(workshopId, token);

      // Check if the list is not empty before accessing the first item
      if (workshopList.isNotEmpty) {
        CourseResponses workshop = workshopList.first;

        // Update the state with the fetched workshop data
        setState(() {
          idMediaController.text = workshop.courseMediaInfos[0].id.toString();
          urlImageController.text = workshop.courseMediaInfos[0].urlImage;
          urlMediaController.text = workshop.courseMediaInfos[0].urlMedia;
          titleController.text = workshop.courseMediaInfos[0].thumbnailSrc;
          thumbnailSrcController.text = workshop.courseMediaInfos[0].title;

          var videoMedia = urlMediaController.text;

          print('nameController.text: ${nameController.text}');
          widget.controller.addMediaInfo(
            id: int.tryParse(idMediaController.text) ?? 0,
            urlImage: urlImageController.text,
            urlMedia: urlMediaController.text,
            thumbnailSrc: thumbnailSrcController.text,
            title: titleController.text,
          );
          nameController.text = workshop.name;
          descriptionController.text = workshop.description;
          typeController.text = workshop.type;
          priceController.text = workshop.price.toString();
          startDateController.text =
              DateFormat('yyyy-MM-dd').format(workshop.startDate);
          endDateController.text =
              DateFormat('yyyy-MM-dd').format(workshop.endDate);
          // Update the controllers in your EditWorkshopController
          widget.controller.name.value = workshop.name;
          widget.controller.type.value = workshop.type;
          widget.controller.description.value = workshop.description;
          widget.controller.price.value = workshop.price;
          widget.controller.startDate.value = workshop.startDate;
          widget.controller.endDate.value = workshop.endDate;
        });

        updateController();
      } else {
        // Handle the case where the list is empty
        print('Empty workshop list');
      }
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error fetching workshop data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
     WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp();
    // ignore: deprecated_member_use
    _videoPlayerController = VideoPlayerController.network(
     urlMediaController.text,
    );
    _initializeWorkshopData();

    // Add listeners to TextEditingControllers
    nameController.addListener(() {
      updateController();
    });

    descriptionController.addListener(() {
      updateController();
    });

    priceController.addListener(() {
      updateController();
    });

    startDateController.addListener(() {
      updateController();
    });

    endDateController.addListener(() {
      updateController();
    });
    typeController.addListener(() {
      updateController();
    });
  }

  Future<void> _initializeWorkshopData() async {
    try {
      await fetchWorkshopData(widget.workshopId, widget.token);
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error initializing workshop data: $error');
    }
  }

  Future<void> selectImage() async {
    Uint8List? selectedImage = await pickImage(ImageSource.gallery);

    if (selectedImage != null) {
      // Upload the image to Firebase and get the download URL
      String imageUrl = await StoreData()
          .uploadImageToStorage('images/profileImage', selectedImage);

      // Update the controller with the image URL in the specific item of courseMediaInfos
      if (widget.controller.courseMediaInfos.isNotEmpty) {
        widget.controller.courseMediaInfos[0]['urlImage'] = imageUrl;
        print(
            'image (from controller): ${widget.controller.courseMediaInfos[0]['urlImage']}');
      } else {
        // Handle the case where the list is empty, possibly by adding a new item
        widget.controller.courseMediaInfos.add({'urlImage': imageUrl});
        print(
            'image (from controller): ${widget.controller.courseMediaInfos[0]['urlImage']}');
      }
      // Assuming you want to update the first item, adjust index as needed

      // Update the UI to show the selected image
      setState(() {
        _image = selectedImage;
      });
    }
  }

  bool _isPlaying = false;
  Future<void> selectVideo() async {
    Uint8List? selectedMedia = await pickVideo(ImageSource.gallery);

    if (selectedMedia != null) {
      // Upload the image to Firebase and get the download URL
      String imageUrl = await StoreData()
          .uploadVideoToStorage('images/profileMedia', selectedMedia);

      // Update the controller with the image URL in the specific item of courseMediaInfos
      if (widget.controller.courseMediaInfos.isNotEmpty) {
        widget.controller.courseMediaInfos[0]['urlMedia'] = imageUrl;
        print(
            'media (from controller): ${widget.controller.courseMediaInfos[0]['urlMedia']}');
      } else {
        // Handle the case where the list is empty, possibly by adding a new item
        widget.controller.courseMediaInfos.add({'urlMedia': imageUrl});
        print(
            'media (from controller): ${widget.controller.courseMediaInfos[0]['urlMedia']}');
      }
      // Assuming you want to update the first item, adjust index as needed

      // Update the UI to show the selected image
      setState(() {
        _media = selectedMedia;
      });
    }
  }


  // Update the controller when any field changes
  void updateController() {
    if (idMediaController.text.isNotEmpty && urlImageController.text.isNotEmpty &&
        thumbnailSrcController.text.isNotEmpty &&
        urlMediaController.text.isNotEmpty &&
        titleController.text.isNotEmpty) {
      widget.controller.addMediaInfo(
        id: int.tryParse(idMediaController.text) ?? 0,
        title: titleController.text,
        urlImage: urlImageController.text,
        urlMedia: urlMediaController.text,
        thumbnailSrc: thumbnailSrcController.text,
      );
        }
    widget.controller.name.value = nameController.text;
    widget.controller.description.value = descriptionController.text;
    // Handle price conversion
    final priceText = priceController.text.trim();
    if (priceText.isNotEmpty) {
      final price = double.tryParse(priceText);
      if (price != null) {
        widget.controller.price.value = price;
        print('Price (from controller): $price');
      } else {
        print('Invalid price format');
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
    // Update the media info in your EditWorkshopController
    if (widget.controller.courseMediaInfos.isNotEmpty) {
      widget.controller.courseMediaInfos[0]['urlImage'] =
          widget.controller.courseMediaInfos[0]['urlImage'];
      widget.controller.courseMediaInfos[0]['urlMedia'] =
          widget.controller.courseMediaInfos[0]['urlMedia'];
    }
    print('Name (from controller): ${widget.controller.name.value}');
    print(
        'Description (from controller): ${widget.controller.description.value}');
    print('Price (from controller): ${widget.controller.price.value}');
    print('Start Date (from controller): ${widget.controller.startDate.value}');
    print('End Date (from controller): ${widget.controller.endDate.value}');
  }

  Future<void> initializeVideoPlayer() async {
    // Check if the list is not empty before accessing the first item
    // _videoPlayerController = VideoPlayerController.network(
    //   widget.courseResponses.courseMediaInfos[0].urlMedia,
    // );
    _videoPlayerController = VideoPlayerController.network(
      widget.controller.courseMediaInfos[0]['urlImage'],
    );
    // Ensure the controller is initialized
    await _videoPlayerController!.initialize();

    // Add a listener to update the UI when the video is playing
    _videoPlayerController!.addListener(() {
      setState(() {}); // Update the UI when the video is playing
    });

    // Start playing the video
    _videoPlayerController!.play();
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
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            NetworkImage("${urlImageController.text}"),
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
                          initializeVideoPlayer();
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

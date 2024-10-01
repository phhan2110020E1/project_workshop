// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_cast, unused_local_variable, unused_element, unnecessary_string_interpolations, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/controller/ratingController.dart';
import 'package:workshop_mobi/model/rating/home_rageListRatingDTO.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';

class CommentWidget extends StatelessWidget {
  final String avatarImage;
  final String name;
  final double rating;
  final String comment;
  final String tag; // Thêm thuộc tính tag
  CommentWidget({
    required this.avatarImage,
    required this.name,
    required this.rating,
    required this.comment,
    required this.tag,
  });

  ImageProvider<Object> _getImageProvider(String avatarImage) {
    return avatarImage.isEmpty
        ? AssetImage('lib/assets/avatar.jpg') as ImageProvider<Object>
        : NetworkImage(avatarImage) as ImageProvider<Object>;
  }

  @override
  Widget build(BuildContext context) {
    double numberOfStars = rating;
    List<Icon> starIcons = List.generate(
      numberOfStars.toInt(),
      (index) => Icon(
        index < rating.round() ? Icons.star : Icons.star_border,
        color: Colors.yellow,
      ),
    );
    ImageProvider<Object> imageProvider = _getImageProvider(avatarImage);
    return Container(
      padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 8),
      child: Column(
        children: [
          // Header Section

          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: imageProvider,
              ),
              SizedBox(width: 16.0), // Add some space between avatar and name
              // Name and Rating on the left
              Expanded(
                flex: 2, // Give more flexibility to the name and rating column
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ), // Add some space between name and rating
                    // Rating using RatingBar widget
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // Handle rating updates if needed
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Comment Section
          Container(
            padding: EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Move 'Bình luận:' to the same row as the avatar
                Row(
                  children: [
                    Text(
                      'About:',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                        width: 8.0), // Add some space between text and comment
                    // Tag
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class RatingSection extends StatefulWidget {
  final int teacherId;
  final int workshopId;
  final bool isComment;

  const RatingSection({
    Key? key,
    required this.teacherId,
    required this.workshopId,
    required this.isComment,
  }) : super(key: key);

  static Future<UserInfoResponse> getStudentInfo() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    ApiService apiService = ApiService();
    UserInfoResponse infoResponse = await apiService.getinforStudent(token!);
    return infoResponse;
  }

  static Future<List<HomePageListRatingDTO>> getlistRating(
      workshopId, teacherId) async {
    ApiService apiService = ApiService();
    List<HomePageListRatingDTO> listRating =
        await apiService.listRating(workshopId, teacherId);
    return listRating;
  }

  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  late Future<UserInfoResponse> userInfoFuture;
  late Future<List<HomePageListRatingDTO>> listRatingFuture;
  @override
  void initState() {
    super.initState();
    userInfoFuture = RatingSection.getStudentInfo();
    listRatingFuture =
        RatingSection.getlistRating(widget.workshopId, widget.teacherId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfoResponse>(
      future: userInfoFuture,
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (userSnapshot.hasError) {
          return Text('Error: ${userSnapshot.error}');
        } else {
          // Đã lấy được thông tin người dùng, giờ sẽ lấy danh sách đánh giá
          return FutureBuilder<List<HomePageListRatingDTO>>(
            future: listRatingFuture,
            builder: (context, listRatingSnapshot) {
              if (listRatingSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (listRatingSnapshot.hasError) {
                return Text('Error: ${listRatingSnapshot.error}');
              } else if (listRatingSnapshot.data == null ||
                  listRatingSnapshot.data!.isEmpty) {
                return const Center(
                  child:  Text('No ratings available'),
                );
              } else {
                // Tạo danh sách các CommentWidget từ dữ liệu
                List<HomePageListRatingDTO> ratings = listRatingSnapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: ratings.map((rating) {
                      var value = '';
                      if (rating.targetType == 'MENTOR') {
                        value = 'Mentor: ${rating.mentorName}';
                      } else {
                        value = 'Workshop: ${rating.workshopName}';
                      }
                      return CommentWidget(
                        avatarImage: rating.userCommentImg!,
                        name: rating.userCommentName ?? 'Unknown',
                        rating: rating.rating ?? 0.0,
                        tag: value,
                        comment: rating.comment ?? 'No comment',
                      );
                    }).toList(),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}

int selectedRating = 1;
String selectedOption = 'MENTOR'; // Default option
void _showAddCommentDialog(BuildContext context, int teacherId, int workshopId,
    UserInfoResponse userInfo) {
  RatingController ratingController = Get.put(RatingController());

  ImageProvider imageProvider;
  if (userInfo.image_url != null && userInfo.image_url!.isNotEmpty) {
    imageProvider = NetworkImage(userInfo.image_url!);
  } else {
    imageProvider = AssetImage('lib/assets/avatar.jpg');
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Obx(() {
            return AlertDialog(
              title: Text('Add Comment'),
              content: SingleChildScrollView(
                // Cho phép cuộn nếu cần
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: imageProvider,
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          '${userInfo.full_name}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Rating: '),
                        RatingBar.builder(
                          initialRating:
                              ratingController.ratingController.text.isEmpty
                                  ? 0.0
                                  : double.parse(
                                      ratingController.ratingController.text),
                          minRating: 0.5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              ratingController.ratingController.text =
                                  rating.toString();
                            });
                          },
                        ),
                        SizedBox(width: 8.0),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Text('Rating For: '),
                        DropdownButton<String>(
                          value: ratingController.typerController.text.isEmpty
                              ? 'MENTOR'
                              : ratingController.typerController.text,
                          items: ['MENTOR', 'WORKSHOP']
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                ratingController.typerController.text = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text('Comment:'),
                    TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: ratingController.commentController,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: ratingController.isLoading.isTrue
                      ? null
                      : () async {
                          await ratingController.commentAndRating(
                              teacherId, workshopId);
                          if (!ratingController.isLoading.isTrue) {
                            _showSuccessDialog(context);
                          } else {
                            _showFalieDialog(context);
                          }
                        },
                  child: ratingController.isLoading.isTrue
                      ? CircularProgressIndicator()
                      : Text('Submit'),
                ),
              ],
            );
          });
        },
      );
    },
  );
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text('Your comment has been successfully submitted.'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
          ),
        ],
      );
    },
  );
}

void _showFalieDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Fail'),
        content: Text('Your comment has been Fail .'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
          ),
        ],
      );
    },
  );
}

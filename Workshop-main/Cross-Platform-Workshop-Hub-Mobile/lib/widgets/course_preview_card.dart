

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/api/api_service.dart';

class CoursePreviewCard extends StatefulWidget {
  final int courseid;
  final int teacherid;
  final String courseTitle;
  final String instructor;
  final String imageAsset;
  final double rating;
  final String price;
  final String time;
  final String avatarImageAsset;
  final String authorName;

  CoursePreviewCard({
    required this.courseid,
    required this.teacherid,
    required this.courseTitle,
    required this.instructor,
    required this.imageAsset,
    required this.rating,
    required this.price,
    required this.time,
    required this.avatarImageAsset,
    required this.authorName,
  });

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    return token;
  }

  @override
  _CoursePreviewCardState createState() => _CoursePreviewCardState();
}

class _CoursePreviewCardState extends State<CoursePreviewCard> {
  late Future<bool> isFavoriteFuture;

  @override
  void initState() {
    super.initState();
    isFavoriteFuture = _checkFavoriteStatus();
  }

  Future<bool> _checkFavoriteStatus() async {
    String? token = await CoursePreviewCard.getToken();
    if (token != null) {
      final apiService = ApiService();
      return await apiService.checklike(widget.courseid, token);
    }
    return false;
  }

  ImageProvider<Object> getAvatarImage() {
    if (widget.avatarImageAsset.startsWith('http') || widget.avatarImageAsset.startsWith('https')) {
      return NetworkImage(widget.avatarImageAsset);
    } else {
      return AssetImage('lib/assets/avatar.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFavoriteFuture,
      builder: (context, snapshot) {
        bool isFavorite = snapshot.data ?? false;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(0),
                        ),
                        child: Image.network(
                          widget.imageAsset,
                          width: 110,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.courseTitle,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Instructor: ${widget.instructor}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${widget.rating}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.access_time,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.time,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: getAvatarImage(),
                                  radius: 15,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.authorName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () async {
                      String? token = await CoursePreviewCard.getToken();
                      if (token != null) {
                        final apiService = ApiService();
                        
                        await apiService.like(widget.teacherid, "WORKSHOP", widget.courseid, token);
                        setState(() {
                           isFavoriteFuture = _checkFavoriteStatus();                   
                        });
                      }
                    },
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Text(
                    '\$${widget.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

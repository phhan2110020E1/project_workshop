// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/teacher/ListTeacherSortByRating.dart';

class TopMentorsSection extends StatefulWidget {
  final Future<List<ListTeacherSortRating>> mentorsFuture;

  TopMentorsSection({required this.mentorsFuture});

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    return token;
  }

  @override
  State<TopMentorsSection> createState() => _TopMentorsSectionState();
}

class _TopMentorsSectionState extends State<TopMentorsSection> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _checkFavoriteStatus(int id) async {
    String? token = await TopMentorsSection.getToken();
    if (token != null) {
      final apiService = ApiService();
      return await apiService.checklikeMentor(id, token);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Top Mentors",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
          FutureBuilder<List<ListTeacherSortRating>>(
            future: widget.mentorsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return buildMentorList(snapshot.data!);
              } else {
                return const Text('No mentors available');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildMentorList(List<ListTeacherSortRating> mentors) {
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mentors.length,
        itemBuilder: (context, index) {
          var mentor = mentors[index];
          return FutureBuilder<bool>(
            future: _checkFavoriteStatus(mentor.id),
            builder: (context, snapshot) {
              bool isLiked = snapshot.data ?? false;
              return buildAvatar(mentor.id, mentor.fullName,
                  mentor.imageUrl, mentor.rating, isLiked);
            },
          );
        },
      ),
    );
  }

  Widget buildAvatar(int id, String name, String? imageUrl, double rating, bool isLiked) {
    ImageProvider<Object> getImageProvider(String? avatarImage) {
      return avatarImage == null
          ? const AssetImage('lib/assets/avatar.jpg') as ImageProvider<Object>
          : NetworkImage(avatarImage);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: getImageProvider(imageUrl),
              ),
              Positioned(
                right: -22,
                top: -15,
                child: IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 24,
                  ),
                  onPressed: () async {
                    String? token = await TopMentorsSection.getToken();
                    if (token != null) {
                      final apiService = ApiService();
                      await apiService.like(id, "TEACHER", id, token);
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Text(
                '$rating',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

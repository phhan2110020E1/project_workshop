// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/student/favorite.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';

class FavoritePage extends StatefulWidget {
  final UserInfoResponse userInfoResponse;
  final List<FavoriteDTO> listFavorite;
  const FavoritePage(
      {Key? key, required this.userInfoResponse, required this.listFavorite})
      : super(key: key);

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    return token;
  }

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<Teacher> teachers;
  late List<Workshop> workshops;
  late Future<bool> isFavoriteMentor;
  late Future<bool> isFavoriteWorkshop;
  @override
  void initState() {
    super.initState();
    _initializeData();
    _updateFavoriteWorkShopStatus();
    _updateFavoriteMentorStatus();
  }


  void _initializeData() {
    teachers = widget.listFavorite
        .where((favorite) => favorite.targetType == "TEACHER")
        .map((favorite) => Teacher(
            workshop_id: favorite.workId,
            id: favorite.teacherId,
            name: favorite.teacherName,
            rating: favorite.totalRating,
            totalWorkshops: favorite.totalLike.toInt(),
            likeCount: favorite.totalLike.toInt(),
            imageUrl: favorite.teacherImage))
        .toList();

    workshops = widget.listFavorite
        .where((favorite) => favorite.targetType == "WORKSHOP")
        .map((favorite) => Workshop(
            teacher_id: favorite.teacherId,
            id: favorite.workId,
            name: favorite.workName,
            rating: favorite.totalWorkshopRating,
            likeCount: favorite.totalWorkshopLike.toInt(),
            imageUrl: favorite.workImage))
        .toList();
  }

  Future<void> _updateFavoriteWorkShopStatus() async {
    String? token = await FavoritePage.getToken();
    if (token != null) {
      final apiService = ApiService();
      for (int i = 0; i < workshops.length; i++) {
        bool isFavorite = await apiService.checklike(workshops[i].id, token);
        setState(() {
          workshops[i].isLiked = isFavorite;
        });
      }
    }
  }

  Future<void> _updateFavoriteMentorStatus() async {
    String? token = await FavoritePage.getToken();
    if (token != null) {
      final apiService = ApiService();
      for (int i = 0; i < teachers.length; i++) {
        bool isFavorite =
            await apiService.checklikeMentor(teachers[i].id, token);
        setState(() {
          teachers[i].isLiked = isFavorite;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Teachers'),
              Tab(text: 'Workshops'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
             if(teachers.isNotEmpty)
            _buildTeacherListView(teachers)
             else
             const Center(child:  Text("Mentor Favorite is Empty")),        
            if(workshops.isNotEmpty)
            _buildWorkshopListView(workshops)
            else
             const Center(child:  Text("workshops Favorite is Empty")),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherListView(List<Teacher> teachers) {
    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        Teacher teacher = teachers[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(teacher.imageUrl, fit: BoxFit.cover),
              ),
            ),
            title: Text(teacher.name),
            subtitle: Text(
                'Rating: ${teacher.rating} - Workshops: ${teacher.totalWorkshops}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${teacher.likeCount}'),
                IconButton(
                  icon: Icon(
                    teacher.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: teacher.isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: ()async {
                     String? token = await FavoritePage.getToken();
                    if (token != null) {
                      final apiService = ApiService();
                      await apiService.like(
                          teacher.id, "TEACHER", teacher.workshop_id, token);
                      setState(() {
                        _updateFavoriteWorkShopStatus();
                         teachers.removeAt(index);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWorkshopListView(List<Workshop> workshops) {
    return ListView.builder(
      itemCount: workshops.length,
      itemBuilder: (context, index) {
        Workshop workshop = workshops[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(workshop.imageUrl, fit: BoxFit.cover),
              ),
            ),
            title: Text(workshop.name),
            subtitle: Text('Rating: ${workshop.rating}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${workshop.likeCount}'),
                IconButton(
                  icon: Icon(
                    workshop.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: workshop.isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () async {
                    String? token = await FavoritePage.getToken();
                    if (token != null) {
                      final apiService = ApiService();
                      await apiService.like(
                          workshop.teacher_id, "WORKSHOP", workshop.id, token);
                      setState(() {
                        _updateFavoriteWorkShopStatus();
                         workshops.removeAt(index);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Teacher {
  int id;
  int workshop_id;

  String name;
  double rating;
  int totalWorkshops;
  int likeCount;
  String imageUrl;
  bool isLiked = false;
  Teacher({
    required this.id,
    required this.workshop_id,
    required this.name,
    required this.rating,
    required this.totalWorkshops,
    required this.likeCount,
    required this.imageUrl,
    this.isLiked = false,
  });
}

class Workshop {
  int id;
  int teacher_id;
  String name;
  double rating;
  int likeCount;
  String imageUrl;
  bool isLiked = false;
  Workshop({
    required this.id,
    required this.teacher_id,
    required this.name,
    required this.rating,
    required this.likeCount,
    required this.imageUrl,
    this.isLiked = false,
  });
}

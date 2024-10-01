// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:workshop_mobi/screens/course_screen.dart';
import 'package:workshop_mobi/widgets/video_play.dart';

class VideoSetion extends StatelessWidget {
  final CourseScreen widget;
  List videoList = [
    'Introduction to Flutter',
    'Installing Flutter on Windows',
    'Setup Emulator on Windows',
    'Creating Our First App',
  ];

  VideoSetion({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.courseResponses.courseMediaInfos.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                // Navigating to video player screen, passing the video URL
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      videoUrl: widget
                          .courseResponses.courseMediaInfos[index].urlMedia,
                    ),
                  ),
                );
              },
              child: ListTile(
                tileColor: index == 0
                    ? const Color.fromARGB(255, 60, 120, 230)
                    : const Color.fromARGB(140, 90, 145, 230),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                leading: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: index == 0
                        ? const Color(0xFF674AEF)
                        : const Color(0xFF674AEF).withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                title: Text(
                  widget.courseResponses.courseMediaInfos[index].title,
                  style: TextStyle(
                    color: index == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
                height:
                    10), // Điều chỉnh giá trị này để thêm khoảng cách giữa các ListTile
          ],
        );
      },
    );
  }
}

// Tạo một màn hình phát video đơn giản
class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Container(
        color: Colors.black, // Đặt màu nền là màu đen
        child: Center(
          child: VideoPlayerWidget(videoUrl: videoUrl),
        ),
      ),
    );
  }
}

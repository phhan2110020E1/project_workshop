// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:workshop_mobi/app_localizations.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/widgets/description_section.dart';
import 'package:workshop_mobi/widgets/videos_section.dart';

class CourseScreen extends StatefulWidget {
  CourseResponses courseResponses;
  CourseScreen(this.courseResponses);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
      widget.courseResponses.courseMediaInfos[0].urlMedia,
    );
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
    _videoPlayerController.play();
  }

  bool isVideosSection = true;
  bool isPlaying = false;

  bool isLiked = false;
  bool isLoved = false; // Declare isLiked here
// Hàm cho nút trái tim
Widget _buildHeartButton(double iconSize) {
  return Row(
    children: [
      IconButton(
        icon: Icon(
          Icons.favorite,
          color: isLoved ? Colors.red : Colors.grey,
          size: iconSize,
        ),
        onPressed: () {
          setState(() {
            isLoved = !isLoved;
          });
        },
      ),
    ],
  );
}

// Hàm cho nút like
Widget _buildThumbUpButton(double iconSize) {
  return Row(
    children: [
      IconButton(
        icon: Icon(
          Icons.thumb_up,
          color: isLiked ? Colors.blue : Colors.grey,
          size: iconSize,
        ),
        onPressed: () {
          setState(() {
            isLiked = !isLiked;
          });
        },
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.courseResponses.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications,
              size: 28,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: ListView(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_videoPlayerController),
                          if (!isPlaying)
                            IconButton(
                              icon: const Icon(
                                Icons.play_circle_fill,
                                size: 50,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPlaying = true;
                                  if (_videoPlayerController.value.isPlaying) {
                                    _videoPlayerController.pause();
                                    isPlaying = false;
                                  } else {
                                    _videoPlayerController.play();
                                    isPlaying = true;
                                  }
                                });
                              },
                            ),
                        ],
                      ),
                    );
                    
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(height: 0),
              // Row for Like button and text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WorkshopName(widget: widget),
                  _buildThumbUpButton( 30.0),
                ],
              ),
              // Add Row with Like buttons and text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CreatebyTeacherName(widget: widget),
                  _buildHeartButton( 30.0),
                ],
              ),
              CountVideo(widget: widget),
              const SizedBox(height: 20),
              
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: isVideosSection
                          ? const Color(0xFF674AEF)
                          : const Color(0xFF674AEF).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isVideosSection = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 22),
                          child: const Text(
                            "Videos",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: isVideosSection
                          ? const Color(0xFF674AEF).withOpacity(0.6)
                          : const Color(0xFF674AEF),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          //change value of isVideosSection
                          setState(() {
                            isVideosSection = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 35),
                          child: const Text(
                            "Decriptions",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              isVideosSection
                  ? VideoSetion(
                      widget: widget,
                    )
                  : DescriptionSection(
                      widget: widget,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountVideo extends StatelessWidget {
  const CountVideo({
    super.key,
    required this.widget,
  });

  final CourseScreen widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.courseResponses.courseMediaInfos.length} Videos",
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}

class CreatebyTeacherName extends StatelessWidget {
  const CreatebyTeacherName({
    super.key,
    required this.widget,
  });

  final CourseScreen widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.translateFullName(
        context,
        "Create by Dear ${widget.courseResponses.teacher}",
      ),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class WorkshopName extends StatelessWidget {
  const WorkshopName({
    super.key,
    required this.widget,
  });

  final CourseScreen widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.courseResponses.name}",
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

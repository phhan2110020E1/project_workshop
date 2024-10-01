// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:workshop_mobi/widgets/fullscreen.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true);

    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_videoPlayerController),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_videoPlayerController.value.isPlaying) {
                        _videoPlayerController.pause();
                      } else {
                        _videoPlayerController.play();
                      }
                    });
                  },
                ),
                if (!_videoPlayerController.value.isPlaying)
                  Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _videoPlayerController.play();
                        });
                      },
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.fullscreen,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenPlayer(
                                context: context,
                                videoPlayerController: _videoPlayerController,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.volume_up,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
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
    );
  }
}


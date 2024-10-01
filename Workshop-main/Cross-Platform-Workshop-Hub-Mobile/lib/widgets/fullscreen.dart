// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatelessWidget {
  final BuildContext context;
  final VideoPlayerController videoPlayerController;

  // ignore: prefer_const_constructors_in_immutables
  FullScreenPlayer({
    required this.context,
    required this.videoPlayerController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            child: orientation == Orientation.landscape
                ? _buildLandscapeView()
                : _buildPortraitView(),
          );
        },
      ),
    );
  }

  Widget _buildLandscapeView() {
    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: VideoPlayer(videoPlayerController),
    );
  }

  Widget _buildPortraitView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: VideoPlayer(videoPlayerController),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Minimize'),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ImageViewer extends StatelessWidget {
  final String imagePath;

  const ImageViewer({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Viewer')),
      body: Center(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

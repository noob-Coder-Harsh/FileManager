import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';

class SubTitle extends StatelessWidget {
  final FileSystemEntity entity;

  const SubTitle({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: entity.stat(),
      builder: (BuildContext context, AsyncSnapshot<FileStat> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...'); // You might want to show a loading indicator while waiting for the file stat.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          int size = snapshot.data!.size;
          String formattedSize = FileManager.formatBytes(size);
          String modified = snapshot.data!.modified.toString();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Size: $formattedSize'),
              Text('Modified: $modified'),
            ],
          );
        }
      },
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectStorageDialog extends StatelessWidget {
  final FileManagerController controller;

  const SelectStorageDialog({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FutureBuilder<List<Directory>>(
        future: FileManager.getStorageList(),
        builder: (context, snapshot) {
          final List<Directory>? storage = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: storage!.map(
                  (e) => ListTile(
                title: Text(FileManager.basename(e)),
                onTap: () {
                  controller.openDirectory(e);
                  Navigator.pop(context);
                },
              ),
            ).toList(),
          );
        },
      ),
    );
  }
}

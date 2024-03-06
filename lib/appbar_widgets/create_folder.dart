import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateFolderDialog extends StatelessWidget {
  final FileManagerController controller;

  const CreateFolderDialog({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController folderCreateController = TextEditingController();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: TextField(
                controller: folderCreateController,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FileManager.createFolder(controller.getCurrentPath, folderCreateController.text);
                  controller.setCurrentPath = "${controller.getCurrentPath}/${folderCreateController.text}";
                } catch (e) {
                  Navigator.pop(context);
                }
                Navigator.of(context).pop();
              },
              child: const Text('create folder'),
            ),
          ],
        ),
      ),
    );
  }
}

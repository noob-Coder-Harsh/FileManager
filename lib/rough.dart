
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project1/widgets/list_items.dart';

import 'appbar_widgets/custom_appbar.dart';

class FileManagerPage extends StatefulWidget {
  const FileManagerPage({super.key, required this.title});
  final String title;

  @override
  State<FileManagerPage> createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FileManagerPage> {
  late final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await requestStoragePermission();
        },
        label: const Text("Request File Access Permission"),
      ),
      appBar: CustomAppBar(controller: controller,),
      body: const ListItems(),
    );
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, you can proceed with your logic here
      List<Directory>? storageList = await FileManager.getStorageList();
      if (storageList.isNotEmpty) {
        // Assuming you want to open the first storage directory
        Directory storageDirectory = storageList[0];
        // Now you can show files and folders in this directory using FileManager
        // For example:
        controller.openDirectory(storageDirectory);
      } else {
        print('No storage directories found, handle accordingly');
        // No storage directories found, handle accordingly
      }
    } else {
      print('Permission denied, handle accordingly (show a message, disable functionality, etc.)');
      // Permission denied, handle accordingly (show a message, disable functionality, etc.)
    }
  }
}



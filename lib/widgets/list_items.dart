import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_manager/file_manager.dart';
import 'package:project1/widgets/subtitle.dart'; // Ensure the correct import path

class ListItems extends StatefulWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  late final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return FileManager(
      controller: controller, // Make sure controller is properly initialized
      builder: (context, snapshot) {
        final List<FileSystemEntity> entities = snapshot;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          itemCount: entities.length,
          itemBuilder: (context, index) {
            FileSystemEntity entity = entities[index];
            return Card(
              child: ListTile(
                onTap: () {
                  if (FileManager.isDirectory(entity)) {
                    controller.openDirectory(entity);
                  } else {
                    // Handle file tap
                  }
                },
                leading: FileManager.isFile(entity)
                    ? const Icon(Icons.feed_outlined)
                    : const Icon(Icons.folder),
                title: Text(FileManager.basename(
                  entity,
                  showFileExtension: true,
                )),
                subtitle: SubTitle(entity: entity), // Use SubTitle widget here
              ),
            );
          },
        );
      },
    );
  }
}

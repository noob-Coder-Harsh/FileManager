import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';

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
      appBar: appBar(context),
      body: FileManager(
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
                  subtitle: subTitle(entity),
                ),
              );
            },
          );
        },
      ),
    );
  }

  appBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () => createFolder(context),
            icon: const Icon(Icons.create_new_folder_outlined)),
        IconButton(onPressed: () => sort(context), icon: const Icon(Icons.sort_rounded)),
        IconButton(
            onPressed: ()=> selectStorage(context), icon: const Icon(Icons.sd_storage_rounded)),
      ],
      title: ValueListenableBuilder(
        valueListenable: controller.titleNotifier,
        builder: (context, String value, Widget? child) {
          return Text(value);
        },
      ),
      leading: IconButton(
        onPressed: () async {
          await controller.goToParentDirectory();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  createFolder(BuildContext context) async {
    TextEditingController folderCreateController = TextEditingController(); // Initialize TextEditingController
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: TextField(
                    controller: folderCreateController, // Use folderCreateController
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
      },
    );
  }

  sort(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Name'),
                    onTap: (){
                      controller.sortBy(SortBy.name);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Size'),
                    onTap: (){
                      controller.sortBy(SortBy.size);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Date'),
                    onTap: (){
                      controller.sortBy(SortBy.date);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Type'),
                    onTap: (){
                      controller.sortBy(SortBy.type);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  selectStorage(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context){
      return Dialog(child: FutureBuilder<List<Directory>>(future: FileManager.getStorageList(),
        builder: (context,snapshot){
          final List<Directory>?storage = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: storage!.map((e) => ListTile(title: Text(FileManager.basename(e)),
              onTap: (){controller.openDirectory(e);
              Navigator.pop(context);},)).toList(),
          );
        },),);
    });
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

subTitle(FileSystemEntity entity) {
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

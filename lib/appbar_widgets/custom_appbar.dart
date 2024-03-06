import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';

import 'package:project1/appbar_widgets/sort.dart';
import 'package:project1/select_storage.dart';
import 'package:project1/appbar_widgets/create_folder.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FileManagerController controller;

  const CustomAppBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateFolderDialog(controller: controller),
            ),
          ),
          icon: const Icon(Icons.create_new_folder_outlined),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SortDialog(controller: controller),
            ),
          ),
          icon: const Icon(Icons.sort_rounded),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SelectStorageDialog(controller: controller),
            ),
          ),
          icon: const Icon(Icons.sd_storage_rounded),
        ),
      ],
      title: ValueListenableBuilder(
        valueListenable: controller.titleNotifier,
        builder: (context, String value, Widget? child) {
          return Text(value);
        },
      ),
      leading: IconButton(
        onPressed: () async {
          await controller.goToParentDirectory(); // Call method to navigate to the parent directory
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class SortDialog extends StatelessWidget {
  final FileManagerController controller;

  const SortDialog({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: const Text('Name'),
              onTap: () {
                controller.sortBy(SortBy.name);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Size'),
              onTap: () {
                controller.sortBy(SortBy.size);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Date'),
              onTap: () {
                controller.sortBy(SortBy.date);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Type'),
              onTap: () {
                controller.sortBy(SortBy.type);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

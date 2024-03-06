import 'package:flutter/material.dart';

import 'file_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Manager App',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue
      ),
      home: const FileManagerPage(),
    );
  }
}
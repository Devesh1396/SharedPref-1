import 'package:flutter/material.dart';
import 'package:shared_prefs_1/HomeUI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeUI(),
      debugShowCheckedModeBanner: false,
    );
  }
}




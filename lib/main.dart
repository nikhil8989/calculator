import 'package:flutter/material.dart';

import './ress/utils/app_theme.dart';

import 'ress/screen/home/home.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: AppTheme.intance.accent,
          ),
          scaffoldBackgroundColor: AppTheme.intance.accent),
      home: const Home(),
    );
  }
}

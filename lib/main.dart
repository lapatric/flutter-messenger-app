import 'package:flutter/material.dart';
import 'package:messenger_app/screens/screens.dart';
import 'package:messenger_app/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark, // if not set here, it picks device default
      title: 'Chatter',
      home: const HomeScreen(),
    );
  }
}

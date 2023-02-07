import 'package:flutter/material.dart';
import 'package:messenger_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      theme:,
      title: 'Chatter',
      home: HomeScreen(),
    );
  }
}

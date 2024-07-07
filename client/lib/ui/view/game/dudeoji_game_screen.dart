import 'package:flutter/material.dart';

class DudeojiGameScreen extends StatelessWidget {
  final String title;
  const DudeojiGameScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('This is Game A screen'),
      ),
    );
  }
}

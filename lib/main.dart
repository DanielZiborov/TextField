import 'package:flutter/material.dart';
import 'package:text_field/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          title: const Text('TextField'),
          centerTitle: true,
        ),
        body: const Example(),
      ),
    );
  }
}

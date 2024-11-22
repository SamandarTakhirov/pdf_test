import 'package:flutter/material.dart';
import 'package:pdf_test/feature/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF',
      home: HomeScreen(),
    );
  }
}

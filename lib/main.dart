import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Import your custom home page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: child!,
        );
      },
// Redirect to pages/home_page.dart
    );
  }
}

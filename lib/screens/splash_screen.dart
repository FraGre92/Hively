import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const HivelyApp());
}

class HivelyApp extends StatelessWidget {
  const HivelyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hively',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

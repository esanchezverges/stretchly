import 'package:flutter/material.dart';
import 'ui/home/home_screen.dart';
import 'ui/theme/app_theme.dart';

void main() => runApp(const StretchlyApp());

class StretchlyApp extends StatelessWidget {
  const StretchlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stretchly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}

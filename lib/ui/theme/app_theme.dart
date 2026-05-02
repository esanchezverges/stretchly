import 'package:flutter/material.dart';

class AppTheme {
  static const _seed = Color(0xFF4A7C59);
  static const _background = Color(0xFFFAFAF7);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          surface: _background,
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/providers.dart';
import 'ui/auth/login_screen.dart';
import 'ui/home/home_screen.dart';
import 'ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const StretchlyApp(),
    ),
  );
}

class StretchlyApp extends ConsumerWidget {
  const StretchlyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);

    return MaterialApp(
      title: 'stretchly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Reactive routing: changes instantly when user logs in/out
      home: userId != null ? const HomeScreen() : const LoginScreen(),
    );
  }
}

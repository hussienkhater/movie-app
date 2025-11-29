import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_theme.dart';
import 'package:movie_app/feature/test_feature/view/screens/home_screen.dart';
import 'package:movie_app/feature/test_feature/view/screens/splach_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: HomeScreen.routeName,
      routes: {
        SplachScreen.routeName: (context) => const SplachScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}

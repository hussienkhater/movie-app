import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/feature/test_feature/view/screens/home_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});
  static const routeName = 'SplachScreen';

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShakeX(
              duration: Duration(seconds: 2),
              child: Image.asset(AppImages.logo),
            ),
          ],
        ),
      ),
    );
  }
}

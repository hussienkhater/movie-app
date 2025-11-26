import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.whiteGrey, size: 30),
          onPressed: () {},
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.whiteGrey,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color:AppColors.whiteGrey, size: 30),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
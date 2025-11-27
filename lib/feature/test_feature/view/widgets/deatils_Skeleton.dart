import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

Widget shimmerBox({double? width, double? height, double radius = 8}) {
  return Shimmer(
    color: Colors.grey.shade700,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

class DetailsSkeleton extends StatelessWidget {
  const DetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.background,
          expandedHeight: 260,
          pinned: true,
          flexibleSpace: const FlexibleSpaceBar(
            background: SizedBox.shrink(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                shimmerBox(width: 18, height: 18, radius: 4),
                const SizedBox(width: 8),
                shimmerBox(width: 40, height: 16),
                const SizedBox(width: 12),
                shimmerBox(width: 18, height: 18, radius: 4),
                const SizedBox(width: 8),
                shimmerBox(width: 70, height: 16),
                const SizedBox(width: 12),
                Expanded(child: shimmerBox(height: 16)),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: shimmerBox(height: 120, radius: 10),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: shimmerBox(width: 100, height: 22),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 180,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, __) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerBox(width: 120, height: 120, radius: 12),
                  const SizedBox(height: 8),
                  shimmerBox(width: 120, height: 14),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

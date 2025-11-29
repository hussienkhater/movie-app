import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

class ReleaseMovieItemWidget extends StatelessWidget {
  const ReleaseMovieItemWidget({super.key, this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
            width: 100,
            height: 145,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageUrl == null || imageUrl!.isEmpty
                  ? Container(color: AppColors.grey)
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageUrl!,
                      placeholder: (context, url) =>
                          Container(color: AppColors.primary),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
          ),
    );
  }
}

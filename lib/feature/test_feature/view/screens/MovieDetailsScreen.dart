import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/feature/test_feature/view/screens/WatchlistScreen.dart';
import 'package:movie_app/feature/test_feature/view/widgets/deatils_Skeleton.dart';
import 'package:movie_app/feature/test_feature/view_model/details_cubit.dart';
import 'package:movie_app/feature/test_feature/view_model/details_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  static const String _similarTitle = 'Similar';
  static const String _noSimilarFound = 'No similar movies found.';
  static const String _retryText = 'Retry';

  String? _imageUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    return 'https://image.tmdb.org/t/p/w500$path';
  }

  Widget _networkImageNullable(
    String? path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    final url = _imageUrl(path);
    if (url == null) {
      return Container(
        width: width,
        height: height,
        color: AppColors.primary,
        child: const Icon(Icons.image, color: AppColors.whiteGrey),
      );
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return shimmerBox(width: width, height: height);
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: AppColors.primary,
          child: const Icon(Icons.broken_image, color: AppColors.whiteGrey),
        );
      },
    );
  }

  void _openWatchlist(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WatchlistScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit()..fetchDetailsFirstThenSimilar(movieId),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              if (state.status == DetailsStatus.loading ||
                  state.status == DetailsStatus.initial) {
                return const DetailsSkeleton();
              }

              if (state.status == DetailsStatus.failure) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DetailsCubit>().refresh(movieId);
                        },
                        child: const Text(_retryText),
                      )
                    ],
                  ),
                );
              }

              final movie = state.details!;
              final similar = state.similar;

              final title = movie.title;
              final rating = movie.voteAverage.toStringAsFixed(1);
              final year = movie.releaseDate.split('-').first;
              final runtime =
                  movie.runtime > 0 ? '${movie.runtime} Minutes' : '';
              final genres = movie.genres.map((e) => e.name).join(', ');
              final overview = movie.overview;
              final backdropPath = movie.backdropPath ?? movie.posterPath;

              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.background,
                    expandedHeight: 260,
                    pinned: true,
                    stretch: true,
                    leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          AppIcons.arrowBack,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () => _openWatchlist(context),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            AppIcons.save,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.only(left: 56, bottom: 12),
                      title: Text(title, style: const TextStyle(fontSize: 14)),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          _networkImageNullable(backdropPath,
                              fit: BoxFit.cover),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            bottom: 12,
                            child: Row(
                              children: [
                                if (movie.posterPath != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: _networkImageNullable(
                                      movie.posterPath,
                                      width: 90,
                                      height: 130,
                                    ),
                                  ),
                                const SizedBox(width: 12),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          AppIcons.star,
                                          width: 16,
                                          color: AppColors.rateColor,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          rating,
                                          style: const TextStyle(
                                              color: AppColors.white),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.calendar,
                            color: AppColors.whiteGrey,
                            width: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(year,
                              style:
                                  const TextStyle(color: AppColors.whiteGrey)),
                          const SizedBox(width: 12),
                          if (runtime.isNotEmpty) ...[
                            SvgPicture.asset(
                              AppIcons.clock,
                              color: AppColors.whiteGrey,
                              width: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(runtime,
                                style: const TextStyle(color: AppColors.white)),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Text(
                              genres,
                              style:
                                  const TextStyle(color: AppColors.whiteGrey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        overview,
                        style: const TextStyle(
                          color: AppColors.whiteGrey,
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 25)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _similarTitle,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 15)),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 180,
                      child: similar.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                child: Text(
                                  _noSimilarFound,
                                  style: TextStyle(color: AppColors.whiteGrey),
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: similar.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              primary: false,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final m = similar[index];
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                        movieId: m.id.toString(),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: _networkImageNullable(
                                          m.posterPath,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          m.title,
                                          style: const TextStyle(
                                              color: AppColors.whiteGrey),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 30)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

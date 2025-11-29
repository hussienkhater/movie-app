import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/feature/test_feature/view/widgets/popular_movie_item_widget.dart';
import 'package:movie_app/feature/test_feature/view/widgets/top_rated_item_widget.dart';
import 'package:movie_app/feature/test_feature/view_model/popular_movies_cubit.dart';
import 'package:movie_app/feature/test_feature/view_model/popular_movies_state.dart';
import 'package:movie_app/feature/test_feature/view_model/realease_movie_cubit.dart';
import 'package:movie_app/feature/test_feature/view_model/realease_movie_state.dart';
import 'package:movie_app/feature/test_feature/view_model/top_rated_cubit.dart';
import 'package:movie_app/feature/test_feature/view_model/top_rated_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late TopRatedCubit topRatedCubit;
  late PopularMoviesCubit popularCubit;
  @override
  void initState() {
    super.initState();
    topRatedCubit = TopRatedCubit();
    topRatedCubit.getTopRatedMovies();
    popularCubit = PopularMoviesCubit();
    popularCubit.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 24),
              child: Text(
                'What do you want to watch?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 260,
              child: BlocBuilder<TopRatedCubit, TopRatedState>(
                bloc: topRatedCubit,
                builder: (context, state) {
                  if (state is TopRatedLoading) {
                    return Skeletonizer(
                      effect: const ShimmerEffect(),
                      enabled: true,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 180,
                            width: 145,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          );
                        },
                        itemCount: 20,
                      ),
                    );
                  }
                  if (state is TopRatedSuccess) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TopRatedItemWidget(
                          imageUrl: state.movies[index].fullPosterTopRatedUrl,
                          index: index,
                        );
                      },
                      itemCount: state.movies.length,
                    );
                  }
                  if (state is TopRatedError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextTheme.of(context).bodyMedium,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                'Popular',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 145,
              child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                bloc: popularCubit,
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return Skeletonizer(
                      effect: const ShimmerEffect(),
                      enabled: true,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 145,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          );
                        },
                        itemCount: 20,
                      ),
                    );
                  }
                  if (state is PopularMoviesSuccess) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 0,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return PopularMovieItemWidget(
                          imageUrl: state.movies[index].fullPosterPopularUrl,
                        );
                      },
                      itemCount: state.movies.length,
                    );
                  }
                  if (state is PopularMoviesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextTheme.of(context).bodyMedium,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                'Released This Week',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 145,
              child: BlocBuilder<ReleaseMoviesCubit, ReleaseMoviesState>(
                bloc: ReleaseMoviesCubit(),
                builder: (context, state) {
                  if (state is ReleaseMoviesLoading) {
                    return Skeletonizer(
                      effect: const ShimmerEffect(),
                      enabled: true,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 145,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          );
                        },
                        itemCount: 20,
                      ),
                    );
                  }
                  if (state is ReleaseMoviesSuccess) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 0,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return PopularMovieItemWidget(
                          imageUrl: state.movies[index].fullPosterReleaseUrl,
                        );
                      },
                      itemCount: state.movies.length,
                    );
                  }
                  if (state is ReleaseMoviesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

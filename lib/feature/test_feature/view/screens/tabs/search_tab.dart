import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/feature/test_feature/data/model/search_movie_model.dart';
import 'package:movie_app/core/common/widgets/custom_appBar.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/app_dialog.dart';
import 'package:movie_app/feature/test_feature/view/widgets/search_item.dart';
import 'package:movie_app/feature/test_feature/view_model/cubit/search_cubit.dart';
import 'package:movie_app/feature/test_feature/view_model/states/search_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late SearchCubit searchCubit;
  final FocusNode _searchFocusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    searchCubit = SearchCubit();

    _searchFocusNode.addListener(() {
      setState(() {
        _isFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Search'),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: _searchFocusNode,
                  style: const TextStyle(color: AppColors.white),
                  onChanged: (value) => searchCubit.searchMovies(value),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        AppIcons.search,
                        colorFilter: ColorFilter.mode(
                          _isFocused ? AppColors.rateColor : AppColors.whiteGrey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                )),
            Expanded(
              child: BlocConsumer<SearchCubit, SearchState>(
                bloc: searchCubit,
                listener: (context, state) {
                  if (state is SearchError) {
                    AppDialog.showErrorDialog(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Skeletonizer(
                      enabled: true,
                      effect: ShimmerEffect(
                        baseColor: AppColors.primary,
                        highlightColor: AppColors.whiteGrey,
                        duration: const Duration(seconds: 3),
                      ),
                      child: ListView.separated(
                        itemCount: 6,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 24),
                        itemBuilder: (context, index) {
                          return SearchItem(
                            movie: Results(
                              title: "Loading Movie Title Name",
                              releaseDate: "2003-07-07",
                              voteAverage: 0.0,
                              posterPath: null,
                            ),
                          );
                        },
                      ),
                    );
                  }

                  if (state is SearchError) {
                    return Center(child: Image.asset(AppIcons.emptySearch));
                  }

                  if (state is SearchSuccess) {
                    if (state.movies.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppIcons.emptySearch),
                            const SizedBox(height: 10),
                            Text("We are sorry, we can not find the movie :(",
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            Text(
                              "Find your movie by Type title, categories, years, etc ",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: state.movies.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        return SearchItem(movie: state.movies[index]);
                      },
                    );
                  }
                  return Center(child: Image.asset(AppIcons.emptySearch));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

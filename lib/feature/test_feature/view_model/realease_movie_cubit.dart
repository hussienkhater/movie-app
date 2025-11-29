import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/test_feature/data/api/release_movies_api.dart';
import 'package:movie_app/feature/test_feature/data/model/realease_movies_model.dart';
import 'package:movie_app/feature/test_feature/view_model/realease_movie_state.dart';


class ReleaseMoviesCubit extends Cubit<ReleaseMoviesState> {
  ReleaseMoviesCubit() : super(ReleaseMoviesInitial());
  List<Results> movies = [];
  Future<void> getReleaseMovies() async {
    emit(ReleaseMoviesLoading());
    final result = await ReleaseMoviesApi.getReleaseMovies();
    switch (result) {
      case SuccessApi<ReleaseMovieModel>():
        emit(ReleaseMoviesSuccess(result.data.results??[]));
      case ErrorApi<ReleaseMovieModel>():
        emit(ReleaseMoviesError(result.messageError));
    }
  }
}

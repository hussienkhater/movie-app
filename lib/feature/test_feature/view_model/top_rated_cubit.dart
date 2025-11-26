import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/test_feature/data/api/top_rated_movies_api.dart';
import 'package:movie_app/feature/test_feature/data/model/top_rated_movies_model.dart';
import 'package:movie_app/feature/test_feature/view_model/top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit() : super(TopRatedInitial());
    List<Results> movies = [];

  Future<void> getTopRatedMovies() async {
    emit(TopRatedLoading());
    final result = await TopRatedMoviesApi.getTopRatedMoviesModel();
    switch (result) {
      case SuccessApi<TopRatedMoviesModel>():
        emit(TopRatedSuccess(result.data.results??[]));
      case ErrorApi<TopRatedMoviesModel>():
        emit(TopRatedError(result.messageError));
      case LoadingApi<TopRatedMoviesModel>():
        emit(TopRatedLoading());
    }
  }
}

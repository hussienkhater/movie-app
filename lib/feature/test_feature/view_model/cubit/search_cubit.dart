import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/test_feature/data/api/search_movie_api.dart';
import 'package:movie_app/feature/test_feature/data/model/search_movie_model.dart';
import 'package:movie_app/feature/test_feature/view_model/states/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await SearchMoviesApi.searchMovies(query);

    switch (result) {
      case SuccessApi<SearchMovieModel>():
        emit(SearchSuccess(result.data.results ?? []));

      case ErrorApi<SearchMovieModel>():
        emit(SearchError(result.messageError));
    }
  }
}

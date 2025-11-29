
import 'package:movie_app/feature/test_feature/data/model/search_movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  SearchSuccess(this.movies);
  final List<Results> movies;
}

class SearchError extends SearchState {
  SearchError(this.message);
  final String message;
}
import 'package:movie_app/feature/test_feature/data/model/realease_movies_model.dart';

abstract class ReleaseMoviesState {}

final class ReleaseMoviesInitial extends ReleaseMoviesState {}

final class ReleaseMoviesLoading extends ReleaseMoviesState {}
final class ReleaseMoviesSuccess extends ReleaseMoviesState {
  ReleaseMoviesSuccess(this.movies);
  final List<Results> movies;
}

final class ReleaseMoviesError extends ReleaseMoviesState {
  ReleaseMoviesError(this.message);
  final String message;
}
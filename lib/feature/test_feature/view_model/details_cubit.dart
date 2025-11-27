import 'package:flutter_bloc/flutter_bloc.dart';
import 'details_state.dart';
import 'package:movie_app/feature/test_feature/data/api/deatails_api.dart';
import 'package:movie_app/feature/test_feature/data/api/simaler_movie_api.dart';
import 'package:movie_app/feature/test_feature/data/model/details_model.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(const DetailsState());

  Future<void> fetch(String movieId) async {
    emit(state.copyWith(status: DetailsStatus.loading, errorMessage: null));
    try {
      final MovieDetailsModel details = await DetailsApi.getDetailsApi(movieId);
      final List<SimilarMovie> similar = await getSimilarMovies(movieId);
      emit(state.copyWith(
        status: DetailsStatus.success,
        details: details,
        similar: similar,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: DetailsStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> fetchDetailsFirstThenSimilar(String movieId) async {
    emit(state.copyWith(status: DetailsStatus.loading, errorMessage: null));
    try {
      final MovieDetailsModel details = await DetailsApi.getDetailsApi(movieId);
      emit(state.copyWith(status: DetailsStatus.success, details: details));
    } catch (e) {
      emit(state.copyWith(
          status: DetailsStatus.failure, errorMessage: e.toString()));
      return;
    }

    try {
      final List<SimilarMovie> similar = await getSimilarMovies(movieId);
      emit(state.copyWith(similar: similar));
    } catch (_) {}
  }

  Future<void> refresh(String movieId) => fetch(movieId);
}

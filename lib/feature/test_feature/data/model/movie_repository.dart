import 'package:movie_app/feature/test_feature/data/api/deatails_api.dart';
import 'package:movie_app/feature/test_feature/data/api/simaler_movie_api.dart';
import 'package:movie_app/feature/test_feature/data/model/details_model.dart';

class MovieRepository {
  const MovieRepository();

  Future<MovieDetailsModel> fetchDetails(String movieId) =>
      DetailsApi.getDetailsApi(movieId);

  Future<List<SimilarMovie>> fetchSimilar(String movieId) =>
      getSimilarMovies(movieId);
}

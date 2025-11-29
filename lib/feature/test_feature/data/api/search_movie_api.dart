import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/core/utils/app_apis.dart';
import 'package:movie_app/feature/test_feature/data/model/search_movie_model.dart';

class SearchMoviesApi {
  static Future<ResultApi<SearchMovieModel>> searchMovies(String query) async {
    Uri url = Uri.https(
      AppApis.baseUrl,
      AppApis.searchEndpoint,
      {
        'api_key': AppApis.apiKey,
        'query': query,
      },
    );

    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      var data = SearchMovieModel.fromJson(json);
      return SuccessApi<SearchMovieModel>(data);
    } catch (e) {
      return ErrorApi<SearchMovieModel>(e.toString());
    }
  }
}
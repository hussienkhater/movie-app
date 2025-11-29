import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/core/utils/app_apis.dart';
import 'package:movie_app/feature/test_feature/data/model/realease_movies_model.dart';

class ReleaseMoviesApi {
  static Future<ResultApi<ReleaseMovieModel>> getReleaseMovies() async {
    Uri url = Uri.https(
      AppApis.baseUrl,
      AppApis.releaseMovieUrl,
      {
        'api_key': AppApis.apiKey,
      },
    );
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      var data = ReleaseMovieModel.fromJson(json);
      return SuccessApi<ReleaseMovieModel>(data);
    } catch (e) {
      return ErrorApi<ReleaseMovieModel>(e.toString());
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/feature/test_feature/data/model/details_model.dart';

class DetailsApi {
  static const String _apiKey = 'da115ea4c9a2599ecc27cf04e380b69d';

  static Future<MovieDetailsModel> getDetailsApi(String movieId) async {
    final uri = Uri.https(
      'api.themoviedb.org',
      '/3/movie/$movieId',
      {'api_key': _apiKey},
    );

    // print('TMDB GET -> $uri');

    final response = await http.get(uri);

    // print('status: ${response.statusCode}');
    // print(
    //     'body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(jsonData);
    } else {
      String message =
          'Failed to fetch details (status: ${response.statusCode})';
      try {
        final Map<String, dynamic> err = jsonDecode(response.body);
        if (err.containsKey('status_message')) {
          message += ': ${err['status_message']}';
        }
      } catch (_) {}
      throw Exception(message);
    }
  }
}

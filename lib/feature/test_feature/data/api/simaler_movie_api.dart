import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/feature/test_feature/data/model/details_model.dart';

const String _tmdbApiKey = 'da115ea4c9a2599ecc27cf04e380b69d';

Future<List<SimilarMovie>> getSimilarMovies(String movieId,
    {int page = 1}) async {
  final uri = Uri.https(
    'api.themoviedb.org',
    '/3/movie/$movieId/similar',
    {
      'api_key': _tmdbApiKey,
      'page': page.toString(),
    },
  );

  try {
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    debugPrint('GET $uri');
    debugPrint('status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> results =
          (jsonData['results'] as List<dynamic>?) ?? [];

      final list = results
          .map((e) => SimilarMovie.fromJson(e as Map<String, dynamic>))
          .toList();

      for (var i = 0; i < list.length && i < 5; i++) {
        debugPrint('similar[$i] poster_path: ${list[i].posterPath}');
      }

      return list;
    } else {
      String message =
          'Failed to fetch similar movies (status: ${response.statusCode})';
      try {
        final Map<String, dynamic> err = jsonDecode(response.body);
        if (err.containsKey('status_message'))
          message += ': ${err['status_message']}';
      } catch (_) {}
      throw Exception(message);
    }
  } on SocketException {
    throw Exception('No internet connection');
  } on http.ClientException catch (e) {
    throw Exception('HTTP client error: $e');
  } on TimeoutException {
    throw Exception('Request timed out');
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}

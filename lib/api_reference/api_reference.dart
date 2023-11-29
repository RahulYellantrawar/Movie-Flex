import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/constants/api_constants.dart';
import 'package:movies/models/movie_entity.dart';

class Api {
  static const _trendingUrl =
      '${ApiConstants.trendingUrl}${ApiConstants.API_KEY}';
  static const _nowPlayingUrl =
      '${ApiConstants.nowPlayingUrl}${ApiConstants.API_KEY}';
  static const _popularUrl =
      '${ApiConstants.popularUrl}${ApiConstants.API_KEY}';
  static const _topRatedUrl =
      '${ApiConstants.topRatedUrl}${ApiConstants.API_KEY}';

  Future<List<MovieEntity>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => MovieEntity.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<MovieEntity>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse(_nowPlayingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => MovieEntity.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<MovieEntity>> getPopularMovies() async {
    final response = await http.get(Uri.parse(_popularUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData.map((movie) => MovieEntity.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<MovieEntity>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => MovieEntity.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }
}

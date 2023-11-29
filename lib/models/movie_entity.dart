import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieEntity {
  final String posterPath;
  final int id;
  final String backdropPath;
  final String title;
  final num voteAverage;
  final String releaseDate;
  final String overview;
  final double popularity;

  const MovieEntity({
    required this.posterPath,
    required this.id,
    required this.backdropPath,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.popularity,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      posterPath: json['poster_path'] ?? '',
      id: json['id'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      title: json['title'],
      voteAverage: json['vote_average'] ?? '',
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      popularity: json['popularity'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'overview': overview,
      'popularity': popularity,
      'vote_average': voteAverage,
    };
  }
}

class FavoritesData extends ChangeNotifier {
  List<MovieEntity> _myFavorites = [];

  List<MovieEntity> get myFavorites => _myFavorites;

  void addToFavorite(MovieEntity movie) async {
    _myFavorites.add(movie);
    try {
      await FavoritesStorage.saveFavorite(_myFavorites);
    } catch (e) {
      print('Error Occured: ${e.toString()}');
    }
    loadFavorites();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    _myFavorites = (await FavoritesStorage.loadFavorites())!;
    notifyListeners(); // Notify listeners when data is loaded
  }

  void removeFavorite(int id) async {
    _myFavorites.removeWhere((favorite) => favorite.id == id);
    await FavoritesStorage.removeFavorite(id);
    await FavoritesStorage.saveFavorite(_myFavorites);

    loadFavorites();
    notifyListeners();
  }
}

class FavoritesStorage {
  static Future<void> saveFavorite(List<MovieEntity> movies) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = movies.map((project) => project.toMap()).toList();
    await prefs.setStringList(
        'favorites', jsonList.map((json) => jsonEncode(json)).toList());
  }

  static Future<void> removeFavorite(int movieId) async {
    final List<MovieEntity>? favorites = await loadFavorites();
    if (favorites != null) {
      favorites.removeWhere((favorite) => favorite.id == movieId);
      await saveFavorite(favorites);
    }
  }

  static Future<List<MovieEntity>?> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('favorites') ?? [];

    if (jsonList != null) {
      return jsonList.map((json) {
        final favoritesMap = jsonDecode(json);
        return MovieEntity.fromJson(favoritesMap);
      }).toList();
    } else {
      return null;
    }
  }
}

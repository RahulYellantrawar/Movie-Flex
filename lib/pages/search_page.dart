import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/movie_entity.dart';
import 'package:movies/widgets/movie_cat_list.dart';

import '../constants/api_constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  String searchText = '';
  List<MovieEntity> movies = [];

  Future<void> searchLocationText(String searchText) async {
    try {
      var searchResult = await http.get(Uri.parse(
          '${ApiConstants.searchUrl}$searchText${ApiConstants.searchKey}'));
      final decodedData = json.decode(searchResult.body)['results'] as List;

      setState(() {
        movies =
            decodedData.map((movie) => MovieEntity.fromJson(movie)).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          textAlignVertical: TextAlignVertical.center,
          autofocus: true,
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
            searchLocationText(searchText);
          },
          decoration: InputDecoration(
              hintText: 'Search movies',
              suffixIcon: GestureDetector(
                onTap: () => _searchController.clear(),
                child: const Icon(
                  Icons.clear,
                  // color: myConstants.primaryColor,
                ),
              ),
              border: InputBorder.none),
          onSubmitted: (value) {
            searchLocationText(value);
          },
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieContainer(
            movieEntity: movies[index],
            showFavorite: false,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 15);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie_entity.dart';
import '../widgets/movie_cat_list.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final movieData = Provider.of<FavoritesData>(context);
    await movieData.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<FavoritesData>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorite Movies'),
      ),
      body: movieData.myFavorites.isEmpty
          ? const Center(
              child: Text('Add movies to Favorite'),
            )
          : SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: movieData.myFavorites.length,
                itemBuilder: (context, index) {
                  return MovieContainer(
                    movieEntity: movieData.myFavorites[index],
                    showFavorite: true,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 15);
                },
              ),
            ),
    );
  }
}

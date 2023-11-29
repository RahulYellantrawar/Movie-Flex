import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api_reference/api_reference.dart';
import '../models/movie_entity.dart';
import '../widgets/movie_cat_list.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({super.key});

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  late Future<List<MovieEntity>> popularMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = Api().getPopularMovies();
  }

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Popular Movies'),
      ),
      body: SizedBox(
        child: FutureBuilder(
          future: popularMovies,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MovieContainer(
                    movieEntity: snapshot.data![index],
                    showFavorite: false,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 15);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

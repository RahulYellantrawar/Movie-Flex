import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/constants/api_constants.dart';
import 'package:movies/models/movie_entity.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final MovieEntity movie;
  const DetailsPage({super.key, required this.movie});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;

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

    if (movieData.myFavorites != null) {
      movieData.myFavorites.asMap().forEach((key, value) {
        if (value.id == widget.movie.id) {
          setState(() {
            isFavorite = true;
          });
        } else {
          setState(() {
            isFavorite = false;
          });
        }
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: CachedNetworkImage(
              imageUrl:
                  '${ApiConstants.backdropUrl}${widget.movie.backdropPath}',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC000000),
                  Color(0x00000000),
                  Color(0x00000000),
                  Color(0xCB000000),
                  Color(0xCC000000),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: IconButton(
              onPressed: () {
                if (isFavorite) {
                  movieData.removeFavorite(widget.movie.id);
                  setState(() {
                    isFavorite = false;
                  });
                } else {
                  movieData.addToFavorite(widget.movie);
                  setState(() {
                    isFavorite = true;
                  });
                }
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                          text: 'Released on: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                        TextSpan(
                          text: widget.movie.releaseDate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        )
                      ])),
                      RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(children: [
                            const TextSpan(
                              text: 'Popularity ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white54,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.movie.popularity.toInt()}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            )
                          ])),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Overview: ',
                      style:
                          GoogleFonts.lato(fontSize: 16, color: Colors.white),
                    ),
                    TextSpan(
                      text: widget.movie.overview,
                      style:
                          GoogleFonts.lato(fontSize: 15, color: Colors.white70),
                    )
                  ])),
                ],
              ),
            ),
          ),
        ],
      ),
      // CustomScrollView(
      //   slivers: [
      //     SliverAppBar.large(
      //       leading: Container(
      //         height: 70,
      //         width: 70,
      //         margin: EdgeInsets.only(top: 16, left: 16),
      //         decoration: BoxDecoration(
      //           color: Colors.black,
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //         child: IconButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           icon: Icon(Icons.arrow_back_rounded),
      //         ),
      //       ),
      //       backgroundColor: Colors.black,
      //       expandedHeight: 700,
      //       pinned: true,
      //       floating: true,
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Text(
      //           movie.title,
      //           style: GoogleFonts.belleza(
      //               fontSize: 17, fontWeight: FontWeight.w600),
      //         ),
      //         background: Image.network(
      //           '${ApiConstants.backdropUrl}${movie.backdropPath}',
      //           // filterQuality: FilterQuality.high,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //     SliverToBoxAdapter(
      //       child: Padding(
      //         padding: EdgeInsets.all(12),
      //         child: Column(
      //           children: [],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

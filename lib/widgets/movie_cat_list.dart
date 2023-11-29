import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/models/movie_entity.dart';
import 'package:movies/pages/details_page.dart';
import 'package:provider/provider.dart';

import '../constants/api_constants.dart';

class MovieContainer extends StatelessWidget {
  final MovieEntity movieEntity;
  final bool showFavorite;
  const MovieContainer({
    required this.movieEntity,
    required this.showFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<FavoritesData>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsPage(movie: movieEntity)));
      },
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl:
                          '${ApiConstants.posterUrl}${movieEntity.posterPath}',
                      errorWidget: (context, url, error) => Container(
                        height: double.infinity,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white10)),
                        child: const Center(
                          child: Text(
                            'Image not found',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      width: 120,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieEntity.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.playfairDisplay(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                text: 'Released on:\n',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white38,
                                ),
                              ),
                              TextSpan(
                                text: movieEntity.releaseDate,
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
                                    text: 'Popularity\n',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white38,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${movieEntity.popularity.toInt()}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  )
                                ])),
                          ],
                        ),
                        const SizedBox(height: 15),
                        RichText(
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Overview: ',
                                style: GoogleFonts.lato(
                                    fontSize: 13, color: Colors.white),
                              ),
                              TextSpan(
                                text: movieEntity.overview,
                                style: GoogleFonts.lato(
                                    fontSize: 12.5, color: Colors.white70),
                              )
                            ])),
                      ],
                    ),
                  ),
                ],
              )),
          Positioned(
            left: 10,
            child: showFavorite
                ? IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      movieData.removeFavorite(movieEntity.id);
                    },
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

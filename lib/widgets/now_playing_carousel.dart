import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/constants/api_constants.dart';
import 'package:movies/pages/details_page.dart';

class NowPlayingCarousel extends StatefulWidget {
  final AsyncSnapshot snapshot;
  const NowPlayingCarousel({super.key, required this.snapshot});

  @override
  State<NowPlayingCarousel> createState() => _NowPlayingCarouselState();
}

class _NowPlayingCarouselState extends State<NowPlayingCarousel> {
  final CarouselController controller = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 500,
          width: double.infinity,
          child: CarouselSlider.builder(
            carouselController: controller,
            itemCount: widget.snapshot.data.length,
            options: CarouselOptions(
              height: 500,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              autoPlay: false,
              viewportFraction: 1,
              enlargeCenterPage: true,
              pageSnapping: true,
            ),
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl:
                      '${ApiConstants.posterUrl}${widget.snapshot.data[_current].backdropPath}',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        Positioned(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          top: 150,
          left: 0,
          right: 0,
          child: SizedBox(
            width: double.infinity,
            child: CarouselSlider.builder(
              carouselController: controller,
              itemCount: widget.snapshot.data.length,
              options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  viewportFraction: 0.55,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              itemBuilder: (context, itemIndex, pageViewIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsPage(
                            movie: widget.snapshot.data[itemIndex])));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl:
                          '${ApiConstants.posterUrl}${widget.snapshot.data[itemIndex].posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

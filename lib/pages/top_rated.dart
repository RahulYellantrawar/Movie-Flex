import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/api_reference/api_reference.dart';
import 'package:movies/models/movie_entity.dart';
import 'package:movies/widgets/drawer.dart';

import '../widgets/movie_cat_list.dart';
import '../widgets/now_playing_carousel.dart';
import 'search_page.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  late Future<List<MovieEntity>> topRated;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showAppBar = false;

  _scrollListener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    topRated = Api().getTopRatedMovies();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && !_showAppBar) {
        setState(() {
          _showAppBar = true;
        });
      } else if (_scrollController.offset <= 100 && _showAppBar) {
        setState(() {
          _showAppBar = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavDrawer(),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 100,
          color: Colors.transparent,
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: _showAppBar ? null : Colors.transparent,
            centerTitle: true,
            title: Image.asset(
              'assets/images/logo.png',
              width: 150,
              filterQuality: FilterQuality.high,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                icon: const Icon(CupertinoIcons.search),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: FutureBuilder(
                future: topRated,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return NowPlayingCarousel(
                      snapshot: snapshot,
                    );
                  } else {
                    return const SizedBox(
                      height: 800,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Top Rated',
                style: GoogleFonts.openSans(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: FutureBuilder(
                future: topRated,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
    );
  }
}

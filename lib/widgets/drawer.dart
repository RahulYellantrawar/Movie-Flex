import 'package:flutter/material.dart';
import 'package:movies/pages/favorites.dart';
import 'package:movies/pages/popular_movies.dart';
import 'package:movies/pages/trending_movies.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: SizedBox(
        width: size.width * 0.7,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Image.asset(
                'assets/images/logo.png',
                height: 40,
              ),
            ),
            const SizedBox(height: 50),
            const Divider(color: Colors.white30),
            const SizedBox(height: 20),
            ListTile(
              title: Text('Favorite Movies'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Favorites()));
              },
            ),
            const Divider(color: Colors.white12, endIndent: 50, indent: 10),
            ListTile(
              title: Text('Popular Movies'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PopularMovies()));
              },
            ),
            const Divider(color: Colors.white12, endIndent: 50, indent: 10),
            ListTile(
              title: Text('Trending Movies'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TrendingMovies()));
              },
            ),
          ],
        ),
      ),
    );
    // Container(
    //   width: 50,
    //   height: double.infinity,
    //   color: Color(0xff232D3F),
    //   child: SafeArea(
    //     child: Column(
    //       children: [
    //         Image.asset(
    //           'assets/images/logo.png',
    //           width: 300,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(
    //             top: 10,
    //             bottom: 20,
    //           ),
    //           child: Text(
    //             'BROWSE',
    //             style: TextStyle(
    //               fontFamily: 'Nunito',
    //               // fontSize: size.width * 0.05,
    //               // color: constants.cloud1,
    //               fontWeight: FontWeight.w100,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

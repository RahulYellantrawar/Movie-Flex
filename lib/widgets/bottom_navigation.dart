import 'package:flutter/material.dart';
import 'package:movies/pages/now_playing.dart';
import 'package:movies/pages/top_rated.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int pageIndex = 0;

  final List _tabList = [
    const NowPlaying(),
    const TopRated(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabList[pageIndex],
      bottomNavigationBar: Container(
        // color: Colors.white10,
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.white10,
          currentIndex: pageIndex,
          onTap: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Now Playing',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Top Rated',
            ),
          ],
        ),
      ),
    );
  }
}

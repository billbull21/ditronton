import 'package:flutter/material.dart';

import 'modules/movies/presentation/pages/about_page.dart';
import 'modules/movies/presentation/pages/home_movie_page.dart';
import 'modules/movies/presentation/pages/search_movie_page.dart';
import 'modules/movies/presentation/pages/watchlist_movies_page.dart';
import 'modules/tvs/presentation/pages/home_tv_page.dart';
import 'modules/tvs/presentation/pages/search_tv_page.dart';
import 'modules/tvs/presentation/pages/watchlist_tv_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String title = 'MOVIES';
  Widget activePage = HomeMoviePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('movie_dicoding_app'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  activePage = HomeMoviePage();
                  title = 'MOVIES';
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  activePage = HomeTvPage();
                  title = 'TV SERIES';
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvsPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('DITRONTON - $title'),
        actions: [
          IconButton(
            onPressed: () {
              if (title == 'MOVIES') {
                Navigator.pushNamed(context, SearchMoviePage.ROUTE_NAME);
              } else if (title == 'TV SERIES') {
                Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: activePage,
    );
  }
}
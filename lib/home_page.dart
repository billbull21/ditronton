import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/presentation/bloc/home_bloc.dart';
import 'modules/movies/presentation/pages/about_page.dart';
import 'modules/movies/presentation/pages/home_movie_page.dart';
import 'modules/movies/presentation/pages/search_movie_page.dart';
import 'modules/movies/presentation/pages/watchlist_movies_page.dart';
import 'modules/tvs/presentation/pages/home_tv_page.dart';
import 'modules/tvs/presentation/pages/search_tv_page.dart';
import 'modules/tvs/presentation/pages/watchlist_tv_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                    // add event to record it in firebase analytics
                    FirebaseAnalytics.instance.logEvent(name: 'change_page', parameters: {'page': 'movies'});
                    context.read<HomeBloc>().add(ChangePageEvent(
                      title: 'MOVIES',
                      page: HomeMoviePage(),
                    ));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.tv),
                  title: Text('TV Series'),
                  onTap: () {
                    Navigator.pop(context);
                    // add event to record it in firebase analytics
                    FirebaseAnalytics.instance.logEvent(name: 'change_page', parameters: {'page': 'tv_series'});
                    context.read<HomeBloc>().add(ChangePageEvent(
                      title: 'TV SERIES',
                      page: HomeTvPage(),
                    ));
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
            title: Text('DITRONTON - ${state.title}'),
            actions: [
              IconButton(
                onPressed: () {
                  if (state.title == 'MOVIES') {
                    Navigator.pushNamed(context, SearchMoviePage.ROUTE_NAME);
                  } else if (state.title == 'TV SERIES') {
                    Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
                  }
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: state.activePage,
        );
      },
    );
  }
}
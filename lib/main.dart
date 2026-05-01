import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/common/constants.dart';
import 'package:movie_dicoding_app/common/utils.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/movie_detail_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/popular_movies_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/search_movie_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/watchlist_movies_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/search/movie_search_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/tv_detail_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/popular_tvs_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/search_tv_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/top_rated_tvs_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/watchlist_tv_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/search/tv_search_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_dicoding_app/injection.dart' as di;

import 'firebase_options.dart';
import 'home_page.dart';
import 'modules/movies/presentation/bloc/list/movie_list_bloc.dart';
import 'modules/movies/presentation/pages/about_page.dart';
import 'modules/movies/presentation/pages/now_playing_movies_page.dart';
import 'modules/tvs/presentation/pages/now_playing_tvs_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  di.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError =
      FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Catch async errors outside Flutter framework (e.g. Future.error, Zone errors)
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<MovieListBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<MovieSearchBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (_) => di.locator<TvListBloc>()),
        BlocProvider(create: (_) => di.locator<TvDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvSearchBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvBloc>()),
      ],
      child: MaterialApp(
        title: 'DITRONTON',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            // Movies
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case NowPlayingMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingMoviesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case SearchMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchMoviePage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            // TVs
            case NowPlayingTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingTvsPage());
            case PopularTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvsPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case WatchlistTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvsPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(body: Center(child: Text('Page not found :(')));
                },
              );
          }
        },
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:movie_dicoding_app/common/db/db_instance.dart';
import 'package:movie_dicoding_app/modules/movies/data/datasources/db/movie_database_helper.dart';
import 'package:movie_dicoding_app/modules/movies/data/datasources/movie_local_data_source.dart';
import 'package:movie_dicoding_app/modules/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movie_dicoding_app/modules/movies/data/repositories/movie_repository_impl.dart';
import 'package:movie_dicoding_app/modules/movies/domain/repositories/movie_repository.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_movie_detail.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_popular_movies.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_watchlist_status.dart' as movie_usecase;
import 'package:movie_dicoding_app/modules/movies/domain/usecases/remove_watchlist.dart' as movie_remove;
import 'package:movie_dicoding_app/modules/movies/domain/usecases/save_watchlist.dart' as movie_save;
import 'package:movie_dicoding_app/modules/movies/domain/usecases/search_movies.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/provider/movie_list_notifier.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/provider/movie_search_notifier.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/provider/popular_movies_notifier.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/provider/watchlist_movie_notifier.dart';
import 'package:movie_dicoding_app/modules/tvs/data/datasources/db/tv_database_helper.dart';
import 'package:movie_dicoding_app/modules/tvs/data/datasources/tv_local_data_source.dart';
import 'package:movie_dicoding_app/modules/tvs/data/datasources/tv_remote_data_source.dart';
import 'package:movie_dicoding_app/modules/tvs/data/repositories/tv_repository_impl.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/repositories/tv_repository.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_tv_detail.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_tv_recommendations.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_now_playing_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_popular_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_top_rated_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_watchlist_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_watchlist_status.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/remove_watchlist.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/save_watchlist.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/search_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/tv_detail_notifier.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/tv_list_notifier.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/tv_search_notifier.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/popular_tvs_notifier.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/watchlist_tv_notifier.dart';
import 'package:get_it/get_it.dart';

import 'common/network/dio_client.dart';
import 'modules/movies/presentation/provider/now_playing_movies_notifier.dart';
import 'modules/tvs/presentation/provider/now_playing_tvs_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider - movies
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesNotifier(locator()),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // provider - tvs
  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvsNotifier(
      getTopRatedTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTvs: locator(),
    ),
  );

  // use case - movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => movie_usecase.GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => movie_save.SaveWatchlist(locator()));
  locator.registerLazySingleton(() => movie_remove.RemoveWatchlist(locator()));

  // use case - tvs
  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DBInstance>(() => DBInstance());
  locator.registerLazySingleton(() => MovieDatabaseHelper(dbInstance: locator()));
  locator.registerLazySingleton(() => TvDatabaseHelper(dbInstance: locator()));

  // external
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => DioClient(dio: locator<Dio>()));
}

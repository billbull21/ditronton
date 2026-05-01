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
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_watchlist_status.dart'
    as movie_usecase;
import 'package:movie_dicoding_app/modules/movies/domain/usecases/remove_watchlist.dart'
    as movie_remove;
import 'package:movie_dicoding_app/modules/movies/domain/usecases/save_watchlist.dart'
    as movie_save;
import 'package:movie_dicoding_app/modules/movies/domain/usecases/search_movies.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/search/movie_search_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
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
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/search/tv_search_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:get_it/get_it.dart';

import 'common/network/dio_client.dart';
import 'common/presentation/bloc/home_bloc.dart';
import 'modules/movies/presentation/bloc/list/movie_list_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc - home
  locator.registerFactory(() => HomeBloc());
  // bloc - movies
  locator.registerFactory(
    () => MovieListBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => MovieSearchBloc(searchMovies: locator()));
  locator.registerFactory(() => WatchlistMovieBloc(getWatchlistMovies: locator()));

  // bloc - tvs
  locator.registerFactory(
    () => TvListBloc(
      getNowPlayingTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => TvSearchBloc(searchTvs: locator()));
  locator.registerFactory(() => WatchlistTvBloc(getWatchlistTvs: locator()));

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
    () => MovieRepositoryImpl(remoteDataSource: locator(), localDataSource: locator()),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(remoteDataSource: locator(), localDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DBInstance>(() => DBInstance());
  locator.registerLazySingleton(() => MovieDatabaseHelper(dbInstance: locator()));
  locator.registerLazySingleton(() => TvDatabaseHelper(dbInstance: locator()));

  // external
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => DioClient(dio: locator<Dio>()));
}

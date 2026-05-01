import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_popular_movies.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/list/movie_list_bloc.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
  });

  MovieListBloc buildBloc() => MovieListBloc(
        getNowPlayingMovies: mockGetNowPlayingMovies,
        getPopularMovies: mockGetPopularMovies,
        getTopRatedMovies: mockGetTopRatedMovies,
      );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('FetchNowPlayingMovies', () {
    blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MovieListState(nowPlayingState: RequestState.Loading),
        MovieListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
      verify: (_) => verify(mockGetNowPlayingMovies.execute()).called(1),
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MovieListState(nowPlayingState: RequestState.Loading),
        MovieListState(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('FetchPopularMovies', () {
    blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MovieListState(popularMoviesState: RequestState.Loading),
        MovieListState(
          popularMoviesState: RequestState.Loaded,
          popularMovies: tMovieList,
        ),
      ],
      verify: (_) => verify(mockGetPopularMovies.execute()).called(1),
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MovieListState(popularMoviesState: RequestState.Loading),
        MovieListState(
          popularMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('FetchTopRatedMovies', () {
    blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MovieListState(topRatedMoviesState: RequestState.Loading),
        MovieListState(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: tMovieList,
        ),
      ],
      verify: (_) => verify(mockGetTopRatedMovies.execute()).called(1),
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MovieListState(topRatedMoviesState: RequestState.Loading),
        MovieListState(
          topRatedMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}

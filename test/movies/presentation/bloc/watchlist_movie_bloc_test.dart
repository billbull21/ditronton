import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/watchlist/watchlist_movie_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
  });

  WatchlistMovieBloc buildBloc() =>
      WatchlistMovieBloc(getWatchlistMovies: mockGetWatchlistMovies);

  group('FetchWatchlistMovies', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchWatchlistMovies()),
      expect: () => [
        const WatchlistMovieState(watchlistState: RequestState.Loading),
        WatchlistMovieState(
          watchlistState: RequestState.Loaded,
          watchlistMovies: [testWatchlistMovie],
          message: '',
        ),
      ],
      verify: (_) => verify(mockGetWatchlistMovies.execute()).called(1),
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchWatchlistMovies()),
      expect: () => [
        const WatchlistMovieState(watchlistState: RequestState.Loading),
        const WatchlistMovieState(
          watchlistState: RequestState.Error,
          message: "Can't get data",
        ),
      ],
    );
  });
}

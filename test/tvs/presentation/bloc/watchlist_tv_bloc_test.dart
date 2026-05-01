import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_watchlist_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/watchlist/watchlist_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
  });

  WatchlistTvBloc buildBloc() =>
      WatchlistTvBloc(getWatchlistTvs: mockGetWatchlistTvs);

  group('FetchWatchlistTvs', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right([testWatchlistTv]));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchWatchlistTvs()),
      expect: () => [
        const WatchlistTvState(watchlistState: RequestState.Loading),
        WatchlistTvState(
          watchlistState: RequestState.Loaded,
          watchlistTvs: [testWatchlistTv],
          message: '',
        ),
      ],
      verify: (_) => verify(mockGetWatchlistTvs.execute()).called(1),
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchWatchlistTvs()),
      expect: () => [
        const WatchlistTvState(watchlistState: RequestState.Loading),
        const WatchlistTvState(
          watchlistState: RequestState.Error,
          message: 'Database Failure',
        ),
      ],
    );
  });
}

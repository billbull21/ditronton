import 'package:dartz/dartz.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_watchlist_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/watchlist_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late WatchlistTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    notifier = WatchlistTvNotifier(getWatchlistTvs: mockGetWatchlistTvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
    backdropPath: '/path.jpg',
    firstAirDate: DateTime(2021, 1, 1),
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetWatchlistTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchWatchlistTvs();
    // assert
    expect(notifier.watchlistState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchWatchlistTvs();
    // assert
    expect(notifier.watchlistState, RequestState.Loaded);
    expect(notifier.watchlistTvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTvs.execute())
        .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
    // act
    await notifier.fetchWatchlistTvs();
    // assert
    expect(notifier.watchlistState, RequestState.Error);
    expect(notifier.message, 'Database Failure');
    expect(listenerCallCount, 2);
  });
}

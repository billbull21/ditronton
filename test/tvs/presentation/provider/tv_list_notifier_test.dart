import 'package:dartz/dartz.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_now_playing_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_popular_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_top_rated_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs, GetPopularTvs, GetTopRatedTvs])
void main() {
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TvListNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    notifier = TvListNotifier(
      getNowPlayingTvs: mockGetNowPlayingTvs,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTvs: mockGetTopRatedTvs,
    )..addListener(() {
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

  group('now playing tvs', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      notifier.fetchNowPlayingTvs();
      expect(notifier.nowPlayingState, RequestState.Loading);
    });

    test('should change data when data is gotten successfully', () async {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      await notifier.fetchNowPlayingTvs();
      expect(notifier.nowPlayingState, RequestState.Loaded);
      expect(notifier.nowPlayingTvs, tTvList);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      await notifier.fetchNowPlayingTvs();
      expect(notifier.nowPlayingState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
    });
  });

  group('popular tvs', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      notifier.fetchPopularTvs();
      expect(notifier.popularTvsState, RequestState.Loading);
    });

    test('should change data when data is gotten successfully', () async {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      await notifier.fetchPopularTvs();
      expect(notifier.popularTvsState, RequestState.Loaded);
      expect(notifier.popularTvs, tTvList);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      await notifier.fetchPopularTvs();
      expect(notifier.popularTvsState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
    });
  });

  group('top rated tvs', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      notifier.fetchTopRatedTvs();
      expect(notifier.topRatedTvsState, RequestState.Loading);
    });

    test('should change data when data is gotten successfully', () async {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      await notifier.fetchTopRatedTvs();
      expect(notifier.topRatedTvsState, RequestState.Loaded);
      expect(notifier.topRatedTvs, tTvList);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      await notifier.fetchTopRatedTvs();
      expect(notifier.topRatedTvsState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
    });
  });
}

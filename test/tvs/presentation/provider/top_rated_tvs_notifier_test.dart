import 'package:dartz/dartz.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_top_rated_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TopRatedTvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    notifier = TopRatedTvsNotifier(getTopRatedTvs: mockGetTopRatedTvs)
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
    when(mockGetTopRatedTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}

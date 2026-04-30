import 'package:dartz/dartz.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/search_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late MockSearchTvs mockSearchTvs;
  late TvSearchNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvs = MockSearchTvs();
    notifier = TvSearchNotifier(searchTvs: mockSearchTvs)
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
  final tQuery = 'spiderman';

  test('should change state to loading when usecase is called', () async {
    when(mockSearchTvs.execute(tQuery))
        .thenAnswer((_) async => Right(tTvList));
    notifier.fetchTvSearch(tQuery);
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change search result data when data is gotten successfully',
      () async {
    when(mockSearchTvs.execute(tQuery))
        .thenAnswer((_) async => Right(tTvList));
    await notifier.fetchTvSearch(tQuery);
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.searchResult, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockSearchTvs.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    await notifier.fetchTvSearch(tQuery);
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}

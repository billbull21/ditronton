import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/search_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/search/tv_search_bloc.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
  });

  TvSearchBloc buildBloc() => TvSearchBloc(searchTvs: mockSearchTvs);

  final tTv = Tv(
    backdropPath: '/path.jpg',
    firstAirDate: DateTime(2021, 1, 1),
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'Name',
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTv];
  const tQuery = 'spiderman';

  group('FetchTvSearch', () {
    blocTest<TvSearchBloc, TvSearchState>(
      'emits [Loading, Loaded] when search is successful',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchTvSearch(tQuery)),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const TvSearchState(state: RequestState.Loading),
        TvSearchState(
          state: RequestState.Loaded,
          searchResult: tTvList,
          message: '',
        ),
      ],
      verify: (_) => verify(mockSearchTvs.execute(tQuery)).called(1),
    );

    blocTest<TvSearchBloc, TvSearchState>(
      'emits [Loading, Error] when search fails',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchTvSearch(tQuery)),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const TvSearchState(state: RequestState.Loading),
        const TvSearchState(
          state: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}

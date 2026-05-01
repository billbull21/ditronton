import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_now_playing_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_popular_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_top_rated_tvs.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs, GetPopularTvs, GetTopRatedTvs])
void main() {
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
  });

  TvListBloc buildBloc() => TvListBloc(
        getNowPlayingTvs: mockGetNowPlayingTvs,
        getPopularTvs: mockGetPopularTvs,
        getTopRatedTvs: mockGetTopRatedTvs,
      );

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

  group('FetchNowPlayingTvs', () {
    blocTest<TvListBloc, TvListState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvs()),
      expect: () => [
        const TvListState(nowPlayingState: RequestState.Loading),
        TvListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvs: tTvList,
        ),
      ],
      verify: (_) => verify(mockGetNowPlayingTvs.execute()).called(1),
    );

    blocTest<TvListBloc, TvListState>(
      'emits [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvs()),
      expect: () => [
        const TvListState(nowPlayingState: RequestState.Loading),
        const TvListState(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('FetchPopularTvs', () {
    blocTest<TvListBloc, TvListState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      expect: () => [
        const TvListState(popularTvsState: RequestState.Loading),
        TvListState(
          popularTvsState: RequestState.Loaded,
          popularTvs: tTvList,
        ),
      ],
      verify: (_) => verify(mockGetPopularTvs.execute()).called(1),
    );

    blocTest<TvListBloc, TvListState>(
      'emits [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      expect: () => [
        const TvListState(popularTvsState: RequestState.Loading),
        const TvListState(
          popularTvsState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('FetchTopRatedTvs', () {
    blocTest<TvListBloc, TvListState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      expect: () => [
        const TvListState(topRatedTvsState: RequestState.Loading),
        TvListState(
          topRatedTvsState: RequestState.Loaded,
          topRatedTvs: tTvList,
        ),
      ],
      verify: (_) => verify(mockGetTopRatedTvs.execute()).called(1),
    );

    blocTest<TvListBloc, TvListState>(
      'emits [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      expect: () => [
        const TvListState(topRatedTvsState: RequestState.Loading),
        const TvListState(
          topRatedTvsState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}

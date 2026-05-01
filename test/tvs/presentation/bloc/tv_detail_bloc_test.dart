import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_tv_detail.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_tv_recommendations.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/get_watchlist_status.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/remove_watchlist.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/save_watchlist.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/detail/tv_detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
  });

  TvDetailBloc buildBloc() => TvDetailBloc(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecommendations,
        getWatchListStatus: mockGetWatchListStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
      );

  const tId = 1;

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
  final tTvs = <Tv>[tTv];

  group('FetchTvDetail', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'emits correct states when detail and recommendations succeed',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(tvState: RequestState.Loading),
        TvDetailState(
          tv: testTvDetail,
          tvState: RequestState.Loading,
          recommendationState: RequestState.Loading,
        ),
        TvDetailState(
          tv: testTvDetail,
          tvState: RequestState.Loading,
          recommendationState: RequestState.Loaded,
          tvRecommendations: tTvs,
        ),
        TvDetailState(
          tv: testTvDetail,
          tvState: RequestState.Loaded,
          recommendationState: RequestState.Loaded,
          tvRecommendations: tTvs,
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId)).called(1);
        verify(mockGetTvRecommendations.execute(tId)).called(1);
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'emits [Loading, Error] when detail fails',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(tvState: RequestState.Loading),
        const TvDetailState(
          tvState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'emits recommendation Error when recommendations fail',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(tvState: RequestState.Loading),
        TvDetailState(
          tv: testTvDetail,
          tvState: RequestState.Loading,
          recommendationState: RequestState.Loading,
        ),
        TvDetailState(
          tv: testTvDetail,
          tvState: RequestState.Loading,
          recommendationState: RequestState.Error,
          message: 'Failed',
        ),
        TvDetailState(
          tv: testTvDetail,
          tvState: RequestState.Loaded,
          recommendationState: RequestState.Error,
          message: 'Failed',
        ),
      ],
    );
  });

  group('LoadTvWatchlistStatus', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'emits state with isAddedToWatchlist true',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return buildBloc();
      },
      act: (bloc) => bloc.add(const LoadTvWatchlistStatus(tId)),
      expect: () => [
        const TvDetailState(isAddedToWatchlist: true),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'emits state with isAddedToWatchlist false',
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return buildBloc();
      },
      act: (bloc) => bloc.add(const LoadTvWatchlistStatus(tId)),
      expect: () => [
        const TvDetailState(isAddedToWatchlist: false),
      ],
    );
  });

  group('AddTvToWatchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'emits success message and watchlist status when add succeeds',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(testTvDetail.id ?? 0))
            .thenAnswer((_) async => true);
        return buildBloc();
      },
      act: (bloc) => bloc.add(AddTvToWatchlist(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvDetail)).called(1);
        verify(mockGetWatchListStatus.execute(testTvDetail.id ?? 0)).called(1);
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'emits failure message when add fails',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testTvDetail.id ?? 0))
            .thenAnswer((_) async => false);
        return buildBloc();
      },
      act: (bloc) => bloc.add(AddTvToWatchlist(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Failed',
          isAddedToWatchlist: false,
        ),
      ],
    );
  });

  group('RemoveTvFromWatchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'emits success message and updated watchlist status when remove succeeds',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testTvDetail.id ?? 0))
            .thenAnswer((_) async => false);
        return buildBloc();
      },
      act: (bloc) => bloc.add(RemoveTvFromWatchlist(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTvDetail)).called(1);
        verify(mockGetWatchListStatus.execute(testTvDetail.id ?? 0)).called(1);
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'emits failure message when remove fails',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Remove Failed')));
        when(mockGetWatchListStatus.execute(testTvDetail.id ?? 0))
            .thenAnswer((_) async => true);
        return buildBloc();
      },
      act: (bloc) => bloc.add(RemoveTvFromWatchlist(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Remove Failed',
          isAddedToWatchlist: true,
        ),
      ],
    );
  });
}

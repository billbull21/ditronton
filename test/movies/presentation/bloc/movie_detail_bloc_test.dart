import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_movie_detail.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/get_watchlist_status.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/remove_watchlist.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/save_watchlist.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/detail/movie_detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
  });

  MovieDetailBloc buildBloc() => MovieDetailBloc(
        getMovieDetail: mockGetMovieDetail,
        getMovieRecommendations: mockGetMovieRecommendations,
        getWatchListStatus: mockGetWatchListStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
      );

  const tId = 1;

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
  final tMovies = <Movie>[tMovie];

  group('FetchMovieDetail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits correct states when detail and recommendations succeed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        const MovieDetailState(movieState: RequestState.Loading),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          recommendationState: RequestState.Loading,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          recommendationState: RequestState.Loaded,
          movieRecommendations: tMovies,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loaded,
          recommendationState: RequestState.Loaded,
          movieRecommendations: tMovies,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId)).called(1);
        verify(mockGetMovieRecommendations.execute(tId)).called(1);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Error] when detail fails',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        const MovieDetailState(movieState: RequestState.Loading),
        const MovieDetailState(
          movieState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits recommendation Error when recommendations fail',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        const MovieDetailState(movieState: RequestState.Loading),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          recommendationState: RequestState.Loading,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          recommendationState: RequestState.Error,
          message: 'Failed',
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loaded,
          recommendationState: RequestState.Error,
          message: 'Failed',
        ),
      ],
    );
  });

  group('LoadMovieWatchlistStatus', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits state with isAddedToWatchlist true',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return buildBloc();
      },
      act: (bloc) => bloc.add(const LoadMovieWatchlistStatus(tId)),
      expect: () => [
        const MovieDetailState(isAddedToWatchlist: true),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits state with isAddedToWatchlist false',
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return buildBloc();
      },
      act: (bloc) => bloc.add(const LoadMovieWatchlistStatus(tId)),
      expect: () => [
        const MovieDetailState(isAddedToWatchlist: false),
      ],
    );
  });

  group('AddMovieToWatchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits success message and watchlist status when add succeeds',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return buildBloc();
      },
      act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
      expect: () => [
        const MovieDetailState(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail)).called(1);
        verify(mockGetWatchListStatus.execute(testMovieDetail.id)).called(1);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits failure message when add fails',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return buildBloc();
      },
      act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
      expect: () => [
        const MovieDetailState(
          watchlistMessage: 'Failed',
          isAddedToWatchlist: false,
        ),
      ],
    );
  });

  group('RemoveMovieFromWatchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits success message and updated watchlist status when remove succeeds',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return buildBloc();
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
      expect: () => [
        const MovieDetailState(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail)).called(1);
        verify(mockGetWatchListStatus.execute(testMovieDetail.id)).called(1);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits failure message when remove fails',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Remove Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return buildBloc();
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
      expect: () => [
        const MovieDetailState(
          watchlistMessage: 'Remove Failed',
          isAddedToWatchlist: true,
        ),
      ],
    );
  });
}

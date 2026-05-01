import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie.dart';
import 'package:movie_dicoding_app/modules/movies/domain/usecases/search_movies.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/search/movie_search_bloc.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
  });

  MovieSearchBloc buildBloc() =>
      MovieSearchBloc(searchMovies: mockSearchMovies);

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  group('FetchMovieSearch', () {
    blocTest<MovieSearchBloc, MovieSearchState>(
      'emits [Loading, Loaded] when search is successful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchMovieSearch(tQuery)),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const MovieSearchState(state: RequestState.Loading),
        MovieSearchState(
          state: RequestState.Loaded,
          searchResult: tMovieList,
          message: '',
        ),
      ],
      verify: (_) => verify(mockSearchMovies.execute(tQuery)).called(1),
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'emits [Loading, Error] when search fails',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const FetchMovieSearch(tQuery)),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const MovieSearchState(state: RequestState.Loading),
        const MovieSearchState(
          state: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}

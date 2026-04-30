import 'package:movie_dicoding_app/modules/movies/data/models/movie_table.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/genre.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie_detail.dart';
import 'package:movie_dicoding_app/modules/tvs/data/models/tv_table.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
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

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// TV test data

final testTv = Tv(
  backdropPath: '/path.jpg',
  firstAirDate: DateTime(2021, 1, 1),
  genreIds: [1, 2, 3],
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: const [],
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

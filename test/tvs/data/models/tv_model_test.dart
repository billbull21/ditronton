import 'package:movie_dicoding_app/modules/tvs/data/models/tv_model.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
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

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity;
    expect(result, isA<Tv>());
  });

  test('fromEntity should create TvModel from Tv entity', () {
    final result = TvModel.fromEntity(tTv);
    expect(result, isA<TvModel>());
    expect(result.id, tTv.id);
    expect(result.name, tTv.name);
    expect(result.backdropPath, tTv.backdropPath);
    expect(result.firstAirDate, tTv.firstAirDate);
    expect(result.genreIds, tTv.genreIds);
    expect(result.originCountry, tTv.originCountry);
    expect(result.originalLanguage, tTv.originalLanguage);
    expect(result.originalName, tTv.originalName);
    expect(result.overview, tTv.overview);
    expect(result.popularity, tTv.popularity);
    expect(result.posterPath, tTv.posterPath);
    expect(result.voteAverage, tTv.voteAverage);
    expect(result.voteCount, tTv.voteCount);
  });

  test('fromJson should create TvModel from JSON map', () {
    final json = {
      'backdrop_path': '/path.jpg',
      'first_air_date': '2021-01-01',
      'genre_ids': [1, 2, 3],
      'id': 1,
      'name': 'Name',
      'origin_country': ['US'],
      'original_language': 'en',
      'original_name': 'Original Name',
      'overview': 'Overview',
      'popularity': 1.0,
      'poster_path': '/path.jpg',
      'vote_average': 1.0,
      'vote_count': 1,
    };

    final result = TvModel.fromJson(json);

    expect(result, isA<TvModel>());
    expect(result.id, 1);
    expect(result.name, 'Name');
    expect(result.originalLanguage, 'en');
    expect(result.genreIds, [1, 2, 3]);
    expect(result.originCountry, ['US']);
  });

  test('fromJson should handle null optional fields', () {
    final json = {
      'backdrop_path': null,
      'first_air_date': null,
      'genre_ids': null,
      'id': 2,
      'name': 'Name2',
      'origin_country': null,
      'original_language': 'en',
      'original_name': 'Name2',
      'overview': 'Overview',
      'popularity': 1.0,
      'poster_path': null,
      'vote_average': 1.0,
      'vote_count': 1,
    };

    final result = TvModel.fromJson(json);

    expect(result.id, 2);
    expect(result.backdropPath, isNull);
    expect(result.firstAirDate, isNull);
    expect(result.genreIds, isEmpty);
    expect(result.originCountry, isEmpty);
  });
}

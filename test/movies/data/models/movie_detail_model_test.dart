import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/movies/data/models/genre_model.dart';
import 'package:movie_dicoding_app/modules/movies/data/models/movie_detail_model.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie_detail.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: '/backdrop.jpg',
    budget: 1000000,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'https://example.com',
    id: 1,
    imdbId: 'tt1234567',
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Movie overview',
    popularity: 100.0,
    posterPath: '/poster.jpg',
    releaseDate: '2021-01-01',
    revenue: 5000000,
    runtime: 120,
    status: 'Released',
    tagline: 'A great movie',
    title: 'Title',
    video: false,
    voteAverage: 7.5,
    voteCount: 1000,
  );

  group('MovieDetailResponse', () {
    test('toJson should return correct JSON map', () {
      final result = tMovieDetailResponse.toJson();

      expect(result['id'], 1);
      expect(result['adult'], false);
      expect(result['backdrop_path'], '/backdrop.jpg');
      expect(result['budget'], 1000000);
      expect(result['homepage'], 'https://example.com');
      expect(result['imdb_id'], 'tt1234567');
      expect(result['original_language'], 'en');
      expect(result['original_title'], 'Original Title');
      expect(result['overview'], 'Movie overview');
      expect(result['popularity'], 100.0);
      expect(result['poster_path'], '/poster.jpg');
      expect(result['release_date'], '2021-01-01');
      expect(result['revenue'], 5000000);
      expect(result['runtime'], 120);
      expect(result['status'], 'Released');
      expect(result['tagline'], 'A great movie');
      expect(result['title'], 'Title');
      expect(result['video'], false);
      expect(result['vote_average'], 7.5);
      expect(result['vote_count'], 1000);
      expect(result['genres'], isA<List>());
    });

    test('toJson genres should contain correct data', () {
      final result = tMovieDetailResponse.toJson();
      final genres = result['genres'] as List;
      expect(genres.length, 1);
      expect(genres[0], {'id': 1, 'name': 'Action'});
    });

    test('toEntity should return MovieDetail', () {
      final result = tMovieDetailResponse.toEntity();
      expect(result, isA<MovieDetail>());
      expect(result.id, 1);
      expect(result.title, 'Title');
    });

    test('fromJson should create MovieDetailResponse from JSON', () {
      final json = {
        'adult': false,
        'backdrop_path': '/backdrop.jpg',
        'budget': 1000000,
        'genres': [{'id': 1, 'name': 'Action'}],
        'homepage': 'https://example.com',
        'id': 1,
        'imdb_id': 'tt1234567',
        'original_language': 'en',
        'original_title': 'Original Title',
        'overview': 'Movie overview',
        'popularity': 100.0,
        'poster_path': '/poster.jpg',
        'release_date': '2021-01-01',
        'revenue': 5000000,
        'runtime': 120,
        'status': 'Released',
        'tagline': 'A great movie',
        'title': 'Title',
        'video': false,
        'vote_average': 7.5,
        'vote_count': 1000,
      };

      final result = MovieDetailResponse.fromJson(json);
      expect(result.id, 1);
      expect(result.title, 'Title');
      expect(result.genres.length, 1);
    });

    test('props should allow equality', () {
      final a = MovieDetailResponse(
        adult: false,
        backdropPath: '/backdrop.jpg',
        budget: 1000000,
        genres: [GenreModel(id: 1, name: 'Action')],
        homepage: 'https://example.com',
        id: 1,
        imdbId: 'tt1234567',
        originalLanguage: 'en',
        originalTitle: 'Original Title',
        overview: 'Movie overview',
        popularity: 100.0,
        posterPath: '/poster.jpg',
        releaseDate: '2021-01-01',
        revenue: 5000000,
        runtime: 120,
        status: 'Released',
        tagline: 'A great movie',
        title: 'Title',
        video: false,
        voteAverage: 7.5,
        voteCount: 1000,
      );
      expect(a, equals(tMovieDetailResponse));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/movies/data/models/movie_table.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieTable', () {
    test('toJson should return correct map', () {
      final result = testMovieTable.toJson();
      expect(result, testMovieMap);
    });

    test('toJson keys should be correct', () {
      final result = testMovieTable.toJson();
      expect(result['id'], testMovieTable.id);
      expect(result['title'], testMovieTable.title);
      expect(result['posterPath'], testMovieTable.posterPath);
      expect(result['overview'], testMovieTable.overview);
    });

    test('toEntity should return Movie watchlist entity', () {
      final result = testMovieTable.toEntity();
      expect(result, isA<Movie>());
      expect(result.id, testMovieTable.id);
      expect(result.title, testMovieTable.title);
    });

    test('fromMap should create MovieTable from map', () {
      final result = MovieTable.fromMap(testMovieMap);
      expect(result.id, testMovieTable.id);
      expect(result.title, testMovieTable.title);
      expect(result.posterPath, testMovieTable.posterPath);
      expect(result.overview, testMovieTable.overview);
    });
  });
}

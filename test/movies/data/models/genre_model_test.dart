import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/movies/data/models/genre_model.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/genre.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'Action');

  group('GenreModel', () {
    test('toJson should return correct map', () {
      final result = tGenreModel.toJson();
      expect(result, {'id': 1, 'name': 'Action'});
    });

    test('toEntity should return Genre entity', () {
      final result = tGenreModel.toEntity();
      expect(result, isA<Genre>());
      expect(result.id, tGenreModel.id);
      expect(result.name, tGenreModel.name);
    });

    test('fromJson should create GenreModel from JSON', () {
      final result = GenreModel.fromJson({'id': 2, 'name': 'Drama'});
      expect(result.id, 2);
      expect(result.name, 'Drama');
    });

    test('equality should work via props', () {
      final a = GenreModel(id: 1, name: 'Action');
      final b = GenreModel(id: 1, name: 'Action');
      expect(a, equals(b));
    });
  });
}

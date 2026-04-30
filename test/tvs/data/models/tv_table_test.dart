import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/tvs/data/models/tv_table.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('TvTable', () {
    test('toJson should return correct map', () {
      final result = testTvTable.toJson();
      expect(result, testTvMap);
    });

    test('toJson keys should be correct', () {
      final result = testTvTable.toJson();
      expect(result['id'], testTvTable.id);
      expect(result['name'], testTvTable.name);
      expect(result['posterPath'], testTvTable.posterPath);
      expect(result['overview'], testTvTable.overview);
    });

    test('toEntity should return Tv watchlist entity', () {
      final result = testTvTable.toEntity();
      expect(result, isA<Tv>());
      expect(result.id, testTvTable.id);
      expect(result.name, testTvTable.name);
    });

    test('fromMap should create TvTable from map', () {
      final result = TvTable.fromMap(testTvMap);
      expect(result.id, testTvTable.id);
      expect(result.name, testTvTable.name);
      expect(result.posterPath, testTvTable.posterPath);
      expect(result.overview, testTvTable.overview);
    });
  });
}

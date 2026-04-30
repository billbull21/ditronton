import 'package:dartz/dartz.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlist(mockTvRepository);
  });

  test('should remove tv from the repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(testTvDetail));
    expect(result, const Right('Removed from Watchlist'));
  });
}

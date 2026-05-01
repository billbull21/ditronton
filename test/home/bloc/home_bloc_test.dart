import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/presentation/bloc/home_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/home_movie_page.dart';

void main() {
  group('HomeBloc', () {
    blocTest<HomeBloc, HomeState>(
      'initial state should emit nothing when no event is added',
      build: () => HomeBloc(),
      expect: () => [],
    );

    blocTest<HomeBloc, HomeState>(
      'should change page when ChangePageEvent is added',
      build: () => HomeBloc(),
      act: (bloc) => bloc.add(const ChangePageEvent(title: 'MOVIES', page: HomeMoviePage())),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.title, 'title', 'MOVIES')
            .having((s) => s.activePage, 'activePage', isA<HomeMoviePage>()),
      ],
    );
  });
}
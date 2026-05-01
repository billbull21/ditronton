import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/list/movie_list_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/popular_movies_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockMovieListBloc
    extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

void main() {
  late MockMovieListBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieListBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieListBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    whenListen<MovieListState>(mockBloc, const Stream.empty(),
        initialState:
            const MovieListState(popularMoviesState: RequestState.Loading));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    whenListen<MovieListState>(mockBloc, const Stream.empty(),
        initialState: const MovieListState(
          popularMoviesState: RequestState.Loaded,
          popularMovies: [],
        ));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (tester) async {
    whenListen<MovieListState>(mockBloc, const Stream.empty(),
        initialState: const MovieListState(
          popularMoviesState: RequestState.Error,
          message: 'Error message',
        ));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('Page should display list items when loaded with data',
      (tester) async {
    whenListen<MovieListState>(mockBloc, const Stream.empty(),
        initialState: MovieListState(
          popularMoviesState: RequestState.Loaded,
          popularMovies: [testMovie],
        ));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/list/movie_list_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/now_playing_movies_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/widgets/movie_card_list.dart';

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

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen<MovieListState>(
      mockBloc,
      const Stream.empty(),
      initialState:
          const MovieListState(nowPlayingState: RequestState.Loading),
    );

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    whenListen<MovieListState>(
      mockBloc,
      const Stream.empty(),
      initialState: MovieListState(
        nowPlayingState: RequestState.Loaded,
        nowPlayingMovies: [testMovie],
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should display error message when error', (tester) async {
    whenListen<MovieListState>(
      mockBloc,
      const Stream.empty(),
      initialState: const MovieListState(
        nowPlayingState: RequestState.Error,
        message: 'Server Failure',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));
    await tester.pump();

    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text('Server Failure'), findsOneWidget);
  });
}

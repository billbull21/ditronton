import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/watchlist_movies_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/widgets/movie_card_list.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

void main() {
  late MockWatchlistMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockWatchlistMovieBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen<WatchlistMovieState>(
      mockBloc,
      const Stream.empty(),
      initialState:
          const WatchlistMovieState(watchlistState: RequestState.Loading),
    );

    await tester.pumpWidget(makeTestableWidget(WatchlistMoviesPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    whenListen<WatchlistMovieState>(
      mockBloc,
      const Stream.empty(),
      initialState: WatchlistMovieState(
        watchlistState: RequestState.Loaded,
        watchlistMovies: [testMovie],
      ),
    );

    await tester.pumpWidget(makeTestableWidget(WatchlistMoviesPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should display empty message when watchlist is empty',
      (tester) async {
    whenListen<WatchlistMovieState>(
      mockBloc,
      const Stream.empty(),
      initialState: const WatchlistMovieState(
        watchlistState: RequestState.Loaded,
        watchlistMovies: [],
      ),
    );

    await tester.pumpWidget(makeTestableWidget(WatchlistMoviesPage()));
    await tester.pump();

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
    expect(find.text('No movies in watchlist'), findsOneWidget);
  });

  testWidgets('Page should display error message when error', (tester) async {
    whenListen<WatchlistMovieState>(
      mockBloc,
      const Stream.empty(),
      initialState: const WatchlistMovieState(
        watchlistState: RequestState.Error,
        message: 'Failed to load watchlist',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(WatchlistMoviesPage()));
    await tester.pump();

    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text('Failed to load watchlist'), findsOneWidget);
  });
}

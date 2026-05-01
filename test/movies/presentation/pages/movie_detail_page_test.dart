import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/movie_detail_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc
    extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (tester) async {
    final state = MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: const [],
      isAddedToWatchlist: false,
    );
    whenListen<MovieDetailState>(mockBloc, const Stream.empty(), initialState: state);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (tester) async {
    final state = MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: const [],
      isAddedToWatchlist: true,
    );
    whenListen<MovieDetailState>(mockBloc, const Stream.empty(), initialState: state);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when added to watchlist',
      (tester) async {
    final initialState = MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: const [],
      isAddedToWatchlist: false,
    );
    final stateWithMessage = initialState.copyWith(
      watchlistMessage: MovieDetailBloc.watchlistAddSuccessMessage,
      isAddedToWatchlist: true,
    );
    whenListen(
      mockBloc,
      Stream.fromIterable([stateWithMessage]),
      initialState: initialState,
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (tester) async {
    final initialState = MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: const [],
      isAddedToWatchlist: false,
    );
    final stateWithFailure = initialState.copyWith(watchlistMessage: 'Failed');
    whenListen(
      mockBloc,
      Stream.fromIterable([stateWithFailure]),
      initialState: initialState,
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Should display CircularProgressIndicator when movieState is Loading',
      (tester) async {
    whenListen<MovieDetailState>(mockBloc, const Stream.empty(),
        initialState:
            const MovieDetailState(movieState: RequestState.Loading));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display error text when movieState is Error',
      (tester) async {
    whenListen<MovieDetailState>(mockBloc, const Stream.empty(),
        initialState: const MovieDetailState(
          movieState: RequestState.Error,
          message: 'Movie error occurred',
        ));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.text('Movie error occurred'), findsOneWidget);
  });

  testWidgets(
      'Should display remove icon when movie is in watchlist and remove triggers snackbar',
      (tester) async {
    final initialState = MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: const [],
      isAddedToWatchlist: true,
    );
    final stateWithMessage = initialState.copyWith(
      watchlistMessage: MovieDetailBloc.watchlistRemoveSuccessMessage,
      isAddedToWatchlist: false,
    );
    whenListen(
      mockBloc,
      Stream.fromIterable([stateWithMessage]),
      initialState: initialState,
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Should display loading indicator in recommendations when Loading',
      (tester) async {
    whenListen<MovieDetailState>(
      mockBloc,
      const Stream.empty(),
      initialState: MovieDetailState(
        movieState: RequestState.Loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.Loading,
        movieRecommendations: const [],
        isAddedToWatchlist: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Should display error text in recommendations when Error',
      (tester) async {
    whenListen<MovieDetailState>(
      mockBloc,
      const Stream.empty(),
      initialState: MovieDetailState(
        movieState: RequestState.Loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.Error,
        movieRecommendations: const [],
        isAddedToWatchlist: false,
        message: 'Recommendation error',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.text('Recommendation error'), findsOneWidget);
  });

  testWidgets('Should display recommendations when Loaded with items',
      (tester) async {
    whenListen<MovieDetailState>(
      mockBloc,
      const Stream.empty(),
      initialState: MovieDetailState(
        movieState: RequestState.Loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.Loaded,
        movieRecommendations: [testMovie],
        isAddedToWatchlist: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byType(MovieDetailPage), findsOneWidget);
  });
}

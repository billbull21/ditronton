import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/tv_detail_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc
    extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

void main() {
  late MockTvDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockTvDetailBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (tester) async {
    whenListen<TvDetailState>(mockBloc, const Stream.empty(),
        initialState: TvDetailState(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: const [],
          isAddedToWatchlist: false,
        ));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tv is added to watchlist',
      (tester) async {
    whenListen<TvDetailState>(mockBloc, const Stream.empty(),
        initialState: TvDetailState(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: const [],
          isAddedToWatchlist: true,
        ));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when added to watchlist',
      (tester) async {
    final initialState = TvDetailState(
      tvState: RequestState.Loaded,
      tv: testTvDetail,
      recommendationState: RequestState.Loaded,
      tvRecommendations: const [],
      isAddedToWatchlist: false,
    );
    final stateWithMessage = initialState.copyWith(
      watchlistMessage: TvDetailBloc.watchlistAddSuccessMessage,
      isAddedToWatchlist: true,
    );
    whenListen(
      mockBloc,
      Stream.fromIterable([stateWithMessage]),
      initialState: initialState,
    );

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (tester) async {
    final initialState = TvDetailState(
      tvState: RequestState.Loaded,
      tv: testTvDetail,
      recommendationState: RequestState.Loaded,
      tvRecommendations: const [],
      isAddedToWatchlist: false,
    );
    final stateWithFailure = initialState.copyWith(watchlistMessage: 'Failed');
    whenListen(
      mockBloc,
      Stream.fromIterable([stateWithFailure]),
      initialState: initialState,
    );

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Should display CircularProgressIndicator when tvState is Loading',
      (tester) async {
    whenListen<TvDetailState>(mockBloc, const Stream.empty(),
        initialState:
            const TvDetailState(tvState: RequestState.Loading));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display error text when tvState is Error',
      (tester) async {
    whenListen<TvDetailState>(mockBloc, const Stream.empty(),
        initialState: const TvDetailState(
          tvState: RequestState.Error,
          message: 'Error occurred',
        ));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.text('Error occurred'), findsOneWidget);
  });

  testWidgets('Should display remove icon when tv is added to watchlist',
      (tester) async {
    final initialState = TvDetailState(
      tvState: RequestState.Loaded,
      tv: testTvDetail,
      recommendationState: RequestState.Loaded,
      tvRecommendations: const [],
      isAddedToWatchlist: true,
    );
    final stateWithMessage = initialState.copyWith(
      watchlistMessage: TvDetailBloc.watchlistRemoveSuccessMessage,
      isAddedToWatchlist: false,
    );
    whenListen(
      mockBloc,
      Stream.fromIterable([stateWithMessage]),
      initialState: initialState,
    );

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Should display loading indicator in recommendations when Loading',
      (tester) async {
    whenListen<TvDetailState>(mockBloc, const Stream.empty(),
        initialState: TvDetailState(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loading,
          tvRecommendations: const [],
          isAddedToWatchlist: false,
        ));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Should display error text in recommendations when Error',
      (tester) async {
    whenListen<TvDetailState>(mockBloc, const Stream.empty(),
        initialState: TvDetailState(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Error,
          tvRecommendations: const [],
          isAddedToWatchlist: false,
          message: 'Recommendation error',
        ));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.text('Recommendation error'), findsOneWidget);
  });

  testWidgets('Should display recommendations list when Loaded with items',
      (tester) async {
    whenListen<TvDetailState>(mockBloc, const Stream.empty(),
        initialState: TvDetailState(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: [testTv],
          isAddedToWatchlist: false,
        ));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byType(TvDetailPage), findsOneWidget);
  });
}

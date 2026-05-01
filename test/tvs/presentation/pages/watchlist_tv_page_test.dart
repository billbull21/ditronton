import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/watchlist_tv_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/widgets/tv_card_list.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockWatchlistTvBloc
    extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

void main() {
  late MockWatchlistTvBloc mockBloc;

  setUp(() {
    mockBloc = MockWatchlistTvBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen<WatchlistTvState>(
      mockBloc,
      const Stream.empty(),
      initialState:
          const WatchlistTvState(watchlistState: RequestState.Loading),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvsPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    whenListen<WatchlistTvState>(
      mockBloc,
      const Stream.empty(),
      initialState: WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvs: [testTv],
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvsPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('Page should display empty message when watchlist is empty',
      (tester) async {
    whenListen<WatchlistTvState>(
      mockBloc,
      const Stream.empty(),
      initialState: const WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvs: [],
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvsPage()));
    await tester.pump();

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
    expect(find.text('No TV shows in watchlist'), findsOneWidget);
  });

  testWidgets('Page should display error message when error', (tester) async {
    whenListen<WatchlistTvState>(
      mockBloc,
      const Stream.empty(),
      initialState: const WatchlistTvState(
        watchlistState: RequestState.Error,
        message: 'Failed to load watchlist',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvsPage()));
    await tester.pump();

    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text('Failed to load watchlist'), findsOneWidget);
  });
}

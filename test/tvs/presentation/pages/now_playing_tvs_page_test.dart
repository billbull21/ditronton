import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/now_playing_tvs_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvListBloc
    extends MockBloc<TvListEvent, TvListState>
    implements TvListBloc {}

void main() {
  late MockTvListBloc mockBloc;

  setUp(() {
    mockBloc = MockTvListBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvListBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    whenListen<TvListState>(mockBloc, const Stream.empty(),
        initialState:
            const TvListState(nowPlayingState: RequestState.Loading));

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvsPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    whenListen<TvListState>(mockBloc, const Stream.empty(),
        initialState: const TvListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvs: [],
        ));

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvsPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (tester) async {
    whenListen<TvListState>(mockBloc, const Stream.empty(),
        initialState: const TvListState(
          nowPlayingState: RequestState.Error,
          message: 'Error message',
        ));

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvsPage()));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('Page should display list items when loaded with data',
      (tester) async {
    whenListen<TvListState>(mockBloc, const Stream.empty(),
        initialState: TvListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvs: [testTv],
        ));

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvsPage()));

    expect(find.byType(ListView), findsOneWidget);
  });
}

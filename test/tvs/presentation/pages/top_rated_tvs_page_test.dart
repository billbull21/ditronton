import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/top_rated_tvs_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/widgets/tv_card_list.dart';

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

  testWidgets('Page should display CircularProgressIndicator when loading',
      (tester) async {
    whenListen<TvListState>(
      mockBloc,
      const Stream.empty(),
      initialState:
          const TvListState(topRatedTvsState: RequestState.Loading),
    );

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvsPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    whenListen<TvListState>(
      mockBloc,
      const Stream.empty(),
      initialState: TvListState(
        topRatedTvsState: RequestState.Loaded,
        topRatedTvs: [testTv],
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvsPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('Page should display error message when error', (tester) async {
    whenListen<TvListState>(
      mockBloc,
      const Stream.empty(),
      initialState: const TvListState(
        topRatedTvsState: RequestState.Error,
        message: 'Server Failure',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvsPage()));
    await tester.pump();

    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text('Server Failure'), findsOneWidget);
  });
}

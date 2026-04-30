import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv_detail.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/tv_detail_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tv is added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Should display CircularProgressIndicator when tvState is Loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display error text when tvState is Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error occurred');

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.text('Error occurred'), findsOneWidget);
  });

  testWidgets('Should display remove icon when tv is added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.watchlistMessage)
        .thenReturn(TvDetailNotifier.watchlistRemoveSuccessMessage);

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Should display loading indicator in recommendations when Loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Should display error text in recommendations when Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Error);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.message).thenReturn('Recommendation error');

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.text('Recommendation error'), findsOneWidget);
  });

  testWidgets('Should display recommendations list when Loaded with items',
      (WidgetTester tester) async {
    final tTvWithGenres = TvDetail(
      adult: false,
      backdropPath: '/backdrop.jpg',
      genres: const [TvGenre(id: 1, name: 'Action')],
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: '/poster.jpg',
      voteAverage: 1.0,
      voteCount: 1,
      seasons: [
        TvSeason(
          airDate: DateTime(2021, 1, 1),
          episodeCount: 10,
          id: 1,
          name: 'Season 1',
          overview: 'Overview',
          posterPath: '/s.jpg',
          seasonNumber: 1,
          voteAverage: 7.5,
        ),
      ],
    );

    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(tTvWithGenres);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn([testTv]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(TvDetailPage), findsOneWidget);
  });
}

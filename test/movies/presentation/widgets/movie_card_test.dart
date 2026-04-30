import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/widgets/movie_card_list.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(body: body),
    );
  }

  group('MovieCard widget', () {
    testWidgets('should display movie title', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));

      expect(find.text(testMovie.title!), findsOneWidget);
    });

    testWidgets('should display movie overview', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));

      expect(find.text(testMovie.overview!), findsOneWidget);
    });

    testWidgets('should render InkWell', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should render Card widget', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should navigate when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(body: Text('Detail')),
          );
        },
        home: Scaffold(body: MovieCard(testMovie)),
      ));

      await tester.tap(find.byType(InkWell));
      await tester.pump();
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/widgets/tv_card_list.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(body: body),
    );
  }

  group('TvCard widget', () {
    testWidgets('should display tv name', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(TvCard(testTv)));

      expect(find.text(testTv.name!), findsOneWidget);
    });

    testWidgets('should display tv overview', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(TvCard(testTv)));

      expect(find.text(testTv.overview!), findsOneWidget);
    });

    testWidgets('should render InkWell', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(TvCard(testTv)));

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should render Card widget', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(TvCard(testTv)));

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should navigate when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(body: Text('Detail')),
          );
        },
        home: Scaffold(body: TvCard(testTv)),
      ));

      await tester.tap(find.byType(InkWell));
      await tester.pump();
    });
  });
}

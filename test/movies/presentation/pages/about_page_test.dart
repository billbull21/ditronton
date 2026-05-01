import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/about_page.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(home: body);
  }

  testWidgets('Page should display app description text', (tester) async {
    await tester.pumpWidget(makeTestableWidget(AboutPage()));

    expect(
      find.textContaining('Ditonton'),
      findsOneWidget,
    );
  });

  testWidgets('Page should display back button', (tester) async {
    await tester.pumpWidget(makeTestableWidget(AboutPage()));

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('Back button should pop navigation', (tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        '/': (_) => Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AboutPage.ROUTE_NAME),
                  child: const Text('Go to About'),
                ),
              ),
            ),
        AboutPage.ROUTE_NAME: (_) => AboutPage(),
      },
    ));

    await tester.tap(find.text('Go to About'));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsNothing);
  });
}

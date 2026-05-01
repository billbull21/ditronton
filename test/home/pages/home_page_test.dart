import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/presentation/bloc/home_bloc.dart';
import 'package:movie_dicoding_app/home_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/list/movie_list_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/search/movie_search_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/home_movie_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/search_movie_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/search/tv_search_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/home_tv_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/search_tv_page.dart';

class MockHomePageBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}
class MockMovieListBloc extends MockBloc<MovieListEvent, MovieListState> implements MovieListBloc {}
class MockMovieSearchBloc extends MockBloc<MovieSearchEvent, MovieSearchState> implements MovieSearchBloc {}
class MockTvListBloc extends MockBloc<TvListEvent, TvListState> implements TvListBloc {}
class MockTvSearchBloc extends MockBloc<TvSearchEvent, TvSearchState> implements TvSearchBloc {}

void main() {
  late MockHomePageBloc mockHomePageBloc;
  late MockMovieListBloc mockMovieListBloc;
  late MockMovieSearchBloc mockMovieSearchBloc;
  late MockTvListBloc mockTvListBloc;
  late MockTvSearchBloc mockTvSearchBloc;

  setUp(() {
    mockHomePageBloc = MockHomePageBloc();
    mockMovieListBloc = MockMovieListBloc();
    mockMovieSearchBloc = MockMovieSearchBloc();
    mockTvListBloc = MockTvListBloc();
    mockTvSearchBloc = MockTvSearchBloc();
  });

  tearDown(() {
    mockHomePageBloc.close();
    mockMovieListBloc.close();
    mockMovieSearchBloc.close();
    mockTvListBloc.close();
    mockTvSearchBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>.value(value: mockHomePageBloc),
        BlocProvider<MovieListBloc>.value(value: mockMovieListBloc),
        BlocProvider<TvListBloc>.value(value: mockTvListBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case SearchMoviePage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<MovieSearchBloc>.value(
                  value: mockMovieSearchBloc,
                  child: const SearchMoviePage(),
                ),
              );
            case SearchTvPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<TvSearchBloc>.value(
                  value: mockTvSearchBloc,
                  child: const SearchTvPage(),
                ),
              );
            default:
              return null;
          }
        },
      ),
    );
  }

  testWidgets('initial state should show MOVIES page with correct title',
      (WidgetTester tester) async {
    whenListen<HomeState>(
      mockHomePageBloc,
      Stream.empty(),
      initialState: const HomeState(),
    );
    whenListen<MovieListState>(
      mockMovieListBloc,
      Stream.empty(),
      initialState: const MovieListState(),
    );

    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    expect(find.text('DITRONTON - MOVIES'), findsOneWidget);
    expect(find.byType(HomeMoviePage), findsOneWidget);
  });

  testWidgets('should show TV SERIES page when state changes to TV SERIES',
      (WidgetTester tester) async {
    whenListen<HomeState>(
      mockHomePageBloc,
      Stream.value(const HomeState(title: 'TV SERIES', activePage: HomeTvPage())),
      initialState: const HomeState(),
    );
    whenListen<MovieListState>(
      mockMovieListBloc,
      Stream.empty(),
      initialState: const MovieListState(),
    );
    whenListen<TvListState>(
      mockTvListBloc,
      Stream.empty(),
      initialState: const TvListState(),
    );

    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    expect(find.text('DITRONTON - TV SERIES'), findsOneWidget);
    expect(find.byType(HomeTvPage), findsOneWidget);
  });

  testWidgets('should show search icon in app bar', (WidgetTester tester) async {
    whenListen<HomeState>(
      mockHomePageBloc,
      Stream.empty(),
      initialState: const HomeState(),
    );
    whenListen<MovieListState>(
      mockMovieListBloc,
      Stream.empty(),
      initialState: const MovieListState(),
    );

    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('should open drawer when menu icon tapped',
      (WidgetTester tester) async {
    whenListen<HomeState>(
      mockHomePageBloc,
      Stream.empty(),
      initialState: const HomeState(),
    );
    whenListen<MovieListState>(
      mockMovieListBloc,
      Stream.empty(),
      initialState: const MovieListState(),
    );

    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('TV Series'), findsOneWidget);
    expect(find.text('Watchlist Movies'), findsOneWidget);
    expect(find.text('Watchlist Tv Series'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('should navigate to SearchMoviePage when search tapped on MOVIES',
      (WidgetTester tester) async {
    whenListen<HomeState>(
      mockHomePageBloc,
      Stream.empty(),
      initialState: const HomeState(title: 'MOVIES'),
    );
    whenListen<MovieListState>(
      mockMovieListBloc,
      Stream.empty(),
      initialState: const MovieListState(),
    );
    whenListen<MovieSearchState>(
      mockMovieSearchBloc,
      Stream.empty(),
      initialState: const MovieSearchState(),
    );

    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(SearchMoviePage), findsOneWidget);
  });

  testWidgets('should navigate to SearchTvPage when search tapped on TV SERIES',
      (WidgetTester tester) async {
    whenListen<HomeState>(
      mockHomePageBloc,
      Stream.empty(),
      initialState: const HomeState(title: 'TV SERIES', activePage: HomeTvPage()),
    );
    whenListen<MovieListState>(
      mockMovieListBloc,
      Stream.empty(),
      initialState: const MovieListState(),
    );
    whenListen<TvListState>(
      mockTvListBloc,
      Stream.empty(),
      initialState: const TvListState(),
    );
    whenListen<TvSearchState>(
      mockTvSearchBloc,
      Stream.empty(),
      initialState: const TvSearchState(),
    );

    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(SearchTvPage), findsOneWidget);
  });
} 
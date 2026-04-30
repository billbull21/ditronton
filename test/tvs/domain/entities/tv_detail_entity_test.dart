import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv_detail.dart';

void main() {
  group('TvDetail entity', () {
    final tTvDetail = TvDetail(
      adult: false,
      backdropPath: '/backdrop.jpg',
      episodeRunTime: const [30],
      firstAirDate: DateTime(2021, 1, 1),
      genres: const [TvGenre(id: 1, name: 'Action')],
      homepage: 'https://example.com',
      id: 1,
      inProduction: true,
      languages: const ['en'],
      lastAirDate: DateTime(2021, 12, 31),
      name: 'Test Show',
      nextEpisodeToAir: null,
      numberOfEpisodes: 10,
      numberOfSeasons: 1,
      originCountry: const ['US'],
      originalLanguage: 'en',
      originalName: 'Test Show Original',
      overview: 'Overview text',
      popularity: 9.5,
      posterPath: '/poster.jpg',
      seasons: [
        TvSeason(
          airDate: DateTime(2021, 1, 1),
          episodeCount: 10,
          id: 1,
          name: 'Season 1',
          overview: 'Season Overview',
          posterPath: '/season.jpg',
          seasonNumber: 1,
          voteAverage: 7.5,
        ),
      ],
      status: 'Returning Series',
      tagline: 'A great show',
      type: 'Scripted',
      voteAverage: 8.0,
      voteCount: 500,
    );

    test('props should contain all fields', () {
      expect(tTvDetail.props, [
        false,
        '/backdrop.jpg',
        const [30],
        DateTime(2021, 1, 1),
        const [TvGenre(id: 1, name: 'Action')],
        'https://example.com',
        1,
        true,
        const ['en'],
        DateTime(2021, 12, 31),
        'Test Show',
        null,
        10,
        1,
        const ['US'],
        'en',
        'Test Show Original',
        'Overview text',
        9.5,
        '/poster.jpg',
        tTvDetail.seasons,
        'Returning Series',
        'A great show',
        'Scripted',
        8.0,
        500,
      ]);
    });

    test('copyWith should return same TvDetail when no args provided', () {
      final copy = tTvDetail.copyWith();
      expect(copy.id, tTvDetail.id);
      expect(copy.name, tTvDetail.name);
      expect(copy.overview, tTvDetail.overview);
    });

    test('copyWith should update individual fields', () {
      final copy = tTvDetail.copyWith(name: 'New Name', voteAverage: 9.9);
      expect(copy.name, 'New Name');
      expect(copy.voteAverage, 9.9);
      expect(copy.id, tTvDetail.id);
      expect(copy.overview, tTvDetail.overview);
    });

    test('copyWith should update all fields when provided', () {
      final newSeasons = [
        TvSeason(
          airDate: DateTime(2022, 6, 1),
          episodeCount: 8,
          id: 2,
          name: 'Season 2',
          overview: 'S2 Overview',
          posterPath: '/s2.jpg',
          seasonNumber: 2,
          voteAverage: 8.0,
        )
      ];
      final copy = tTvDetail.copyWith(
        adult: true,
        backdropPath: '/new_backdrop.jpg',
        episodeRunTime: [60],
        firstAirDate: DateTime(2022, 1, 1),
        genres: const [TvGenre(id: 2, name: 'Drama')],
        homepage: 'https://new.com',
        id: 2,
        inProduction: false,
        languages: const ['fr'],
        lastAirDate: DateTime(2022, 12, 31),
        name: 'New Show',
        nextEpisodeToAir: null,
        numberOfEpisodes: 20,
        numberOfSeasons: 2,
        originCountry: const ['FR'],
        originalLanguage: 'fr',
        originalName: 'New Show FR',
        overview: 'New Overview',
        popularity: 5.0,
        posterPath: '/new_poster.jpg',
        seasons: newSeasons,
        status: 'Ended',
        tagline: 'New tagline',
        type: 'Reality',
        voteAverage: 6.0,
        voteCount: 200,
      );
      expect(copy.adult, true);
      expect(copy.name, 'New Show');
      expect(copy.id, 2);
      expect(copy.voteAverage, 6.0);
      expect(copy.status, 'Ended');
    });
  });

  group('TvGenre entity', () {
    const tGenre = TvGenre(id: 1, name: 'Action');

    test('props should contain id and name', () {
      expect(tGenre.props, [1, 'Action']);
    });

    test('copyWith should return same genre when no args provided', () {
      final copy = tGenre.copyWith();
      expect(copy.id, 1);
      expect(copy.name, 'Action');
    });

    test('copyWith should update id', () {
      final copy = tGenre.copyWith(id: 99);
      expect(copy.id, 99);
      expect(copy.name, 'Action');
    });

    test('copyWith should update name', () {
      final copy = tGenre.copyWith(name: 'Drama');
      expect(copy.id, 1);
      expect(copy.name, 'Drama');
    });

    test('equality should work', () {
      const a = TvGenre(id: 1, name: 'Action');
      const b = TvGenre(id: 1, name: 'Action');
      expect(a, equals(b));
    });
  });

  group('TvSeason entity', () {
    final tSeason = TvSeason(
      airDate: DateTime(2021, 1, 1),
      episodeCount: 10,
      id: 1,
      name: 'Season 1',
      overview: 'Season Overview',
      posterPath: '/season.jpg',
      seasonNumber: 1,
      voteAverage: 7.5,
    );

    test('props should contain all fields', () {
      expect(tSeason.props, [
        DateTime(2021, 1, 1),
        10,
        1,
        'Season 1',
        'Season Overview',
        '/season.jpg',
        1,
        7.5,
      ]);
    });

    test('copyWith should return same season when no args provided', () {
      final copy = tSeason.copyWith();
      expect(copy.id, tSeason.id);
      expect(copy.name, tSeason.name);
    });

    test('copyWith should update individual fields', () {
      final copy = tSeason.copyWith(name: 'Season 2', episodeCount: 8);
      expect(copy.name, 'Season 2');
      expect(copy.episodeCount, 8);
      expect(copy.id, tSeason.id);
    });

    test('copyWith should update all fields', () {
      final newDate = DateTime(2022, 6, 1);
      final copy = tSeason.copyWith(
        airDate: newDate,
        episodeCount: 5,
        id: 2,
        name: 'Special',
        overview: 'New overview',
        posterPath: '/new.jpg',
        seasonNumber: 0,
        voteAverage: 9.0,
      );
      expect(copy.airDate, newDate);
      expect(copy.episodeCount, 5);
      expect(copy.id, 2);
      expect(copy.voteAverage, 9.0);
    });

    test('equality should work', () {
      final a = TvSeason(
        airDate: DateTime(2021, 1, 1),
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season Overview',
        posterPath: '/season.jpg',
        seasonNumber: 1,
        voteAverage: 7.5,
      );
      final b = TvSeason(
        airDate: DateTime(2021, 1, 1),
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season Overview',
        posterPath: '/season.jpg',
        seasonNumber: 1,
        voteAverage: 7.5,
      );
      expect(a, equals(b));
    });
  });
}

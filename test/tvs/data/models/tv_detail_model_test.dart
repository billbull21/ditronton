import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/modules/tvs/data/models/tv_detail_model.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv_detail.dart';

void main() {
  final tTvGenreResponse = TvGenreResponse(id: 1, name: 'Action');

  final tTvSeasonResponse = TvSeasonResponse(
    airDate: DateTime(2021, 1, 1),
    episodeCount: 10,
    id: 1,
    name: 'Season 1',
    overview: 'Season Overview',
    posterPath: '/season.jpg',
    seasonNumber: 1,
    voteAverage: 7.5,
  );

  final tTvDetailResponse = TvDetailResponse(
    adult: false,
    backdropPath: '/backdrop.jpg',
    episodeRunTime: const [30],
    firstAirDate: DateTime(2021, 1, 1),
    genres: [tTvGenreResponse],
    homepage: 'https://example.com',
    id: 1,
    inProduction: true,
    languages: const ['en'],
    lastAirDate: DateTime(2021, 12, 31),
    name: 'Test TV Show',
    nextEpisodeToAir: null,
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'Test TV Show Original',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/poster.jpg',
    seasons: [tTvSeasonResponse],
    status: 'Returning Series',
    tagline: 'A tagline',
    type: 'Scripted',
    voteAverage: 7.5,
    voteCount: 100,
  );

  group('TvDetailResponse', () {
    test('should be a subclass of TvDetail entity', () {
      expect(tTvDetailResponse, isA<TvDetail>());
    });

    test('toEntity should return TvDetail', () {
      final result = tTvDetailResponse.toEntity;
      expect(result, isA<TvDetail>());
    });

    test('should support equality via props', () {
      final tTvDetailResponse2 = TvDetailResponse(
        adult: false,
        backdropPath: '/backdrop.jpg',
        episodeRunTime: const [30],
        firstAirDate: DateTime(2021, 1, 1),
        genres: [TvGenreResponse(id: 1, name: 'Action')],
        homepage: 'https://example.com',
        id: 1,
        inProduction: true,
        languages: const ['en'],
        lastAirDate: DateTime(2021, 12, 31),
        name: 'Test TV Show',
        nextEpisodeToAir: null,
        numberOfEpisodes: 10,
        numberOfSeasons: 1,
        originCountry: const ['US'],
        originalLanguage: 'en',
        originalName: 'Test TV Show Original',
        overview: 'Overview',
        popularity: 1.0,
        posterPath: '/poster.jpg',
        seasons: [TvSeasonResponse(
          airDate: DateTime(2021, 1, 1),
          episodeCount: 10,
          id: 1,
          name: 'Season 1',
          overview: 'Season Overview',
          posterPath: '/season.jpg',
          seasonNumber: 1,
          voteAverage: 7.5,
        )],
        status: 'Returning Series',
        tagline: 'A tagline',
        type: 'Scripted',
        voteAverage: 7.5,
        voteCount: 100,
      );
      expect(tTvDetailResponse, equals(tTvDetailResponse2));
    });

    test('fromJson should create TvDetailResponse from JSON', () {
      final json = {
        'adult': false,
        'backdrop_path': '/backdrop.jpg',
        'episode_run_time': [30],
        'first_air_date': '2021-01-01',
        'genres': [{'id': 1, 'name': 'Action'}],
        'homepage': 'https://example.com',
        'id': 1,
        'in_production': true,
        'languages': ['en'],
        'last_air_date': '2021-12-31',
        'name': 'Test TV Show',
        'next_episode_to_air': null,
        'number_of_episodes': 10,
        'number_of_seasons': 1,
        'origin_country': ['US'],
        'original_language': 'en',
        'original_name': 'Test TV Show Original',
        'overview': 'Overview',
        'popularity': 1.0,
        'poster_path': '/poster.jpg',
        'seasons': [
          {
            'air_date': '2021-01-01',
            'episode_count': 10,
            'id': 1,
            'name': 'Season 1',
            'overview': 'Season Overview',
            'poster_path': '/season.jpg',
            'season_number': 1,
            'vote_average': 7.5,
          }
        ],
        'status': 'Returning Series',
        'tagline': 'A tagline',
        'type': 'Scripted',
        'vote_average': 7.5,
        'vote_count': 100,
      };

      final result = TvDetailResponse.fromJson(json);

      expect(result.id, 1);
      expect(result.name, 'Test TV Show');
      expect(result.genres, isNotEmpty);
      expect(result.seasons, isNotEmpty);
      expect(result.adult, false);
      expect(result.inProduction, true);
    });

    test('fromJson should handle null lists gracefully', () {
      final json = {
        'adult': false,
        'backdrop_path': null,
        'episode_run_time': null,
        'first_air_date': null,
        'genres': null,
        'homepage': null,
        'id': 1,
        'in_production': false,
        'languages': null,
        'last_air_date': null,
        'name': 'Name',
        'next_episode_to_air': null,
        'number_of_episodes': 0,
        'number_of_seasons': 0,
        'origin_country': null,
        'original_language': 'en',
        'original_name': 'Name',
        'overview': 'Overview',
        'popularity': 1.0,
        'poster_path': null,
        'seasons': null,
        'spoken_languages': null,
        'status': 'Ended',
        'tagline': null,
        'type': null,
        'vote_average': 5.0,
        'vote_count': 10,
      };

      final result = TvDetailResponse.fromJson(json);

      expect(result.id, 1);
      expect(result.genres, isEmpty);
      expect(result.seasons, isEmpty);
      expect(result.episodeRunTime, isEmpty);
      expect(result.languages, isEmpty);
      expect(result.originCountry, isEmpty);
    });

    test('toJson should return correct JSON map', () {
      final result = tTvDetailResponse.toJson();

      expect(result['id'], 1);
      expect(result['name'], 'Test TV Show');
      expect(result['adult'], false);
      expect(result['in_production'], true);
      expect(result['overview'], 'Overview');
      expect(result['vote_average'], 7.5);
      expect(result['vote_count'], 100);
      expect(result['genres'], isA<List>());
      expect(result['seasons'], isA<List>());
      expect(result['first_air_date'], '2021-01-01');
      expect(result['last_air_date'], '2021-12-31');
    });

    test('toJson should return empty episode_run_time list when null', () {
      final response = TvDetailResponse(
        adult: false,
        id: 1,
        name: 'Test',
        overview: 'Overview',
        voteAverage: 1.0,
        voteCount: 1,
        episodeRunTime: null,
        firstAirDate: DateTime(2021, 1, 1),
        lastAirDate: DateTime(2021, 12, 31),
        genres: null,
        seasons: null,
      );
      final result = response.toJson();
      expect(result['episode_run_time'], isEmpty);
    });

    test('fromEntity should create TvDetailResponse from TvDetail entity', () {
      final entity = TvDetail(
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
        name: 'Test TV Show',
        nextEpisodeToAir: null,
        numberOfEpisodes: 10,
        numberOfSeasons: 1,
        originCountry: const ['US'],
        originalLanguage: 'en',
        originalName: 'Test TV Show Original',
        overview: 'Overview',
        popularity: 1.0,
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
          )
        ],
        status: 'Returning Series',
        tagline: 'A tagline',
        type: 'Scripted',
        voteAverage: 7.5,
        voteCount: 100,
      );

      final result = TvDetailResponse.fromEntity(entity);

      expect(result, isA<TvDetailResponse>());
      expect(result.id, entity.id);
      expect(result.name, entity.name);
      expect(result.genres, isNotEmpty);
      expect(result.seasons, isNotEmpty);
    });

    test('fromEntity should handle null genres, seasons', () {
      final entity = TvDetail(
        adult: false,
        id: 1,
        name: 'Name',
        overview: 'Overview',
        voteAverage: 1.0,
        voteCount: 1,
      );

      final result = TvDetailResponse.fromEntity(entity);
      expect(result.genres, isEmpty);
      expect(result.seasons, isEmpty);
    });
  });

  group('TvGenreResponse', () {
    test('fromJson should create TvGenreResponse from JSON', () {
      final json = {'id': 1, 'name': 'Action'};
      final result = TvGenreResponse.fromJson(json);
      expect(result.id, 1);
      expect(result.name, 'Action');
    });

    test('toJson should return correct JSON map', () {
      final result = tTvGenreResponse.toJson();
      expect(result, {'id': 1, 'name': 'Action'});
    });

    test('fromEntity should create TvGenreResponse from TvGenre entity', () {
      const genre = TvGenre(id: 2, name: 'Drama');
      final result = TvGenreResponse.fromEntity(genre);
      expect(result.id, 2);
      expect(result.name, 'Drama');
    });

    test('should support equality via props', () {
      final a = TvGenreResponse(id: 1, name: 'Action');
      final b = TvGenreResponse(id: 1, name: 'Action');
      expect(a, equals(b));
    });
  });

  group('TvSeasonResponse', () {
    test('fromJson should create TvSeasonResponse from JSON', () {
      final json = {
        'air_date': '2021-01-01',
        'episode_count': 10,
        'id': 1,
        'name': 'Season 1',
        'overview': 'Overview',
        'poster_path': '/season.jpg',
        'season_number': 1,
        'vote_average': 7.5,
      };
      final result = TvSeasonResponse.fromJson(json);
      expect(result.id, 1);
      expect(result.name, 'Season 1');
      expect(result.episodeCount, 10);
      expect(result.voteAverage, 7.5);
    });

    test('fromJson should handle null air_date', () {
      final json = {
        'air_date': null,
        'episode_count': 5,
        'id': 2,
        'name': 'Season 2',
        'overview': 'Overview',
        'poster_path': null,
        'season_number': 2,
        'vote_average': 6.0,
      };
      final result = TvSeasonResponse.fromJson(json);
      expect(result.airDate, isNull);
    });

    test('toJson should return correct JSON map', () {
      final result = tTvSeasonResponse.toJson();
      expect(result['id'], 1);
      expect(result['name'], 'Season 1');
      expect(result['episode_count'], 10);
      expect(result['season_number'], 1);
      expect(result['vote_average'], 7.5);
      expect(result['air_date'], '2021-01-01');
    });

    test('fromEntity should create TvSeasonResponse from TvSeason entity', () {
      final season = TvSeason(
        airDate: DateTime(2022, 1, 1),
        episodeCount: 8,
        id: 3,
        name: 'Season 3',
        overview: 'Overview',
        posterPath: '/s3.jpg',
        seasonNumber: 3,
        voteAverage: 8.0,
      );
      final result = TvSeasonResponse.fromEntity(season);
      expect(result.id, 3);
      expect(result.name, 'Season 3');
      expect(result.episodeCount, 8);
    });

    test('should support equality via props', () {
      final a = TvSeasonResponse(
        airDate: DateTime(2021, 1, 1),
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season Overview',
        posterPath: '/season.jpg',
        seasonNumber: 1,
        voteAverage: 7.5,
      );
      final b = TvSeasonResponse(
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

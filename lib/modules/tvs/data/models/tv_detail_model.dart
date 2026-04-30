import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv_detail.dart';

class TvDetailResponse extends TvDetail {
  const TvDetailResponse({
    super.adult,
    super.backdropPath,
    super.episodeRunTime,
    super.firstAirDate,
    super.genres,
    super.homepage,
    super.id,
    super.inProduction,
    super.languages,
    super.lastAirDate,
    super.name,
    super.nextEpisodeToAir,
    super.numberOfEpisodes,
    super.numberOfSeasons,
    super.originCountry,
    super.originalLanguage,
    super.originalName,
    super.overview,
    super.popularity,
    super.posterPath,
    super.seasons,
    super.status,
    super.tagline,
    super.type,
    super.voteAverage,
    super.voteCount,
  });

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) => TvDetailResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    episodeRunTime: json["episode_run_time"] == null
        ? []
        : List<int>.from(json["episode_run_time"]!.map((x) => x)),
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    genres: json["genres"] == null
        ? []
        : List<TvGenre>.from(json["genres"]!.map((x) => TvGenreResponse.fromJson(x))),
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
    lastAirDate: json["last_air_date"] == null ? null : DateTime.parse(json["last_air_date"]),
    name: json["name"],
    nextEpisodeToAir: json["next_episode_to_air"],
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originCountry: json["origin_country"] == null
        ? []
        : List<String>.from(json["origin_country"]!.map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    seasons: json["seasons"] == null
        ? []
        : List<TvSeason>.from(json["seasons"]!.map((x) => TvSeasonResponse.fromJson(x))),
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  TvDetail get toEntity => this as TvDetail;

  factory TvDetailResponse.fromEntity(TvDetail entity) => TvDetailResponse(
    adult: entity.adult,
    backdropPath: entity.backdropPath,
    episodeRunTime: entity.episodeRunTime,
    firstAirDate: entity.firstAirDate,
    genres: entity.genres == null
        ? []
        : List<TvGenre>.from(entity.genres!.map((x) => TvGenreResponse.fromEntity(x))),
    homepage: entity.homepage,
    id: entity.id,
    inProduction: entity.inProduction,
    languages: entity.languages,
    lastAirDate: entity.lastAirDate,
    name: entity.name,
    nextEpisodeToAir: entity.nextEpisodeToAir,
    numberOfEpisodes: entity.numberOfEpisodes,
    numberOfSeasons: entity.numberOfSeasons,
    originCountry: entity.originCountry,
    originalLanguage: entity.originalLanguage,
    originalName: entity.originalName,
    overview: entity.overview,
    popularity: entity.popularity,
    posterPath: entity.posterPath,
    seasons: entity.seasons == null
        ? []
        : List<TvSeason>.from(entity.seasons!.map((x) => TvSeasonResponse.fromEntity(x))),
    status: entity.status,
    tagline: entity.tagline,
    type: entity.type,
    voteAverage: entity.voteAverage,
    voteCount: entity.voteCount,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "episode_run_time": episodeRunTime == null
        ? []
        : List<dynamic>.from(episodeRunTime!.map((x) => x)),
    "first_air_date":
        "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => TvGenreResponse.fromEntity(x).toJson())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
    "last_air_date":
        "${lastAirDate!.year.toString().padLeft(4, '0')}-${lastAirDate!.month.toString().padLeft(2, '0')}-${lastAirDate!.day.toString().padLeft(2, '0')}",
    "name": name,
    "next_episode_to_air": nextEpisodeToAir,
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "seasons": seasons == null ? [] : List<dynamic>.from(seasons!.map((x) => TvSeasonResponse.fromEntity(x).toJson())),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class TvGenreResponse extends TvGenre {
  const TvGenreResponse({required super.id, required super.name});

  factory TvGenreResponse.fromJson(Map<String, dynamic> json) =>
      TvGenreResponse(id: json["id"], name: json["name"]);

  factory TvGenreResponse.fromEntity(TvGenre entity) =>
      TvGenreResponse(id: entity.id, name: entity.name);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class TvSeasonResponse extends TvSeason {
  const TvSeasonResponse({
    super.airDate,
    super.episodeCount,
    super.id,
    super.name,
    super.overview,
    super.posterPath,
    super.seasonNumber,
    super.voteAverage,
  });

  factory TvSeasonResponse.fromJson(Map<String, dynamic> json) => TvSeasonResponse(
    airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
    episodeCount: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    voteAverage: json["vote_average"]?.toDouble(),
  );

  factory TvSeasonResponse.fromEntity(TvSeason entity) => TvSeasonResponse(
    airDate: entity.airDate,
    episodeCount: entity.episodeCount,
    id: entity.id,
    name: entity.name,
    overview: entity.overview,
    posterPath: entity.posterPath,
    seasonNumber: entity.seasonNumber,
    voteAverage: entity.voteAverage,
  );

  Map<String, dynamic> toJson() => {
    "air_date":
        "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber,
    "vote_average": voteAverage,
  };
}
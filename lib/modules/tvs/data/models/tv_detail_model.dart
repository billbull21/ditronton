import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv_detail.dart';

class TvDetailResponse extends TvDetail {
  const TvDetailResponse({
    super.adult,
    super.backdropPath,
    super.createdBy,
    super.episodeRunTime,
    super.firstAirDate,
    super.genres,
    super.homepage,
    super.id,
    super.inProduction,
    super.languages,
    super.lastAirDate,
    super.lastEpisodeToAir,
    super.name,
    super.nextEpisodeToAir,
    super.networks,
    super.numberOfEpisodes,
    super.numberOfSeasons,
    super.originCountry,
    super.originalLanguage,
    super.originalName,
    super.overview,
    super.popularity,
    super.posterPath,
    super.productionCompanies,
    super.productionCountries,
    super.seasons,
    super.spokenLanguages,
    super.status,
    super.tagline,
    super.type,
    super.voteAverage,
    super.voteCount,
  });

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) => TvDetailResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    createdBy: json["created_by"] == null
        ? []
        : List<TvCreatedBy>.from(json["created_by"]!.map((x) => TvCreatedByResponse.fromJson(x))),
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
    lastEpisodeToAir: json["last_episode_to_air"] == null
        ? null
        : TvLastEpisodeToAirResponse.fromJson(json["last_episode_to_air"]),
    name: json["name"],
    nextEpisodeToAir: json["next_episode_to_air"],
    networks: json["networks"] == null
        ? []
        : List<TvNetwork>.from(json["networks"]!.map((x) => TvNetworkResponse.fromJson(x))),
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
    productionCompanies: json["production_companies"] == null
        ? []
        : List<TvNetwork>.from(
            json["production_companies"]!.map((x) => TvNetworkResponse.fromJson(x)),
          ),
    productionCountries: json["production_countries"] == null
        ? []
        : List<TvProductionCountry>.from(
            json["production_countries"]!.map((x) => TvProductionCountryResponse.fromJson(x)),
          ),
    seasons: json["seasons"] == null
        ? []
        : List<TvSeason>.from(json["seasons"]!.map((x) => TvSeasonResponse.fromJson(x))),
    spokenLanguages: json["spoken_languages"] == null
        ? []
        : List<TvSpokenLanguage>.from(
            json["spoken_languages"]!.map((x) => TvSpokenLanguageResponse.fromJson(x)),
          ),
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
    createdBy: entity.createdBy == null
        ? []
        : List<TvCreatedBy>.from(
            entity.createdBy!.map((x) => TvCreatedByResponse.fromEntity(x)),
          ),
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
    lastEpisodeToAir: entity.lastEpisodeToAir == null
        ? null
        : TvLastEpisodeToAirResponse.fromEntity(entity.lastEpisodeToAir!),
    name: entity.name,
    nextEpisodeToAir: entity.nextEpisodeToAir,
    networks: entity.networks == null
        ? []
        : List<TvNetwork>.from(entity.networks!.map((x) => TvNetworkResponse.fromEntity(x))),
    numberOfEpisodes: entity.numberOfEpisodes,
    numberOfSeasons: entity.numberOfSeasons,
    originCountry: entity.originCountry,
    originalLanguage: entity.originalLanguage,
    originalName: entity.originalName,
    overview: entity.overview,
    popularity: entity.popularity,
    posterPath: entity.posterPath,
    productionCompanies: entity.productionCompanies == null
        ? []
        : List<TvNetwork>.from(
            entity.productionCompanies!.map((x) => TvNetworkResponse.fromEntity(x)),
          ),
    productionCountries: entity.productionCountries == null
        ? []
        : List<TvProductionCountry>.from(
            entity.productionCountries!.map((x) => TvProductionCountryResponse.fromEntity(x)),
          ),
    seasons: entity.seasons == null
        ? []
        : List<TvSeason>.from(entity.seasons!.map((x) => TvSeasonResponse.fromEntity(x))),
    spokenLanguages: entity.spokenLanguages == null
        ? []
        : List<TvSpokenLanguage>.from(
            entity.spokenLanguages!.map((x) => TvSpokenLanguageResponse.fromEntity(x)),
          ),
    status: entity.status,
    tagline: entity.tagline,
    type: entity.type,
    voteAverage: entity.voteAverage,
    voteCount: entity.voteCount,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "created_by": createdBy == null ? [] : List<dynamic>.from(createdBy!.map((x) => TvCreatedByResponse.fromEntity(x).toJson())),
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
    "last_episode_to_air": lastEpisodeToAir == null ? null : TvLastEpisodeToAirResponse.fromEntity(lastEpisodeToAir!) .toJson(),
    "name": name,
    "next_episode_to_air": nextEpisodeToAir,
    "networks": networks == null ? [] : List<dynamic>.from(networks!.map((x) => TvNetworkResponse.fromEntity(x).toJson())),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": productionCompanies == null
        ? []
        : List<dynamic>.from(productionCompanies!.map((x) => TvNetworkResponse.fromEntity(x).toJson())),
    "production_countries": productionCountries == null
        ? []
        : List<dynamic>.from(productionCountries!.map((x) => TvProductionCountryResponse.fromEntity(x).toJson())),
    "seasons": seasons == null ? [] : List<dynamic>.from(seasons!.map((x) => TvSeasonResponse.fromEntity(x).toJson())),
    "spoken_languages": spokenLanguages == null
        ? []
        : List<dynamic>.from(spokenLanguages!.map((x) => TvSpokenLanguageResponse.fromEntity(x).toJson())),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    createdBy,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    languages,
    lastAirDate,
    lastEpisodeToAir,
    name,
    nextEpisodeToAir,
    networks,
    numberOfEpisodes,
    numberOfSeasons,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    productionCountries,
    seasons,
    spokenLanguages,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];
}

class TvGenreResponse extends TvGenre {
  const TvGenreResponse({required super.id, required super.name});

  factory TvGenreResponse.fromJson(Map<String, dynamic> json) =>
      TvGenreResponse(id: json["id"], name: json["name"]);

  factory TvGenreResponse.fromEntity(TvGenre entity) =>
      TvGenreResponse(id: entity.id, name: entity.name);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class TvCreatedByResponse extends TvCreatedBy {
  const TvCreatedByResponse({super.id, super.creditId, super.name, super.gender, super.profilePath});

  factory TvCreatedByResponse.fromJson(Map<String, dynamic> json) => TvCreatedByResponse(
    id: json["id"],
    creditId: json["credit_id"],
    name: json["name"],
    gender: json["gender"],
    profilePath: json["profile_path"],
  );

  factory TvCreatedByResponse.fromEntity(TvCreatedBy entity) => TvCreatedByResponse(
    id: entity.id,
    creditId: entity.creditId,
    name: entity.name,
    gender: entity.gender,
    profilePath: entity.profilePath,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "credit_id": creditId,
    "name": name,
    "gender": gender,
    "profile_path": profilePath,
  };
}

class TvLastEpisodeToAirResponse extends TvLastEpisodeToAir {
  const TvLastEpisodeToAirResponse({
    super.id,
    super.name,
    super.overview,
    super.voteAverage,
    super.voteCount,
    super.airDate,
    super.episodeNumber,
    super.productionCode,
    super.runtime,
    super.seasonNumber,
    super.showId,
    super.stillPath,
  });

  factory TvLastEpisodeToAirResponse.fromJson(Map<String, dynamic> json) =>
      TvLastEpisodeToAirResponse(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
      );

  factory TvLastEpisodeToAirResponse.fromEntity(TvLastEpisodeToAir entity) =>
      TvLastEpisodeToAirResponse(
        id: entity.id,
        name: entity.name,
        overview: entity.overview,
        voteAverage: entity.voteAverage,
        voteCount: entity.voteCount,
        airDate: entity.airDate,
        episodeNumber: entity.episodeNumber,
        productionCode: entity.productionCode,
        runtime: entity.runtime,
        seasonNumber: entity.seasonNumber,
        showId: entity.showId,
        stillPath: entity.stillPath,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "overview": overview,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "air_date":
        "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
    "episode_number": episodeNumber,
    "production_code": productionCode,
    "runtime": runtime,
    "season_number": seasonNumber,
    "show_id": showId,
    "still_path": stillPath,
  };
}

class TvNetworkResponse extends TvNetwork {
  const TvNetworkResponse({super.id, super.logoPath, super.name, super.originCountry});

  factory TvNetworkResponse.fromJson(Map<String, dynamic> json) => TvNetworkResponse(
    id: json["id"],
    logoPath: json["logo_path"],
    name: json["name"],
    originCountry: json["origin_country"],
  );

  factory TvNetworkResponse.fromEntity(TvNetwork entity) => TvNetworkResponse(
    id: entity.id,
    logoPath: entity.logoPath,
    name: entity.name,
    originCountry: entity.originCountry,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath,
    "name": name,
    "origin_country": originCountry,
  };
}

class TvProductionCountryResponse extends TvProductionCountry {
  const TvProductionCountryResponse({super.iso31661, super.name});

  factory TvProductionCountryResponse.fromJson(Map<String, dynamic> json) =>
      TvProductionCountryResponse(iso31661: json["iso_3166_1"], name: json["name"]);

  factory TvProductionCountryResponse.fromEntity(TvProductionCountry entity) =>
      TvProductionCountryResponse(iso31661: entity.iso31661, name: entity.name);

  Map<String, dynamic> toJson() => {"iso_3166_1": iso31661, "name": name};
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

class TvSpokenLanguageResponse extends TvSpokenLanguage {
  const TvSpokenLanguageResponse({super.englishName, super.iso6391, super.name});

  factory TvSpokenLanguageResponse.fromJson(Map<String, dynamic> json) =>
      TvSpokenLanguageResponse(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  factory TvSpokenLanguageResponse.fromEntity(TvSpokenLanguage entity) =>
      TvSpokenLanguageResponse(
        englishName: entity.englishName,
        iso6391: entity.iso6391,
        name: entity.name,
      );

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}

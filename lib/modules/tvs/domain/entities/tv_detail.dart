import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<TvCreatedBy>? createdBy;
  final List<int>? episodeRunTime;
  final DateTime? firstAirDate;
  final List<TvGenre>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;
  final TvLastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  final List<TvNetwork>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<TvNetwork>? productionCompanies;
  final List<TvProductionCountry>? productionCountries;
  final List<TvSeason>? seasons;
  final List<TvSpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  const TvDetail({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  TvDetail copyWith({
    bool? adult,
    String? backdropPath,
    List<TvCreatedBy>? createdBy,
    List<int>? episodeRunTime,
    DateTime? firstAirDate,
    List<TvGenre>? genres,
    String? homepage,
    int? id,
    bool? inProduction,
    List<String>? languages,
    DateTime? lastAirDate,
    TvLastEpisodeToAir? lastEpisodeToAir,
    String? name,
    dynamic nextEpisodeToAir,
    List<TvNetwork>? networks,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    List<TvNetwork>? productionCompanies,
    List<TvProductionCountry>? productionCountries,
    List<TvSeason>? seasons,
    List<TvSpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? type,
    double? voteAverage,
    int? voteCount,
  }) => TvDetail(
    adult: adult ?? this.adult,
    backdropPath: backdropPath ?? this.backdropPath,
    createdBy: createdBy ?? this.createdBy,
    episodeRunTime: episodeRunTime ?? this.episodeRunTime,
    firstAirDate: firstAirDate ?? this.firstAirDate,
    genres: genres ?? this.genres,
    homepage: homepage ?? this.homepage,
    id: id ?? this.id,
    inProduction: inProduction ?? this.inProduction,
    languages: languages ?? this.languages,
    lastAirDate: lastAirDate ?? this.lastAirDate,
    lastEpisodeToAir: lastEpisodeToAir ?? this.lastEpisodeToAir,
    name: name ?? this.name,
    nextEpisodeToAir: nextEpisodeToAir ?? this.nextEpisodeToAir,
    networks: networks ?? this.networks,
    numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
    numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
    originCountry: originCountry ?? this.originCountry,
    originalLanguage: originalLanguage ?? this.originalLanguage,
    originalName: originalName ?? this.originalName,
    overview: overview ?? this.overview,
    popularity: popularity ?? this.popularity,
    posterPath: posterPath ?? this.posterPath,
    productionCompanies: productionCompanies ?? this.productionCompanies,
    productionCountries: productionCountries ?? this.productionCountries,
    seasons: seasons ?? this.seasons,
    spokenLanguages: spokenLanguages ?? this.spokenLanguages,
    status: status ?? this.status,
    tagline: tagline ?? this.tagline,
    type: type ?? this.type,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
  );

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

class TvGenre extends Equatable {
  const TvGenre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  TvGenre copyWith({
    int? id,
    String? name,
  }) => TvGenre(
    id: id ?? this.id,
    name: name ?? this.name,
  );

  @override
  List<Object> get props => [id, name];
}

class TvCreatedBy extends Equatable {
  final int? id;
  final String? creditId;
  final String? name;
  final int? gender;
  final String? profilePath;

  const TvCreatedBy({this.id, this.creditId, this.name, this.gender, this.profilePath});

  TvCreatedBy copyWith({
    int? id,
    String? creditId,
    String? name,
    int? gender,
    String? profilePath,
  }) => TvCreatedBy(
    id: id ?? this.id,
    creditId: creditId ?? this.creditId,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    profilePath: profilePath ?? this.profilePath,
  );

  @override
  List<Object?> get props => [id, creditId, name, gender, profilePath];
}

class TvLastEpisodeToAir extends Equatable {
  final int? id;
  final String? name;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final DateTime? airDate;
  final int? episodeNumber;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;

  const TvLastEpisodeToAir({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  TvLastEpisodeToAir copyWith({
    int? id,
    String? name,
    String? overview,
    double? voteAverage,
    int? voteCount,
    DateTime? airDate,
    int? episodeNumber,
    String? productionCode,
    int? runtime,
    int? seasonNumber,
    int? showId,
    String? stillPath,
  }) => TvLastEpisodeToAir(
    id: id ?? this.id,
    name: name ?? this.name,
    overview: overview ?? this.overview,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
    airDate: airDate ?? this.airDate,
    episodeNumber: episodeNumber ?? this.episodeNumber,
    productionCode: productionCode ?? this.productionCode,
    runtime: runtime ?? this.runtime,
    seasonNumber: seasonNumber ?? this.seasonNumber,
    showId: showId ?? this.showId,
    stillPath: stillPath ?? this.stillPath,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    voteAverage,
    voteCount,
    airDate,
    episodeNumber,
    productionCode,
    runtime,
    seasonNumber,
    showId,
    stillPath,
  ];
}

class TvNetwork extends Equatable {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  const TvNetwork({this.id, this.logoPath, this.name, this.originCountry});

  TvNetwork copyWith({int? id, String? logoPath, String? name, String? originCountry}) => TvNetwork(
    id: id ?? this.id,
    logoPath: logoPath ?? this.logoPath,
    name: name ?? this.name,
    originCountry: originCountry ?? this.originCountry,
  );

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}

class TvProductionCountry extends Equatable {
  final String? iso31661;
  final String? name;

  const TvProductionCountry({this.iso31661, this.name});

  TvProductionCountry copyWith({String? iso31661, String? name}) =>
      TvProductionCountry(iso31661: iso31661 ?? this.iso31661, name: name ?? this.name);

  @override
  List<Object?> get props => [iso31661, name];
}

class TvSeason extends Equatable {
  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  const TvSeason({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  TvSeason copyWith({
    DateTime? airDate,
    int? episodeCount,
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
    double? voteAverage,
  }) => TvSeason(
    airDate: airDate ?? this.airDate,
    episodeCount: episodeCount ?? this.episodeCount,
    id: id ?? this.id,
    name: name ?? this.name,
    overview: overview ?? this.overview,
    posterPath: posterPath ?? this.posterPath,
    seasonNumber: seasonNumber ?? this.seasonNumber,
    voteAverage: voteAverage ?? this.voteAverage,
  );

  @override
  List<Object?> get props => [
    airDate,
    episodeCount,
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
    voteAverage,
  ];
}

class TvSpokenLanguage extends Equatable {
  final String? englishName;
  final String? iso6391;
  final String? name;

  const TvSpokenLanguage({this.englishName, this.iso6391, this.name});

  TvSpokenLanguage copyWith({String? englishName, String? iso6391, String? name}) =>
      TvSpokenLanguage(
        englishName: englishName ?? this.englishName,
        iso6391: iso6391 ?? this.iso6391,
        name: name ?? this.name,
      );

  @override
  List<Object?> get props => [englishName, iso6391, name];
}

import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<int>? episodeRunTime;
  final DateTime? firstAirDate;
  final List<TvGenre>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;
  final String? name;
  final dynamic nextEpisodeToAir;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<TvSeason>? seasons;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  const TvDetail({
    this.adult,
    this.backdropPath,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.name,
    this.nextEpisodeToAir,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.seasons,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  TvDetail copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? episodeRunTime,
    DateTime? firstAirDate,
    List<TvGenre>? genres,
    String? homepage,
    int? id,
    bool? inProduction,
    List<String>? languages,
    DateTime? lastAirDate,
    String? name,
    dynamic nextEpisodeToAir,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    List<TvSeason>? seasons,
    String? status,
    String? tagline,
    String? type,
    double? voteAverage,
    int? voteCount,
  }) => TvDetail(
    adult: adult ?? this.adult,
    backdropPath: backdropPath ?? this.backdropPath,
    episodeRunTime: episodeRunTime ?? this.episodeRunTime,
    firstAirDate: firstAirDate ?? this.firstAirDate,
    genres: genres ?? this.genres,
    homepage: homepage ?? this.homepage,
    id: id ?? this.id,
    inProduction: inProduction ?? this.inProduction,
    languages: languages ?? this.languages,
    lastAirDate: lastAirDate ?? this.lastAirDate,
    name: name ?? this.name,
    nextEpisodeToAir: nextEpisodeToAir ?? this.nextEpisodeToAir,
    numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
    numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
    originCountry: originCountry ?? this.originCountry,
    originalLanguage: originalLanguage ?? this.originalLanguage,
    originalName: originalName ?? this.originalName,
    overview: overview ?? this.overview,
    popularity: popularity ?? this.popularity,
    posterPath: posterPath ?? this.posterPath,
    seasons: seasons ?? this.seasons,
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
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    languages,
    lastAirDate,
    name,
    nextEpisodeToAir,
    numberOfEpisodes,
    numberOfSeasons,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    seasons,
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
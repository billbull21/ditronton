import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';

class TvModel extends Tv {
  const TvModel({
    super.backdropPath,
    super.firstAirDate,
    super.genreIds,
    super.id,
    super.name,
    super.originCountry,
    super.originalLanguage,
    super.originalName,
    super.overview,
    super.popularity,
    super.posterPath,
    super.voteAverage,
    super.voteCount,
  });

  Tv get toEntity => this as Tv;

  factory TvModel.fromEntity(Tv entity) => TvModel(
        backdropPath: entity.backdropPath,
        firstAirDate: entity.firstAirDate,
        genreIds: entity.genreIds,
        id: entity.id,
        name: entity.name,
        originCountry: entity.originCountry,
        originalLanguage: entity.originalLanguage,
        originalName: entity.originalName,
        overview: entity.overview,
        popularity: entity.popularity,
        posterPath: entity.posterPath,
        voteAverage: entity.voteAverage,
        voteCount: entity.voteCount,
      );

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        name: json["name"],
        originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "name": name,
        "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };

  
}

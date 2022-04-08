import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/collection_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/production_company_vo.dart';
import 'package:movie_app/data/vos/production_countries_vo.dart';
import 'package:movie_app/data/vos/spoken_languages_vo.dart';
import 'package:movie_app/persistence/hive_constance.dart';

part 'movie_vo.g.dart';

// Serialize json data to generate code that can be used in movie app
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
class MovieVO {
  //json annotation
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
  String? backdropPath;

  @JsonKey(name: "genre_ids")
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: "id")
  @HiveField(3)
  int? id;

  @JsonKey(name: "original_language")
  @HiveField(4)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(5)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(6)
  String? overview;

  @JsonKey(name: "popularity")
  @HiveField(7)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(8)
  String? posterPath;

  @JsonKey(name: "release_date")
  @HiveField(9)
  String? releaseDate;

  @JsonKey(name: "title")
  @HiveField(10)
  String? title;

  @JsonKey(name: "video")
  @HiveField(11)
  bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(12)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(13)
  int? voteCount;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(14)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(15)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(16)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(17)
  String? homepage;

  @JsonKey(name: "imdb_id")
  @HiveField(18)
  String? imdbId;

  @JsonKey(name: "production_companies")
  @HiveField(19)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(20)
  List<ProductionCountriesVO>? productionCountries;

  @JsonKey(name: "revenue")
  @HiveField(21)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(22)
  int? runtime;

  @JsonKey(name: "spoken_languages")
  @HiveField(23)
  List<SpokenLanguagesVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(24)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(25)
  String? tagline;

  @HiveField(26)
  bool? isNowPlaying;

  @HiveField(27)
  bool? isPopular;

  @HiveField(28)
  bool? isTopRated;

  MovieVO(
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.imdbId,
    this.productionCompanies,
    this.productionCountries,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.isNowPlaying,
    this.isPopular,
    this.isTopRated,
  ); // constructor
  // type cast from json to obj type
  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  // function
  // type cast from obj type to json
  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  List<String> getGenreListAsStringList() {
    return genres?.map((genre) => genre.name ?? "").toList() ?? [];
  }

  String getGenreListAsCommaSeparatedStringList() {
    return genres?.map((genre) => genre.name ?? "").toList().join(",") ?? "";
  }

  String getProductionCountriesAsCommaSeparatedStringList() {
    return productionCountries
            ?.map((country) => country.name ?? "")
            .toList()
            .join(",") ??
        "";
  }

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount, belongsToCollection: $belongsToCollection, budget: $budget, genres: $genres, homepage: $homepage, imdbId: $imdbId, productionCompanies: $productionCompanies, productionCountries: $productionCountries, revenue: $revenue, runtime: $runtime, spokenLanguages: $spokenLanguages, status: $status, tagline: $tagline, isNowPlaying: $isNowPlaying, isPopular: $isPopular, isTopRated: $isTopRated}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

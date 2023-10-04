class TrendingResponseModel {
  final int page;
  final List<TrendingItemModel> results;
  final int totalPages;
  final int totalResults;

  TrendingResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingResponseModel.fromJson(Map<String, dynamic> json) =>
      TrendingResponseModel(
        page: json["page"],
        results: List<TrendingItemModel>.from(json["results"].map((x) {
          final mediaType = x['media_type'];
          switch (mediaType) {
            case "movie":
              return TrendingMovieModel.fromJson(x);
            case "tv":
              return TrendingMovieModel.fromJson(x);
            case "person":
              return TrendingPeopleModel.fromJson(x);
            default:
              throw Exception("Unknown media type: $mediaType");
          }
        })),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class TrendingItemModel {
  final bool adult;
  final int id;
  final String title;
  final String originalTitle;
  final String mediaType;
  final double popularity;

  TrendingItemModel({
    required this.adult,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.mediaType,
    required this.popularity,
  });

  factory TrendingItemModel.fromJson(Map<String, dynamic> json) =>
      TrendingItemModel(
        adult: json["adult"],
        id: json["id"],
        title: json["media_type"] == "movie" ? json["title"] : json["name"],
        originalTitle: json["media_type"] == "movie"
            ? json["original_title"]
            : json["original_name"],
        mediaType: json["media_type"],
        popularity: json["popularity"]?.toDouble(),
      );
}

class TrendingMovieModel extends TrendingItemModel {
  final String? backdropPath;
  final String originalLanguage;
  final String overview;
  final String? posterPath;
  final List<int> genreIds;
  final DateTime releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  TrendingMovieModel({
    required bool adult,
    required int id,
    required String title,
    required String originalTitle,
    required String mediaType,
    required double popularity,
    required this.backdropPath,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.genreIds,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
          adult: adult,
          id: id,
          title: title,
          originalTitle: originalTitle,
          mediaType: mediaType,
          popularity: popularity,
        );

  factory TrendingMovieModel.fromJson(Map<String, dynamic> json) =>
      TrendingMovieModel(
        adult: json["adult"],
        id: json["id"],
        title: json["media_type"] == "movie" ? json["title"] : json["name"],
        originalTitle: json["media_type"] == "movie"
            ? json["original_title"]
            : json["original_name"],
        mediaType: json["media_type"],
        popularity: json["popularity"]?.toDouble(),
        backdropPath: json["backdrop_path"] ?? "",
        originalLanguage: json["original_language"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? "",
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        releaseDate: json["media_type"] == "movie"
            ? DateTime.parse(json["release_date"])
            : DateTime.parse(json["first_air_date"]),
        video: json["media_type"] == "movie" ? json["video"] : false,
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}

class TrendingPeopleModel extends TrendingItemModel {
  final int gender;
  final String knownForDepartment;
  final String profilePath;
  final List<TrendingMovieModel> knownFor;

  TrendingPeopleModel({
    required bool adult,
    required int id,
    required String title,
    required String originalTitle,
    required String mediaType,
    required double popularity,
    required this.gender,
    required this.knownForDepartment,
    required this.profilePath,
    required this.knownFor,
  }) : super(
          adult: adult,
          id: id,
          title: title,
          originalTitle: originalTitle,
          mediaType: mediaType,
          popularity: popularity,
        );

  factory TrendingPeopleModel.fromJson(Map<String, dynamic> json) =>
      TrendingPeopleModel(
        adult: json["adult"],
        id: json["id"],
        title: json["name"],
        originalTitle: json["original_name"],
        mediaType: json["media_type"],
        popularity: json["popularity"]?.toDouble(),
        gender: json["gender"],
        knownForDepartment: json["known_for_department"],
        profilePath: json["profile_path"],
        knownFor: List<TrendingMovieModel>.from(
          json["known_for"].map((x) => TrendingMovieModel.fromJson(x)),
        ),
      );
}

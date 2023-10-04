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
        results: List<TrendingItemModel>.from(
            json["results"].map((x) => TrendingItemModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class TrendingItemModel {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String? posterPath; //bisa null ?
  final String mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime releaseDate;
  final bool? video;
  final double voteAverage;
  final int voteCount;

  TrendingItemModel({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TrendingItemModel.fromJson(Map<String, dynamic> json) =>
      TrendingItemModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? "",
        id: json["id"],
        title: json["media_type"] == "movie" ? json["title"] : json["name"],
        originalLanguage: json["original_language"],
        originalTitle: json["media_type"] == "movie"
            ? json["original_title"]
            : json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? "",
        mediaType: json["media_type"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        releaseDate: json["media_type"] == "movie"
            ? DateTime.parse(json["release_date"])
            : DateTime.parse(json["first_air_date"]),
        video: json["media_type"] == "movie" ? json["video"] : "",
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}

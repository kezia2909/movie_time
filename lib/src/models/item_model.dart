class ItemModel {
  int? _page;
  int? _totalResults;
  int? _totalPages;
  List<_ResultModel>? _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    List<_ResultModel> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _ResultModel result = _ResultModel.fromJson(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_ResultModel>? get results => _results;

  get length => null;
}

class _ResultModel {
  int? _id;
  String? _title;
  bool? _adult;
  String? _backdropPath;
  List<int>? _genreIds;
  String? _originalLanguage;
  String? _originalTitle;
  String? _overview;
  double? _popularity;
  String? _posterPath;
  String? _releaseDate;
  bool? _video;
  double? _voteAverage;
  double? _voteCount;

  _ResultModel.fromJson(Map<String, dynamic> result) {
    _id = result['id'];
    _title = result['title'];
    _adult = result['adult'] ? false : result['adult'];
    _backdropPath = result['backdrop_path'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genreIds!.add(result['genre_ids'][i]);
    }
    _originalLanguage = result['original_language'];
    _originalTitle = result['original_title'];
    _overview = result['overview'];
    _popularity = result['popularity'];
    _posterPath = result['poster_path'];
    _releaseDate = result['release_date'];
    _video = result['video'];
    _voteAverage = result['_vote_average'];
    _voteCount = result['_vote_count'];
  }

  String? get posterPath => _posterPath;
}

class ItemModel {
  int? _totalPages;
  int? _page;
  int? _totalResults;
  List<_ResultModel> _results = [];

  List<_ResultModel> get results => _results;

  ItemModel(
      {required totalPages,
      required page,
      required totalResults,
      required results}) {
    this._totalPages = totalPages;
    this._totalResults = totalResults;
    this._page = page;
    this._results = results;
  }

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    _totalPages = parsedJson['total_pages'];
    _totalResults = parsedJson['total_results'];
    _page = parsedJson['page'];
    if (parsedJson['results'] != null) {
      _results = <_ResultModel>[];
      (parsedJson['results'] as List).forEach(
        (element) {
          _results.add(_ResultModel.fromJson(element));
        },
      );
    }
    // List<_ResultModel> temp = [];
    // for (int i = 0; i < parsedJson['results'].length; i++) {
    //   _ResultModel result = _ResultModel.fromJson(parsedJson['results'][i]);
    //   temp.add(result);
    // }
    // _results = temp;
  }
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
    if (result['genre_ids'] != null) {
      _genreIds = <int>[];
      (result['genre_ids'] as List).forEach(
        (element) {
          _genreIds?.add(element);
        },
      );
    }
    // for (int i = 0; i < result['genre_ids'].length; i++) {
    //   _genreIds!.add(result['genre_ids'][i]);
    // }
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

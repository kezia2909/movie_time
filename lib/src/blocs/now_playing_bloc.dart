import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingMovieBloc {
  final _repository = Repository();
  final _subjectResponse = BehaviorSubject<MovieResponseModel>();
  final _subject = BehaviorSubject<List<MovieModel>>();
  int _currentPage = 108;
  bool _loading = false;
  List<MovieModel> _movieList = [];
  bool _isGetAll = false;

  BehaviorSubject<MovieResponseModel> get subjectResponse => _subjectResponse;
  BehaviorSubject<List<MovieModel>> get subject => _subject;

  getMovieList() async {
    MovieResponseModel response = await _repository.getNowPlayingMovieList();
    _subjectResponse.sink.add(response);
  }

  Future<void> getMovies() async {
    print("GETTIN MOVIES");
    if (_loading || _isGetAll) return;
    _loading = true;

    print("TRY GETTIN MOVIES");

    try {
      final response =
          await _repository.getNowPlayingMovieList(page: _currentPage);
      if (response != null && response.results.isNotEmpty) {
        _movieList.addAll(response.results);
        _subject.sink.add(_movieList);

        if (_currentPage < response.totalPages) {
          _currentPage++;
          print("NEW MOVIES");
        } else {
          _isGetAll = true;
          print("ALL MOVIES");
        }
      }
    } catch (e) {
      // Handle error
    } finally {
      _loading = false;
    }
  }

  dispose() {
    _subject.close();
  }
}

final nowPlayingMovieBloc = NowPlayingMovieBloc();

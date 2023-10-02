import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PopularMovieBloc {
  final _repository = Repository();
  final _subject = BehaviorSubject<MovieResponseModel>();

  BehaviorSubject<MovieResponseModel> get subject => _subject;

  getMovieList() async {
    MovieResponseModel response = await _repository.getPopularMovieList();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }
}

final popularMovieBloc = PopularMovieBloc();

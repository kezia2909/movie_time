import 'package:movie_time/src/models/item_model.dart';
import 'package:movie_time/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final _repository = Repository();
  final _movieFetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get movieList => _movieFetcher.stream;

  getMovieList() async {
    ItemModel itemModel = await _repository.getMovieList();
    _movieFetcher.sink.add(itemModel);
  }

  dispose() {
    _movieFetcher.close();
  }
}

final bloc = MovieBloc();

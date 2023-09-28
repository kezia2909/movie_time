import 'package:movie_time/src/models/item_model.dart';
import 'package:movie_time/src/resources/movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> getMovieList() => movieApiProvider.getMovieList();
}

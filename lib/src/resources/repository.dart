import 'package:movie_time/src/models/item_model.dart';
import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/src/models/trending_model.dart';
import 'package:movie_time/src/resources/movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<MovieResponseModel> getNowPlayingMovieList({int page = 1}) =>
      movieApiProvider.getNowPlayingMovieList(page: page);

  Future<MovieResponseModel> getPopularMovieList({int page = 1}) =>
      movieApiProvider.getPopularMovieList(page: page);

  Future<MovieResponseModel> getTopRatedMovieList({int page = 1}) =>
      movieApiProvider.getTopRatedMovieList(page: page);

  Future<MovieResponseModel> getUpcomingMovieList({int page = 1}) =>
      movieApiProvider.getUpcomingMovieList(page: page);

  Future<TrendingResponseModel> getTrendingMovieDayList({int page = 1}) =>
      movieApiProvider.getTrendingMovieDayList(page: page);

  Future<TrendingResponseModel> getTrendingTvShowDayList({int page = 1}) =>
      movieApiProvider.getTrendingTvShowDayList(page: page);
}

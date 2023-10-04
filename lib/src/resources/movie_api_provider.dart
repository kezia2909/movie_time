import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_time/src/models/item_model.dart';
import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/src/models/trending_model.dart';
import 'package:movie_time/utils/app_constants.dart';

class MovieApiProvider {
  http.Client client = http.Client();
  final _apiKey = '3e084440911f616e867d980591999b12';
  static String baseUrl = "https://api.themoviedb.org/3";
  String getPopularMovieUrl = "$baseUrl/movie/popular";
  String getNowPlayingMovieUrl = "$baseUrl/movie/now_playing";
  String getTopRatedMovieUrl = "$baseUrl/movie/top_rated";
  String getUpcomingMovieUrl = "$baseUrl/movie/upcoming";
  String getTrendingMovieDayUrl = "$baseUrl/trending/movie/day";
  String getTrendingTvShowDayUrl = "$baseUrl/trending/tv/day";
  String getTrendingPeopleDayUrl = "$baseUrl/trending/person/day";

  Future<MovieResponseModel> getPopularMovieList({int page = 1}) async {
    final queryParameters = {
      'api_key': _apiKey,
      'page': '$page',
    };

    final url =
        Uri.parse(getPopularMovieUrl).replace(queryParameters: queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get popular movie list : ${response.body}');
    }
  }

  Future<MovieResponseModel> getNowPlayingMovieList({int page = 1}) async {
    final queryParameters = {
      'api_key': _apiKey,
      'page': '$page',
    };

    final url = Uri.parse(getNowPlayingMovieUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to get now playing movie list : ${response.body}');
    }
  }

  Future<MovieResponseModel> getTopRatedMovieList({int page = 1}) async {
    final queryParameters = {
      'api_key': _apiKey,
      'page': '$page',
    };

    final url = Uri.parse(getTopRatedMovieUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get top rated movie list : ${response.body}');
    }
  }

  Future<MovieResponseModel> getUpcomingMovieList({int page = 1}) async {
    final queryParameters = {
      'api_key': _apiKey,
      'page': '$page',
    };

    final url = Uri.parse(getUpcomingMovieUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get upcoming movie list : ${response.body}');
    }
  }

  Future<TrendingResponseModel> getTrendingMovieDayList({int page = 1}) async {
    final queryParameters = {
      'api_key': _apiKey,
      'page': '$page',
    };

    final url = Uri.parse(getTrendingMovieDayUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return TrendingResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to get trending movie day list : ${response.body}');
    }
  }

  Future<TrendingResponseModel> getTrendingTvShowDayList({int page = 1}) async {
    final queryParameters = {
      'api_key': _apiKey,
      'page': '$page',
    };

    final url = Uri.parse(getTrendingTvShowDayUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return TrendingResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to get trending tv show day list : ${response.body}');
    }
  }

  Future<TrendingResponseModel> getTrendingPeopleDayList({int page = 1}) async {
    final queryParameters = {
      'api_key': _apiKey,
      'page': '$page',
    };

    final url = Uri.parse(getTrendingPeopleDayUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return TrendingResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to get trending people day list : ${response.body}');
    }
  }
}

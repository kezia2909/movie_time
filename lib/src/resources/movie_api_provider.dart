import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_time/src/models/item_model.dart';

class MovieApiProvider {
  http.Client client = http.Client();
  final _apiKey = '3e084440911f616e867d980591999b12';

  Future<ItemModel> getMovieList() async {
    final response = await client.get(Uri.parse(
        "http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey"));

    if (response.statusCode == 200) {
      return ItemModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get movie list');
    }
  }
}

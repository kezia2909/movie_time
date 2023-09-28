import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/movie_bloc.dart';
import 'package:movie_time/src/models/item_model.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    bloc.getMovieList();
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.movieList,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.results!.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Image.network(
                  'https://image.tmdb.org/t/p/w185${snapshot.data!.results![index].posterPath}',
                  fit: BoxFit.cover,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

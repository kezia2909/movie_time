import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/popular_bloc.dart';
import 'package:movie_time/src/models/movie_model.dart';

class PopularMoviesWidget extends StatefulWidget {
  const PopularMoviesWidget({super.key});

  @override
  State<PopularMoviesWidget> createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popularMovieBloc.getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponseModel>(
      stream: popularMovieBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponseModel> snapshot) {
        if (snapshot.hasData) {
          List<MovieModel> movies = snapshot.data!.results;
          if (movies.length == 0) {
            return Text("No Movies");
          } else {
            return Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(movies[index].originalTitle),
                  );
                },
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

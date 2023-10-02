import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/now_playing_bloc.dart';
import 'package:movie_time/src/models/movie_model.dart';

class NowPlayingMoviesWidget extends StatefulWidget {
  const NowPlayingMoviesWidget({super.key});

  @override
  State<NowPlayingMoviesWidget> createState() => _NowPlayingMoviesWidgetState();
}

class _NowPlayingMoviesWidgetState extends State<NowPlayingMoviesWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowPlayingMovieBloc.getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponseModel>(
      stream: nowPlayingMovieBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponseModel> snapshot) {
        if (snapshot.hasData) {
          List<MovieModel> movies = snapshot.data!.results;
          if (movies.length == 0) {
            return Text("No Movies");
          } else {
            return Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
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

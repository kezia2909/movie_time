import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/now_playing_bloc.dart';
import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/utils/app_colors.dart';
import 'package:movie_time/utils/app_constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_time/widgets/movie_with_rate_widget.dart';

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
      stream: nowPlayingMovieBloc.subjectResponse.stream,
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
                itemCount: movies.take(10).length,
                itemBuilder: (context, index) {
                  String imageUrl =
                      AppConstants.imageBaseUrlOri + movies[index].posterPath!;
                  String title = movies[index].title;
                  double voteAverage = movies[index].voteAverage;
                  return MovieWithRate(
                      index: index,
                      imageUrl: imageUrl,
                      title: title,
                      voteAverage: voteAverage);
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

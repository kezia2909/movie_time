import 'package:flutter/material.dart';
import 'package:movie_time/widgets/now_playing_movies_widget.dart';
import 'package:movie_time/widgets/popular_movies_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Movies"),
        PopularMoviesWidget(),
        Text("Now Playing : "),
        NowPlayingMoviesWidget(),
        Text("Top Rated : "),
        NowPlayingMoviesWidget(),
      ],
    );
  }
}

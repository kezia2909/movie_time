import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/now_playing_bloc.dart';
import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/utils/app_colors.dart';
import 'package:movie_time/utils/app_constants.dart';
import 'package:movie_time/widgets/movie_with_rate_widget.dart';

class NowPlayingMoviePage extends StatefulWidget {
  const NowPlayingMoviePage({super.key});

  @override
  State<NowPlayingMoviePage> createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowPlayingMovieBloc.getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor(colorShadow),
        foregroundColor: appColor(colorAccent),
        title: Text("NOW PLAYING"),
        titleTextStyle: TextStyle(
            color: appColor(colorWhite),
            fontWeight: FontWeight.bold,
            fontSize: 22),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: appColor(colorAccent),
            ),
            onPressed: () => (),
          )
        ],
      ),
      body: StreamBuilder<MovieResponseModel>(
        stream: nowPlayingMovieBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponseModel> snapshot) {
          if (snapshot.hasData) {
            List<MovieModel> movies = snapshot.data!.results;
            if (movies.length == 0) {
              return Text("No Movies");
            } else {
              return Container(
                color: appColor(colorBlack),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 10.0, // Vertical spacing
                      crossAxisSpacing: 10.0, // Horizontal spacing
                      childAspectRatio: 3 / 4),
                  itemCount: movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    final movie = movies[index];
                    return Container(
                      padding: EdgeInsets.only(
                        left: index % 2 == 0
                            ? 10.0
                            : 0.0, // Add left padding for even-indexed items
                        right: index % 2 != 0
                            ? 10.0
                            : 0.0, // Add right padding for odd-indexed items
                        top: index == 0 || index == 1
                            ? 10.0
                            : 0.0, // Add top padding for the first row
                        bottom: index == movies.length - 1 ||
                                index == movies.length - 2
                            ? 10.0
                            : 0.0, // Add bottom padding for the last row
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    appColor(colorBlack, opacity: 0.8),
                                    appColor(colorBlack, opacity: 0.0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: appColor(colorHighlight, opacity: 0.4),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 5), // Add padding for spacing
                              child: Text(
                                movie.title,
                                style: TextStyle(
                                    color: appColor(colorWhite), fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
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
      ),
    );
  }
}

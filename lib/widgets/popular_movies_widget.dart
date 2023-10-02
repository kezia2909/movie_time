import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/popular_bloc.dart';
import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/utils/app_colors.dart';
import 'package:movie_time/utils/app_constants.dart';
import 'package:page_indicator/page_indicator.dart';

class PopularMoviesWidget extends StatefulWidget {
  const PopularMoviesWidget({super.key});

  @override
  State<PopularMoviesWidget> createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget> {
  late PageController controller;
  int counter = 0;
  GlobalKey<PageContainerState> key = GlobalKey();

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
              child: PageIndicatorContainer(
                align: IndicatorAlign.bottom,
                indicatorColor: appColor(colorWhite),
                indicatorSelectorColor: appColor(colorAccent),
                shape:
                    IndicatorShape.roundRectangleShape(size: Size(10.0, 5.0)),
                length: movies.take(5).length,
                child: PageView.builder(
                  itemCount: movies.take(5).length,
                  itemBuilder: (context, index) {
                    String imageUrl = AppConstants.imageBaseUrlOri +
                        movies[index].backdropPath!;
                    return Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(imageUrl), fit: BoxFit.cover),
                        ),
                        alignment: Alignment.bottomLeft,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.black.withOpacity(0.0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                      ),
                      Positioned(
                        bottom: 20.0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "(${movies[index].releaseDate.year.toString()})",
                                style: TextStyle(color: appColor(colorWhite)),
                              ),
                              Text(
                                movies[index].originalTitle,
                                style: TextStyle(color: appColor(colorWhite)),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      )
                    ]);
                  },
                ),
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

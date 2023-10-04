import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/popular_bloc.dart';
import 'package:movie_time/src/blocs/trending_movie_day_bloc.dart';
import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/src/models/trending_model.dart';
import 'package:movie_time/utils/app_colors.dart';
import 'package:movie_time/utils/app_constants.dart';

class TrendingMovieWidget extends StatefulWidget {
  const TrendingMovieWidget({super.key});

  @override
  State<TrendingMovieWidget> createState() => _TrendingMovieWidgetState();
}

class _TrendingMovieWidgetState extends State<TrendingMovieWidget> {
  int _currentIndex = 0;
  CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingMovieDayBloc.getTrendingList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor(colorBlack),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<TrendingResponseModel>(
        stream: trendingMovieDayBloc.subject.stream,
        builder: (context, AsyncSnapshot<TrendingResponseModel> snapshot) {
          if (snapshot.hasData) {
            List<TrendingItemModel> movies = snapshot.data!.results;
            if (movies.length == 0) {
              return Text("No Movies");
            } else {
              String currentImageUrl = AppConstants.imageBaseUrlOri +
                  movies[_currentIndex].posterPath!;
              return Stack(
                children: [
                  Image.network(
                    currentImageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            appColor(colorWhite, opacity: 1),
                            appColor(colorWhite, opacity: 0.2),
                            appColor(colorWhite, opacity: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // bottom: MediaQuery.of(context).size.height * 0.05,
                    bottom: 50,
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          // height: 500,
                          height: MediaQuery.of(context).size.height * 0.5,
                          aspectRatio: 3 / 2,
                          viewportFraction: 0.7,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: movies.map((movie) {
                          String imageUrl = AppConstants.imageBaseUrlOri +
                              movie.backdropPath!;
                          String checkPath =
                              AppConstants.imageBaseUrlOri + movie.posterPath!;
                          String title = movie.title;
                          String overview = movie.overview;

                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.all(15),
                                height: MediaQuery.of(context).size.height *
                                    0.5, // width: ,
                                decoration: BoxDecoration(
                                  color: appColor(colorWhite),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(children: [
                                  Expanded(
                                    child: Container(
                                      // margin: EdgeInsets.all(20),
                                      clipBehavior: Clip.hardEdge,
                                      // height:
                                      //     MediaQuery.of(context).size.height *
                                      //         0.35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  (checkPath == currentImageUrl)
                                      ? Column(
                                          children: [
                                            Text(
                                              title,
                                              style: TextStyle(
                                                  color: appColor(colorBlack),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              overview,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: appColor(colorBlack),
                                                  fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 7,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ]),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
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

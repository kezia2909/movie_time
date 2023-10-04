import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/trending_people_day_bloc.dart';
import 'package:movie_time/src/models/trending_model.dart';
import 'package:movie_time/utils/app_colors.dart';
import 'package:movie_time/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class TrendingPeopleWidget extends StatefulWidget {
  const TrendingPeopleWidget({super.key});

  @override
  State<TrendingPeopleWidget> createState() => _TrendingPeopleWidgetState();
}

class _TrendingPeopleWidgetState extends State<TrendingPeopleWidget> {
  CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor(colorBlack),
      child: StreamBuilder<TrendingResponseModel>(
        stream: trendingPeopleDayBloc.subject.stream,
        builder: (context, AsyncSnapshot<TrendingResponseModel> snapshot) {
          if (snapshot.hasData) {
            List<TrendingPeopleModel> peoples = snapshot.data!.results
                .whereType<TrendingPeopleModel>()
                .toList();
            if (peoples.length == 0) {
              return Text("No Peoples");
            } else {
              String currentImageUrl = AppConstants.imageBaseUrlOri +
                  peoples[_currentIndex].profilePath!;
              String defaultImage = "assets/images/man.png";
              if (peoples[_currentIndex].gender == 1) {
                defaultImage = "assets/images/woman.png";
              }
              return Stack(
                children: [
                  Positioned(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            // Colors.transparent,
                            Colors.white.withOpacity(1), // Adjust opacity here
                            Colors.white.withOpacity(1), // Adjust opacity here
                            Colors.white.withOpacity(1), // Adjust opacity here
                            Colors.white.withOpacity(1), // Adjust opacity here
                            Colors.white
                                .withOpacity(0.2), // Adjust opacity here
                          ],
                        ).createShader(bounds);
                      },
                      child: FutureBuilder(
                        future: loadImage(currentImageUrl),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If the network image was loaded successfully, display it
                            if (snapshot.data == true) {
                              print("img error: ${snapshot.error}");
                              return Image.network(
                                currentImageUrl,
                                fit: BoxFit.cover,
                              );
                            } else {
                              // If the network image failed to load, display the asset image
                              return Image.asset(
                                defaultImage,
                                fit: BoxFit.contain,
                              );
                            }
                          } else {
                            // While loading the image, you can display a loading indicator or placeholder
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            appColor(colorBlack, opacity: 1),
                            // appColor(colorBlack, opacity: 0.2),
                            appColor(colorBlack, opacity: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        // height: 500,

                        // height: MediaQuery.of(context).size.height * 0.5,
                        aspectRatio: 3 / 2,
                        viewportFraction: 0.7,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: peoples.map((people) {
                        return Builder(builder: (BuildContext context) {
                          List<TrendingMovieModel> movies = people.knownFor
                              .whereType<TrendingMovieModel>()
                              .where((movie) => movie.mediaType == "movie")
                              .toList();

                          List<TrendingMovieModel> tvShows = people.knownFor
                              .whereType<TrendingMovieModel>()
                              .where((movie) => movie.mediaType == "tv")
                              .toList();
                          String movie = "-";
                          String tvShow = "-";
                          if (movies.length > 0) {
                            movie = movies[0].originalTitle;
                          }
                          if (tvShows.length > 0) {
                            tvShow = tvShows[0].originalTitle;
                          }
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: appColor(colorWhite),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  people.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  people.knownForDepartment.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          appColor(colorBlack, opacity: 0.6)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                movies.length > 0
                                    ? Text("MOVIES :",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: appColor(colorBlack)))
                                    : Text("MOVIES : -",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: appColor(colorBlack))),
                                movies.length > 0
                                    ? Expanded(
                                        child: ListView.builder(
                                          itemCount: movies.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: Text(
                                                "- ${movies[index].title}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        appColor(colorBlack)),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 8,
                                ),
                                tvShows.length > 0
                                    ? Text("TV SHOWS :",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: appColor(colorBlack)))
                                    : Text("TV SHOWS : -",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: appColor(colorBlack))),
                                tvShows.length > 0
                                    ? Expanded(
                                        child: ListView.builder(
                                          itemCount: tvShows.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: Text(
                                                "- ${tvShows[index].title}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        appColor(colorBlack)),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        });
                      }).toList(),
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

Future<bool> loadImage(String imageUrl) async {
  try {
    // You can use any image loading technique here, such as CachedNetworkImage
    // or fetching the image using http package.
    // Here, we are simply checking if the URL is reachable.
    final response = await http.head(Uri.parse(imageUrl));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

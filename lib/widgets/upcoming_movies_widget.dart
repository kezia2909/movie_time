import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/upcoming_bloc.dart';
import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/utils/app_colors.dart';
import 'package:movie_time/utils/app_constants.dart';

class UpcomingMoviesWidget extends StatefulWidget {
  const UpcomingMoviesWidget({super.key});

  @override
  State<UpcomingMoviesWidget> createState() => _UpcomingMoviesWidgetState();
}

class _UpcomingMoviesWidgetState extends State<UpcomingMoviesWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upcomingMovieBloc.getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponseModel>(
      stream: upcomingMovieBloc.subject.stream,
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
                  String imageUrl =
                      AppConstants.imageBaseUrlOri + movies[index].posterPath!;
                  String title = movies[index].title;
                  DateTime releaseDate = movies[index].releaseDate;
                  return Container(
                    width: MediaQuery.of(context).size.width / 3,
                    margin: index == 0
                        ? EdgeInsets.only(right: 5.0)
                        : EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              color: appColor(colorWhite), fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatDate(releaseDate),
                              style: TextStyle(
                                  color: appColor(colorWhite), fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              formatDateSuffix(releaseDate.day),
                              style: TextStyle(
                                  color: appColor(colorWhite), fontSize: 6),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
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
    );
  }

  String formatDate(DateTime date) {
    final String month = _getMonthAbbreviation(date.month);
    final String day = date.day.toString();

    return '$month $day';
  }

  String _getMonthAbbreviation(int month) {
    final List<String> monthsAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return monthsAbbreviations[month - 1];
  }

  String formatDateSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

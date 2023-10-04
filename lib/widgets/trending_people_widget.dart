import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/trending_people_day_bloc.dart';
import 'package:movie_time/src/models/trending_model.dart';

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
    return StreamBuilder<TrendingResponseModel>(
      stream: trendingPeopleDayBloc.subject.stream,
      builder: (context, AsyncSnapshot<TrendingResponseModel> snapshot) {
        if (snapshot.hasData) {
          List<TrendingPeopleModel> peoples =
              snapshot.data!.results.whereType<TrendingPeopleModel>().toList();
          if (peoples.length == 0) {
            return Text("No Peoples");
          } else {
            return CarouselSlider(
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
              items: peoples.map((people) {
                return Builder(builder: (BuildContext context) {
                  return Text(people.title);
                });
              }).toList(),
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

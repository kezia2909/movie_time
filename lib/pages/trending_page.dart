import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/src/blocs/popular_bloc.dart';
import 'package:movie_time/src/blocs/trending_movie_day_bloc.dart';
import 'package:movie_time/src/blocs/trending_people_day_bloc.dart';
import 'package:movie_time/src/blocs/trending_tv_show_day_bloc.dart';
import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/utils/app_colors.dart';
import 'package:movie_time/utils/app_constants.dart';
import 'package:movie_time/widgets/trending_people_widget.dart';
import 'package:movie_time/widgets/trending_widget.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingMovieDayBloc.getTrendingList();
    trendingTvShowDayBloc.getTrendingList();
    trendingPeopleDayBloc.getTrendingList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: appColor(colorRed),
        appBar: AppBar(
          backgroundColor: appColor(colorShadow),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: AssetImage("assets/images/logo_tmdb.png")),
          ),
          title: Text("Movie Time"),
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
          bottom: TabBar(
            unselectedLabelColor: appColor(colorWhite, opacity: 0.8),
            labelColor: appColor(colorHighlight),
            indicatorColor: appColor(colorHighlight),
            overlayColor: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  // Set the overlay color when tab is selected
                  return appColor(
                      colorBlack); // Replace with your desired color
                }

                // Set the default color when tab is not selected
                return appColor(
                    colorBlack); // Replace with your desired default color
              },
            ),
            tabs: [
              Tab(text: 'Movie'),
              Tab(text: 'TV Show'),
              Tab(text: 'People'),
            ],
            indicator: UnderlineTabIndicator(
              borderSide:
                  BorderSide.none, // Set the indicator's border side to none
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TrendingWidget(
              isMovie: true,
            ), // Replace with your MoviePage widget
            TrendingWidget(
              isMovie: false,
            ), // Replace with your TVPage widget
            TrendingPeopleWidget(), // Replace with your PeoplePage widget
          ],
        ),
      ),
    );
  }
}

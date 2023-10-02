import 'package:flutter/material.dart';
import 'package:movie_time/utils/app_colors.dart';
import 'package:movie_time/widgets/now_playing_movies_widget.dart';
import 'package:movie_time/widgets/popular_movies_widget.dart';
import 'package:movie_time/widgets/top_rated_movies_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        color: appColor(colorBlack),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PopularMoviesWidget(),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NOW PLAYING",
                          style: TextStyle(color: appColor(colorWhite)),
                        ),
                        Text(
                          "see all",
                          style: TextStyle(
                              color: appColor(colorWhite, opacity: 0.5)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    NowPlayingMoviesWidget(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOP RATED",
                          style: TextStyle(color: appColor(colorWhite)),
                        ),
                        Text(
                          "see all",
                          style: TextStyle(
                              color: appColor(colorWhite, opacity: 0.5)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TopRatedMoviesWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

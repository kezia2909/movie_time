import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_time/utils/app_colors.dart';

class MovieWithRate extends StatefulWidget {
  final int index;
  final String imageUrl;
  final String title;
  final double voteAverage;

  const MovieWithRate(
      {super.key,
      required this.index,
      required this.imageUrl,
      required this.title,
      required this.voteAverage});

  @override
  State<MovieWithRate> createState() => _MovieWithRateState();
}

class _MovieWithRateState extends State<MovieWithRate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      margin: widget.index == 0
          ? EdgeInsets.only(right: 5.0)
          : EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(color: appColor(colorWhite), fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Row(
            children: [
              Text(
                widget.voteAverage.toString(),
                style: TextStyle(color: appColor(colorWhite), fontSize: 10),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              RatingBar(
                ignoreGestures: true,
                ratingWidget: RatingWidget(
                  empty: Icon(
                    Icons.star,
                    color: appColor(colorWhite),
                  ),
                  full: Icon(
                    Icons.star,
                    color: appColor(colorAccent),
                  ),
                  half: Icon(
                    Icons.star,
                    color: appColor(colorAccent),
                  ),
                ),
                itemSize: 10.0,
                initialRating: widget.voteAverage / 2,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                onRatingUpdate: (rating) {
                  print("rate : $rating");
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

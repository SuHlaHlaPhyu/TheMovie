import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/rating_view.dart';

class MovieView extends StatelessWidget {
  final Function onTapMovie;
  final MovieVO? movie;
  MovieView({required this.onTapMovie, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: MARGIN_MEDIUM,
      ),
      width: MOVIE_LSIT_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onTapMovie();
            },
            child: Image.network(
              "$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Expanded(
            child: Text(
              movie?.title ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: const [
              Text(
                '8.9',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              RatingView(),
            ],
          ),
        ],
      ),
    );
  }
}

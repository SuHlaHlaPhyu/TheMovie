import 'package:flutter/material.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../components/smart_list_view.dart';
import '../data/vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../viewitems/movie_view.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovies;
  final List<MovieVO>? nowPlayingMovies;
  final String label;
  final Function onListEndReach;
  const TitleAndHorizontalMovieListView({
    required this.onTapMovies,
    required this.nowPlayingMovies,
    required this.label,
    required this.onListEndReach,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2,
          ),
          child: TitleText(
            label,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          onTapMovie: (movieId) => onTapMovies(movieId),
          movieList: nowPlayingMovies,
          onListEndReach: () {
            onListEndReach();
          },
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  final Function onListEndReach;
  HorizontalMovieListView({
    required this.onTapMovie,
    required this.movieList,
    required this.onListEndReach,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? SmartHorizontalListView(
              itemCount: movieList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return MovieView(
                  onTapMovie: () {
                    onTapMovie(movieList?[index].id);
                  },
                  movie: movieList?[index],
                );
              },
              padding: const EdgeInsets.only(
                left: MARGIN_MEDIUM_2,
              ),
              onListEndReached: () {
                onListEndReach();
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

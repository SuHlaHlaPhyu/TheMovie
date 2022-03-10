import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

import '../data/models/movie_model.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier {
  /// states
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? movieByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  /// model
  MovieModel movieModel = MovieModelImpl();

  HomeBloc() {
    /// Now playing movies
    movieModel.getNowPlayingMovieFromDatabase().then((movieList) {
      nowPlayingMovies = movieList;
      notifyListeners();
    }).catchError((error) {});

    /// Popular movies
    movieModel.getPopularMoviesFromDatabase().then((movieList) {
      popularMovies = movieList;
      notifyListeners();
    }).catchError((error) {});

    /// top rated moves
    movieModel.getTopRatedMoviesFromDatabase().then((movieList) {
      topRatedMovies = movieList;
      notifyListeners();
    }).then((error) {});

    /// actor list
    movieModel.getActorsFromDatabase().then((actorList) {
      actors = actorList;
      notifyListeners();
    }).catchError((error) {});

    /// genre list
    movieModel.getGenres().then((genreList) {
      genres = genreList;
      notifyListeners();

      /// movie by genre
      getMovieByGenreAndFresh(genres?.first.id ?? 1);
    }).catchError((error) {});

    /// genre list
    movieModel.getGenresFromDatabase().then((genreList) {
      genres = genreList;
      notifyListeners();

      /// movie by genre
      getMovieByGenreAndFresh(genres?.first.id ?? 1);
      notifyListeners();
    }).catchError((error) {});
  }

  /// movie by genre
  void onTapGenre(int genreId) {
    getMovieByGenreAndFresh(genreId);
  }

  void getMovieByGenreAndFresh(int genreId) {
    movieModel.getMovieByGenre(genreId).then((movieByGenreList) {
      movieByGenre = movieByGenreList;
      notifyListeners();
    }).catchError((error) {});
  }
}

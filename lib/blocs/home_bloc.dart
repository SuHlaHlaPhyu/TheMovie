import 'dart:async';

import 'package:movie_app/data/models/movie_model_impl.dart';

import '../data/models/movie_model.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';

class HomeBloc {
  /// reactive streams
  StreamController<List<MovieVO>?> nowPlayingMoviesStreamController =
      StreamController();
  StreamController<List<MovieVO>?> popularMoviesStreamController =
      StreamController();
  StreamController<List<MovieVO>?> topRatedMoviesStreamController =
      StreamController();
  StreamController<List<MovieVO>?> movieByGenreStreamController =
      StreamController();
  StreamController<List<GenreVO>?> genresStreamController = StreamController();
  StreamController<List<ActorVO>?> actorsStreamController = StreamController();

  /// model
  MovieModel movieModel = MovieModelImpl();

  HomeBloc() {
    /// Now playing movies
    movieModel.getNowPlayingMovieFromDatabase().then((movieList) {
      nowPlayingMoviesStreamController.sink.add(movieList);
    }).catchError((error) {});

    /// Popular movies
    movieModel.getPopularMoviesFromDatabase().then((movieList) {
      popularMoviesStreamController.sink.add(movieList);
    }).catchError((error) {});

    /// top rated moves
    movieModel.getTopRatedMoviesFromDatabase().then((movieList) {
      topRatedMoviesStreamController.sink.add(movieList);
    }).then((error) {});

    /// genre list
    movieModel.getGenresFromDatabase().then((genreList) {
      genresStreamController.sink.add(genreList);
    }).catchError((error) {});

    /// actor list
    movieModel.getActorsFromDatabase().then((actorList) {
      actorsStreamController.sink.add(actorList);
    }).catchError((error) {});
  }

  /// movie by genre
  void onTapGenre(int genreId) {
    getMovieByGenreAndFresh(genreId);
  }

  void getMovieByGenreAndFresh(int genreId) {
    movieModel.getMovieByGenre(genreId).then((movieByGenre) {
      movieByGenreStreamController.sink.add(movieByGenre);
    }).catchError((error) {});
  }

  void dispose() {
    nowPlayingMoviesStreamController.close();
    popularMoviesStreamController.close();
    topRatedMoviesStreamController.close();
    movieByGenreStreamController.close();
    genresStreamController.close();
    actorsStreamController.close();
  }
}

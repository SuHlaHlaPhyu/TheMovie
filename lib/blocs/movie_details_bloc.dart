import 'dart:async';

import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailsBloc {
  /// Stream controller
  StreamController<List<ActorVO>?> castsStreamController = StreamController();
  StreamController<List<ActorVO>?> crewsStreamController = StreamController();
  StreamController<MovieVO> movieDetailStreamController = StreamController();

  /// Model
  MovieModel movieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    /// Movie details
    movieModel.getMovieDetails(movieId).then((movie) {
      movieDetailStreamController.sink.add(movie);
    }).catchError((error) {});

    /// Movie details database
    movieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      movieDetailStreamController.sink.add(movie);
    }).catchError((error) {});

    /// credit by movie
    movieModel.getCreditByMovie(movieId).then((castAndCrew) {
      castsStreamController.sink.add(castAndCrew.first);
      crewsStreamController.sink.add(castAndCrew.last);
    }).catchError((error) {});
  }

  void dispose() {
    castsStreamController.close();
    crewsStreamController.close();
    movieDetailStreamController.close();
  }
}

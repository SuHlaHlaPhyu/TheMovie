import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier {
  /// States
  List<ActorVO>? casts;
  List<ActorVO>? crews;
  MovieVO? movieDetail;
  List<MovieVO>? mRelatedMovies;

  /// Model
  MovieModel movieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId, [MovieModel? movieModelTest]) {

    /// set mock model for test
    if(movieModelTest != null){
      movieModel = movieModelTest;
    }
    /// Movie details
    movieModel.getMovieDetails(movieId).then((movie) {
      movieDetail = movie;
      getRelatedMovie(movie?.genres?.first.id ?? 0);
      notifyListeners();
    }).catchError((error) {});

    /// Movie details database
    movieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      movieDetail = movie;
      notifyListeners();
    }).catchError((error) {});

    /// credit by movie
    movieModel.getCreditByMovie(movieId).then((castAndCrew) {
      casts = castAndCrew.first;
      crews = castAndCrew.last;
      notifyListeners();
    }).catchError((error) {});
  }
  void getRelatedMovie(int genreId) {
    movieModel.getMovieByGenre(genreId).then((relatedMovie) {
      mRelatedMovies = relatedMovie;
      notifyListeners();
    });
  }
}

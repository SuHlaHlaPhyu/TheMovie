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

  /// page
  int pageForNowPlayingMovie = 1;

  /// model
  MovieModel movieModel = MovieModelImpl();

  HomeBloc([MovieModel? movieModelTest]) {
    /// set mock model for test
    if(movieModelTest != null){
      movieModel = movieModelTest;
    }
    /// Now playing movies
    movieModel.getNowPlayingMovieFromDatabase().listen((movieList) {
      nowPlayingMovies = movieList;
      // if(nowPlayingMovies?.isNotEmpty ?? false){
      //   nowPlayingMovies?.sort((a,b) => a.id! - b.id!);
      // }
      notifyListeners();
    }).onError((error) {});

    /// Popular movies
    movieModel.getPopularMoviesFromDatabase().listen((movieList) {
      popularMovies = movieList;
      notifyListeners();
    }).onError((error) {});

    /// top rated moves
    movieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      topRatedMovies = movieList;
      notifyListeners();
    }).onError((error) {});

    /// actor list
    movieModel.getActorsFromDatabase()?.then((actorList) {
      actors = actorList;
      notifyListeners();
    }).catchError((error) {});

    /// genre list
    movieModel.getGenres().then((genreList) {
      genres = genreList;
      notifyListeners();

      /// movie by genre
      getMovieByGenreAndFresh(genres?.first.id ?? 28);
    }).catchError((error) {});

    /// genre list
    movieModel.getGenresFromDatabase().then((genreList) {
      genres = genreList;
      notifyListeners();

      /// movie by genre
      getMovieByGenreAndFresh(genres?.first.id ?? 28);
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

  void onNowPlayingMovieListEndReached() {
    pageForNowPlayingMovie += 1;
    movieModel.getNowPlayingMovie(pageForNowPlayingMovie);
  }
}

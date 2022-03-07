import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

abstract class MovieModel {
  /// Network
  // Future<List<MovieVO>> getNowPlayingMovie(int page);
  // Future<List<MovieVO>> getPopularMovies(int page);
  // Future<List<MovieVO>> getTopRatedMovies(int page);
  Future<List<MovieVO>?> getMovieByGenre(int genreId);
  Future<List<GenreVO>> getGenres();
  Future<List<ActorVO>> getActors(int page);
  Future<MovieVO> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId);
  //Future<List<ActorVO>> getCreditByMovie(int movieId);

  /// Database
  Future<List<MovieVO>> getNowPlayingMovieFromDatabase();
  Future<List<MovieVO>> getPopularMoviesFromDatabase();
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase();
  Future<List<GenreVO>> getGenresFromDatabase();
  Future<List<ActorVO>> getActorsFromDatabase();
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId);

  /// Reactive programming
  void getNowPlayingMovie(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);

}

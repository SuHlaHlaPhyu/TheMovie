import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

abstract class MovieModel{
  /// Network
  Future<List<MovieVO>?> getMovieByGenre(int genreId);
  Future<List<GenreVO>?> getGenres();
  Future<List<ActorVO>?>? getActors(int page);
  Future<MovieVO?> getMovieDetails(int movieId);
  //void getCreditByMovie(int movieId);
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId);

  /// Database
  Stream<List<MovieVO>?> getNowPlayingMovieFromDatabase();
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase();
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase();
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?>? getActorsFromDatabase();
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId);

  /// Reactive programming
  void getNowPlayingMovie(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
}

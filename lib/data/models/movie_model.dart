import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class MovieModel extends Model{
  /// Network
  void getMovieByGenre(int genreId);
  void getGenres();
  void getActors(int page);
  Future<MovieVO> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId);
  //Future<List<ActorVO>> getCreditByMovie(int movieId);

  /// Database
  void getNowPlayingMovieFromDatabase();
  void getPopularMoviesFromDatabase();
  void getTopRatedMoviesFromDatabase();
  void getGenresFromDatabase();
  void getActorsFromDatabase();
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId);

  /// Reactive programming
  void getNowPlayingMovie(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);

}

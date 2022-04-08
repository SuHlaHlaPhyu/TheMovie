import 'package:movie_app/data/vos/movie_vo.dart';

abstract class MovieDao {
  void saveAllMovies(List<MovieVO> movieList);
  void saveSingleMove(MovieVO movie);
  MovieVO? getMoveById(int movieId);
  List<MovieVO> getAllMovies();
  Stream<void> getAllMovieEventStream();
  Stream<List<MovieVO>> getNowPlayingMovieStream();
  Stream<List<MovieVO>> getPopularMovieStream();
  Stream<List<MovieVO>> getTopRatedMovieStream();
  List<MovieVO> getPopularMovies();
  List<MovieVO> getTopRatedMovies();
  List<MovieVO> getNowPlayingMovies();
}
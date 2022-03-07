import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/hive_constance.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveAllMovies(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMove(MovieVO movie) async {
    return getMovieBox().put(movie.id, movie);
  }

  MovieVO? getMoveById(int movieId) {
    return getMovieBox().get(movieId);
  }

  List<MovieVO> getAllMovies() {
    // List<MovieVO> movieListFromDatabase = getMovieBox().values.toList();
    // movieListFromDatabase.forEach((element) {
    //   print(element);
    // });
    // return movieListFromDatabase;
    return getMovieBox().values.toList();
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}

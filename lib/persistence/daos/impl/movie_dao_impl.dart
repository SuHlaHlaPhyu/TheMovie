import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:movie_app/persistence/hive_constance.dart';

class MovieDaoImpl extends MovieDao{
  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() {
    return _singleton;
  }

  MovieDaoImpl._internal();

  @override
  void saveAllMovies(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  @override
  void saveSingleMove(MovieVO movie) async {
    return getMovieBox().put(movie.id, movie);
  }

  @override
  MovieVO? getMoveById(int movieId) {
    return getMovieBox().get(movieId);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

  /// reactive programming
  @override
  Stream<void> getAllMovieEventStream() {
    return getMovieBox().watch();
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMovieStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>> getPopularMovieStream() {
    return Stream.value(
        getAllMovies().where((element) => element.isPopular ?? false).toList());
  }

  @override
  Stream<List<MovieVO>> getTopRatedMovieStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }
}

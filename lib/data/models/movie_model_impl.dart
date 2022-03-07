import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  final MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();
  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  ActorDao actorDao = ActorDao();
  GenreDao genreDao = GenreDao();
  MovieDao movieDao = MovieDao();

  /// Network
  // @override
  // Future<List<MovieVO>> getNowPlayingMovie(int page) {
  //   return _dataAgent.getNowPlayingMovies(page).then((movies) async {
  //     List<MovieVO> nowPlayingMovies = movies!.map((movie) {
  //       movie.isNowPlaying = true;
  //       movie.isPopular = false;
  //       movie.isTopRated = false;
  //       return movie;
  //     }).toList();
  //     movieDao.saveAllMovies(nowPlayingMovies);
  //     return Future.value(movies);
  //   });
  // }
  //
  // @override
  // Future<List<MovieVO>> getPopularMovies(int page) {
  //   return _dataAgent.getPopularMovies(page).then((movies) async {
  //     List<MovieVO> popularMovies = movies!.map((movie) {
  //       movie.isNowPlaying = false;
  //       movie.isPopular = true;
  //       movie.isTopRated = false;
  //       return movie;
  //     }).toList();
  //     movieDao.saveAllMovies(popularMovies);
  //     return Future.value(movies);
  //   });
  // }
  //
  // @override
  // Future<List<MovieVO>> getTopRatedMovies(int page) {
  //   return _dataAgent.getTopRatedMovies(page).then((movies) async {
  //     List<MovieVO> topRatedMovies = movies!.map((movie) {
  //       movie.isNowPlaying = false;
  //       movie.isPopular = false;
  //       movie.isTopRated = true;
  //       return movie;
  //     }).toList();
  //     movieDao.saveAllMovies(topRatedMovies);
  //     return Future.value(movies);
  //   });
  // }

  @override
  Future<List<MovieVO>?> getMovieByGenre(int genreId) {
    return _dataAgent.getMovieByGenre(genreId);
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return _dataAgent.getGenres().then((genres) async {
      genreDao.saveAllGenres(genres!);
      return Future.value(genres);
    });
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return _dataAgent.getActors(page).then((actors) async {
      actorDao.saveAllActors(actors!);
      return Future.value(actors);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId) {
    return _dataAgent.getCreditByMovie(movieId);
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) {
      movieDao.saveSingleMove(movie!);
      return Future.value(movie);
    });
  }

  /// from database

  @override
  Future<List<ActorVO>> getActorsFromDatabase() {
    return Future<List<ActorVO>>.value(actorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
    return Future<List<GenreVO>>.value(genreDao.getAllGenres());
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDao.getMoveById(movieId));
  }

  @override
  Future<List<MovieVO>> getNowPlayingMovieFromDatabase() {
    getNowPlayingMovie(1);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getNowPlayingMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first;
  }

  @override
  Future<List<MovieVO>> getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getPopularMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first;
  }

  @override
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getTopRatedMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first;
  }

  /// reactive programming
  @override
  void getNowPlayingMovie(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
    });
  }

  @override
  void getPopularMovies(int page) {
    _dataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> popularMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(popularMovies);
    });
  }

  @override
  void getTopRatedMovies(int page) {
    _dataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
      movieDao.saveAllMovies(topRatedMovies);
    });
  }
}

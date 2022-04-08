import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/impl/actor_dao_impl.dart';
import 'package:movie_app/persistence/daos/impl/genre_dao_impl.dart';
import 'package:movie_app/persistence/daos/impl/movie_dao_impl.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent dataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();
  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  /// Daos
  ActorDao actorDao = ActorDaoImpl();
  GenreDao genreDao = GenreDaoImpl();
  MovieDao movieDao = MovieDaoImpl();

  /// for testing purpose
  void setDaosAndDataAgents(
    MovieDao movieDaoTest,
    ActorDao actorDaoTest,
    GenreDao genreDaoTest,
    MovieDataAgent movieDataAgentTest,
  ) {
    actorDao = actorDaoTest;
    genreDao = genreDaoTest;
    movieDao = movieDaoTest;
    dataAgent = movieDataAgentTest;
  }

  /// home page State
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? movieByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  /// movie details page state
  List<ActorVO>? casts;
  List<ActorVO>? crews;
  MovieVO? movieDetails;

  /// Network
  @override
  Future<List<MovieVO>?> getMovieByGenre(int genreId) {
    return dataAgent.getMovieByGenre(genreId).then((movieByGenreList) {
      movieByGenre = movieByGenreList;
      return Future.value(movieByGenre);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return dataAgent.getGenres().then((genreList) async {
      genreDao.saveAllGenres(genreList ?? []);
      return Future.value(genreList);
    });
  }

  @override
  Future<List<ActorVO>?>? getActors(int page) {
    return dataAgent.getActors(1).then((actorList) async {
      actorDao.saveAllActors(actorList ?? []);
      return Future.value(actorList);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId) {
    return dataAgent.getCreditByMovie(movieId).then((castAndCrews) {
      casts = castAndCrews.first;
      crews = castAndCrews.last;
      return Future.value(castAndCrews);
    });
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return dataAgent.getMovieDetails(movieId).then((movie) {
      movieDao.saveSingleMove(movie!);
      movieDetails = movie;
      return Future.value(movieDetails);
    });
  }

  /// from database
  @override
  Future<List<ActorVO>?>? getActorsFromDatabase() {
    return Future.value(actors = actorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(genres = genreDao.getAllGenres());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDetails = movieDao.getMoveById(movieId));
  }

  // @override
  // Future<List<MovieVO>> getNowPlayingMovieFromDatabase() {
  //   getNowPlayingMovie(1);
  //   return movieDao
  //       .getAllMovieEventStream()
  //       // ignore: void_checks
  //       .startWith(movieDao.getNowPlayingMovieStream())
  //       .map((event) => movieDao.getAllMovies())
  //       .first
  //       .then((nowPlayingMoviesList) {
  //     nowPlayingMovies = nowPlayingMoviesList;
  //     return Future.value(nowPlayingMovies);
  //   });
  // }
  @override
  Stream<List<MovieVO>?> getNowPlayingMovieFromDatabase() {
    getNowPlayingMovie(1);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getNowPlayingMovieStream())
        .map((event) => movieDao.getNowPlayingMovies());

  }

  // @override
  // Future<List<MovieVO>> getPopularMoviesFromDatabase() {
  //   getPopularMovies(1);
  //   return movieDao
  //       .getAllMovieEventStream()
  //       // ignore: void_checks
  //       .startWith(movieDao.getPopularMovieStream())
  //       .map((event) => movieDao.getAllMovies())
  //       .first
  //       .then((popularMoviesList) {
  //     popularMovies = popularMoviesList;
  //     return Future.value(popularMovies);
  //   });
  // }

  // @override
  // Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
  //   getPopularMovies(1);
  //   return movieDao
  //       .getAllMovieEventStream()
  //       .startWith(movieDao.getPopularMovieStream())
  //       .map((event) => movieDao.getPopularMovies());
  // }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getPopularMovieStream())
        .map((event) => movieDao.getPopularMovies());
  }

  // @override
  // Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
  //   getTopRatedMovies(1);
  //   return movieDao
  //       .getAllMovieEventStream()
  //       // ignore: void_checks
  //       .startWith(movieDao.getTopRatedMovieStream())
  //       .map((event) => movieDao.getAllMovies())
  //       .first
  //       .then((topRelatedMovies) {
  //     topRatedMovies = topRelatedMovies;
  //     return Future.value(topRelatedMovies);
  //   });
  // }
  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getTopRatedMovieStream())
        .map((event) => movieDao.getTopRatedMovies());
  }

  /// reactive programming
  @override
  void getNowPlayingMovie(int page) {
    dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMoviesList = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMoviesList);
      nowPlayingMovies = nowPlayingMoviesList;
    });
  }

  @override
  void getPopularMovies(int page) {
    dataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> popularMoviesList = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(popularMoviesList);
      popularMovies = popularMoviesList;
    });
  }

  @override
  void getTopRatedMovies(int page) {
    dataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMoviesList = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
      movieDao.saveAllMovies(topRatedMoviesList);
      topRatedMovies = topRatedMoviesList;
    });
  }
}

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

  /// Daos
  ActorDao actorDao = ActorDao();
  GenreDao genreDao = GenreDao();
  MovieDao movieDao = MovieDao();

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
  Future<List<MovieVO>> getMovieByGenre(int genreId) {
    return _dataAgent.getMovieByGenre(genreId).then((movieByGenreList) {
      movieByGenre = movieByGenreList;
      return Future.value(movieByGenre);
    });
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return _dataAgent.getGenres().then((genresList) async {
      genreDao.saveAllGenres(genresList!);
      genres = genresList;
      getMovieByGenre(genresList.first.id ?? 1);
      return Future.value(genres);
    });
  }

  @override
  void getActors(int page) {
    _dataAgent.getActors(page).then((actorsList) async {
      actorDao.saveAllActors(actorsList!);
      actors = actorsList;
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId) {
    return _dataAgent.getCreditByMovie(movieId).then((castAndCrews) {
      casts = castAndCrews.first;
      crews = castAndCrews.last;
      return Future.value(castAndCrews);
    });
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) {
      movieDao.saveSingleMove(movie!);
      movieDetails = movie;
      return Future.value(movieDetails);
    });
  }

  /// from database
  @override
  Future<List<ActorVO>> getActorsFromDatabase() {
    return Future.value(actors = actorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
    return Future.value(genres = genreDao.getAllGenres());
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDetails = movieDao.getMoveById(movieId));
  }

  @override
  Future<List<MovieVO>> getNowPlayingMovieFromDatabase() {
    getNowPlayingMovie(1);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getNowPlayingMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first
        .then((nowPlayingMoviesList) {
      nowPlayingMovies = nowPlayingMoviesList;
      return Future.value(nowPlayingMovies);
    });
  }

  @override
  Future<List<MovieVO>> getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getPopularMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first
        .then((popularMoviesList) {
      popularMovies = popularMoviesList;
      return Future.value(popularMovies);
    });
  }

  @override
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getTopRatedMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first
        .then((topRelatedMovies) {
      topRatedMovies = topRelatedMovies;
      return Future.value(topRelatedMovies);
    });
  }

  /// reactive programming
  @override
  void getNowPlayingMovie(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) async {
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
    _dataAgent.getPopularMovies(page).then((movies) async {
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
    _dataAgent.getTopRatedMovies(page).then((movies) async {
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

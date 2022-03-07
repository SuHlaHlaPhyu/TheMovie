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

  MovieModelImpl._internal() {
    getNowPlayingMovieFromDatabase();
    getTopRatedMoviesFromDatabase();
    getPopularMoviesFromDatabase();
    getActors(1);
    getActorsFromDatabase();
    getGenres();
    getGenresFromDatabase();
  }

  /// Daos
  ActorDao actorDao = ActorDao();
  GenreDao genreDao = GenreDao();
  MovieDao movieDao = MovieDao();

  /// State
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? movieByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  /// Network
  @override
  void getMovieByGenre(int genreId) {
    _dataAgent.getMovieByGenre(genreId).then((movieByGenreList) {
      movieByGenre = movieByGenreList;
      notifyListeners();
    });
  }

  @override
  void getGenres() {
    _dataAgent.getGenres().then((genresList) async {
      genreDao.saveAllGenres(genresList!);
      genres = genresList;
      getMovieByGenre(genresList.first.id ?? 1);
      notifyListeners();
    });
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return _dataAgent.getActors(page).then((actorsList) async {
      actorDao.saveAllActors(actorsList!);
      actors = actorsList;
      notifyListeners();
      return Future.value(actorsList);
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
  void getActorsFromDatabase() {
    actors = actorDao.getAllActors();
    notifyListeners();
  }

  @override
  void getGenresFromDatabase() {
    genres = genreDao.getAllGenres();
    notifyListeners();
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDao.getMoveById(movieId));
  }

  @override
  void getNowPlayingMovieFromDatabase() {
    getNowPlayingMovie(1);
    movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getNowPlayingMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first
        .then((nowPlayingMoviesList) {
      nowPlayingMovies = nowPlayingMoviesList;
      notifyListeners();
    });
  }

  @override
  void getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getPopularMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first
        .then((popularMoviesList) {
      popularMovies = popularMoviesList;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getTopRatedMovieStream())
        .map((event) => movieDao.getAllMovies())
        .first
        .then((topRelatedMovies) {
      topRatedMovies = topRelatedMovies;
      notifyListeners();
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
      notifyListeners();
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
      notifyListeners();
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
      notifyListeners();
    });
  }
}

import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../../mock_data/mock_data.dart';

class MovieModelImplMock extends MovieModel {
  @override
  Future<List<ActorVO>?>? getActors(int page) {
    return Future.value(getMockActorForTest());
  }

  @override
  Future<List<ActorVO>?> getActorsFromDatabase() {
    return Future.value(getMockActorForTest());
  }

  @override
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId) {
    return Future.value([getMockActorForTest()]);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return Future.value(getMockGenreForTest());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(getMockGenreForTest());
  }

  @override
  Future<List<MovieVO>?> getMovieByGenre(int genreId) {
    if (genreId == 3) {
      return Future.value([getMockMovieForTest().last]);
    } else {
      return Future.value([getMockMovieForTest().first]);
    }
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return Future.value(getMockMovieForTest().first);
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(getMockMovieForTest().first);
  }

  @override
  void getNowPlayingMovie(int page) {
    // NO need to mock
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMovieFromDatabase() {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  void getPopularMovies(int page) {
    // NO need to mock
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase() {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isPopular ?? false)
        .toList());
  }

  @override
  void getTopRatedMovies(int page) {
    // NO need to mock
  }

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }
}

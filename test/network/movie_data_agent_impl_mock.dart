import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';

import '../mock_data/mock_data.dart';

class MovieDataAgentImplMock extends MovieDataAgent {
  @override
  Future<List<ActorVO>?> getActors(int page) {
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
  Future<List<MovieVO>?> getMovieByGenre(int genreId) {
    return Future.value(getMockMovieForTest());
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return Future.value(getMockMovieForTest().first);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return Future.value(getMockMovieForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return Future.value(getMockMovieForTest()
        .where((element) => element.isPopular ?? false)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return Future.value(getMockMovieForTest()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }
}

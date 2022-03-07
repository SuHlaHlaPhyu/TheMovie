import 'package:dio/dio.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mapi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mapi = TheMovieApi(dio);
  }
  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return mapi
        .getNowPlayingMovie(
          API_KEY,
          LANGUAGE_EN_US,
          page.toString(),
        )
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return mapi
        .getPopularMovie(
          API_KEY,
          LANGUAGE_EN_US,
          page.toString(),
        )
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return mapi
        .getTopRatedMovie(
          API_KEY,
          LANGUAGE_EN_US,
          page.toString(),
        )
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getMovieByGenre(int genreId) {
    return mapi
        .getNowPlayingMovie(
          API_KEY,
          LANGUAGE_EN_US,
          genreId.toString(),
        )
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mapi
        .getGenres(
          API_KEY,
          LANGUAGE_EN_US,
        )
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mapi
        .getActors(
          API_KEY,
          LANGUAGE_EN_US,
          page.toString(),
        )
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mapi.getMovieDetails(
      movieId.toString(),
      API_KEY,
    );
  }

  @override
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId) {
    return mapi
        .getCreditByMovie(
          movieId.toString(),
          API_KEY,
        )
        .asStream()
        .map((getCreditsByMovieResponse) =>
            [getCreditsByMovieResponse.cast, getCreditsByMovieResponse.crew])
        .first;
  }
}

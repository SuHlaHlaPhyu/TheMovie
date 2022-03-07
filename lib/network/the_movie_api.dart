import 'package:dio/dio.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/responses/get_actor_response.dart';
import 'package:movie_app/network/responses/get_credit_by_movie_response.dart';
import 'package:movie_app/network/responses/get_genre_response.dart';
import 'package:movie_app/network/responses/movie_list_response.dart';
import 'package:retrofit/retrofit.dart';

part 'the_movie_api.g.dart';

@RestApi(
    baseUrl:
        BASE_URL_DIO) // retrofit is build upon Dio . we need base url that include "https://"
abstract class TheMovieApi {
  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @GET(ENDPOINT_GET_NOW_PLAYING)
  Future<MovieListResponse> getNowPlayingMovie(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_TOP_RATED)
  Future<MovieListResponse> getTopRatedMovie(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_POPULAR)
  Future<MovieListResponse> getPopularMovie(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_MOVIES_BY_GENRES)
  Future<MovieListResponse> getMoviesByGenres(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_GENRES)
  Future<GetGenreResponse> getGenres(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
  );

  @GET(ENDPOINT_GET_ACTORS)
  Future<GetActorResponse> getActors(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET("$ENDPOINT_GET_MOVIE_DETAILS/{movie_id}")
  Future<MovieVO?> getMovieDetails(
      @Path("movie_id") String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      );

  @GET("/3/movie/{movie_id}/credits")
  Future<GetCreditByMovieResponse> getCreditByMovie(
      @Path("movie_id") String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      );
}

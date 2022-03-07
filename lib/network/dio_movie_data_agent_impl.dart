/*import 'package:dio/dio.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';

import 'api_constants.dart';

class DioMovieDataAgentImpl extends MovieDataAgent {
  @override
  void getNowPlayingMovies(int page) {
    Map<String, String> queryParameters = {
      PARAM_API_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_EN_US,
      PARAM_PAGE: page.toString(),
    };

// response body return
    Dio().get(
      "$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING",
      queryParameters: queryParameters,
    ).then((value) {
      print("Now playing movie ====> ${value.toString()}");
    }).catchError((error) {
      print("Error ====> $error");
    });

  }
}
 */

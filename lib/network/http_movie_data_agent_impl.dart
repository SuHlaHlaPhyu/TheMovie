/*import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:http/http.dart' as http;

class HttpMovieDataAgentImpl extends MovieDataAgent {
  @override
  void getNowPlayingMovies(int page) {
    Map<String, String> queryParameters = {
      PARAM_API_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_EN_US,
      PARAM_PAGE: page.toString(),
    };

    // Uri.https(base url,end point, query paramenter)
    var url = Uri.https(
      BASE_URL_HTTP,
      ENDPOINT_GET_NOW_PLAYING,
      queryParameters,
    );
    http.get(url).then((value) {
      print("Now playing movie ====> ${value.body.toString()}");
    }).catchError((error) {
      print("Error ====> $error");
    });
  }
}
 */

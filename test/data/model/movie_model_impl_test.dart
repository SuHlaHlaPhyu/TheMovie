import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../../network/movie_data_agent_impl_mock.dart';
import '../../persistence/actor_dao_impl_mock.dart';
import '../../persistence/genre_dao_impl_mock.dart';
import '../../persistence/movie_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaosAndDataAgents(
        MovieDaoImplMock(),
        ActorDaoImplMock(),
        GenreDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test(
        "Saving now playing movies and getting now playing movies form database",
        () {
      expect(
        movieModel.getNowPlayingMovieFromDatabase(),
        emits(
          Future.value([
            MovieVO(
              false,
              "/yzpCv8CCWondN7O5au1KGiqnC3A.jpg",
              [16, 10751, 35, 14],
              508947,
              "en",
              "Turning Red",
              "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
              5126.644,
              "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
              "2022-03-01",
              "Turning Red",
              false,
              7.5,
              1450,
              null,
              200000000,
              null,
              "https://www.warnerbros.com/movies/wonder-woman-1984",
              null,
              null,
              null,
              165160005,
              151,
              null,
              "Released",
              "A new era of wonder begins.",
              true,
              false,
              false,
            ),
          ]),
        ),
      );
    });
  });
}

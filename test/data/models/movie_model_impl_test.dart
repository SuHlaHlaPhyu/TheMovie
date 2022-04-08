import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../../mock_data/mock_data.dart';
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

    test("Saving now playing movies and getting now playing movies form database", () {
      expect(
        movieModel.getNowPlayingMovieFromDatabase(),
        emits([
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
      );
    });

    test("Saving popular movies and getting popular movies form database", () {
      expect(
        movieModel.getPopularMoviesFromDatabase(),
        emits([
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
            false,
            true,
            false,
          ),
        ]),
      );
    });

    test("Saving top rated movies and getting top rated movies form database",
        () {
      expect(
        movieModel.getTopRatedMoviesFromDatabase(),
        emits([
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
            false,
            false,
            true,
          ),
        ]),
      );
    });

    test("Get Genres Test", () {
      expect(
        movieModel.getGenres(),
        completion(
          equals(
            getMockGenreForTest(),
          ),
        ),
      );
    });

    test("Get Actors Test", () {
      expect(
        movieModel.getActors(1),
        completion(
          equals(
            getMockActorForTest().first,
          ),
        ),
      );
    });

    test("Get Actors from database Test", ()
    async
    {
      await movieModel.getActors(1);
      expect(
        movieModel.getActorsFromDatabase(),
        completion(
          equals(
            getMockActorForTest().first,
          ),
        ),
      );
    });

    test("Get Credits Test", () {
      expect(
        movieModel.getCreditByMovie(508947),
        completion(
          equals(
           [ getMockActorForTest().first],
          ),
        ),
      );
    });

    test("Get Movie Details Test", () {
      expect(
        movieModel.getMovieDetails(508947),
        completion(
          equals(
            getMockMovieForTest().first,
          ),
        ),
      );
    });

    test("Get Movie details from database Test", ()
     async
    {
      await movieModel.getMovieDetails(508947);
      expect(
        movieModel.getMovieDetailsFromDatabase(508947),
        completion(
          equals(
            getMockMovieForTest().first,
          ),
        ),
      );
    });

    test("Get Genres from database Test", ()
     async
    {
       await movieModel.getGenres();
      expect(
        movieModel.getGenresFromDatabase(),
        completion(
          equals(
            getMockGenreForTest(),
          ),
        ),
      );
    });
  });
}

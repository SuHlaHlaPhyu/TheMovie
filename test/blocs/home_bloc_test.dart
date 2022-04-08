import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/blocs/home_bloc.dart';

import '../data/models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Home bloc test", () {
    HomeBloc? homeBloc;

    setUp(() {
      homeBloc = HomeBloc(MovieModelImplMock());
    });

    test("Fetch now playing movies test", () {
      expect(homeBloc?.nowPlayingMovies?.contains(getMockMovieForTest().first),
          true);
    });

    test("Fetch popular movies test", () {
      expect(homeBloc?.popularMovies?.contains(getMockMovieForTest()[1]), true);
    });

    test("Fetch top rated movies test", () {
      expect(
          homeBloc?.topRatedMovies?.contains(getMockMovieForTest().last), true);
    });

    test("Fetch genre list test", () {
      expect(homeBloc?.genres?.contains(getMockGenreForTest().first), true);
    });

    test("Fetch genre by movies test", () async {
      await Future.delayed(const Duration(milliseconds: 500));
      expect(
          homeBloc?.movieByGenre?.contains(getMockMovieForTest().first), true);
    });

    test("Fetch actor list test", () {
      expect(homeBloc?.actors?.contains(getMockActorForTest().first), true);
    });

    test("Fetch genre by movies test", () async {
      homeBloc?.onTapGenre(3);
      await Future.delayed(const Duration(milliseconds: 500));
      expect(
          homeBloc?.movieByGenre?.contains(getMockMovieForTest().first), true);
    });
  });
}

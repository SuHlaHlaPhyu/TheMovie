import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

List<MovieVO> getMockMovieForTest() {
  return [
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
        false),
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
        false),
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
        true),
  ];
}

List<ActorVO> getMockActorForTest() {
  return [
    ActorVO(
      false,
      1,
      224513,
      [
        getMockMovieForTest().first,
      ],
      "Acting",
      "Ana de Armas",
      107.821,
      "/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg",
      null,
      null,
      null,
      null,
      null,
    ),
    ActorVO(
      false,
      2,
      1136406,
      [],
      "Acting",
      "Tom Holland",
      94.667,
      "/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg",
      null,
      null,
      null,
      null,
      null,
    ),
    ActorVO(
      false,
      2,
      3030319,
      [],
      "Acting",
      "Mile Phakphum Romsaithong",
      92.579,
      "/CJNW34J8v1TZbD1jrloqFAMGKt.jpg",
      null,
      null,
      null,
      null,
      null,
    ),
  ];
}

List<GenreVO> getMockGenreForTest() {
  return [
    GenreVO(28, "Action"),
    GenreVO(12, "Adventure"),
    GenreVO(16, "Animation"),
    GenreVO(35, "Comedy"),
    GenreVO(80, "Crime"),
    GenreVO(99, "Documentary"),
    GenreVO(18, "Drama"),
    GenreVO(10751, "Family"),
    GenreVO(14, "Fantasy"),
    GenreVO(36, "History"),
    GenreVO(27, "Horror"),
    GenreVO(10402, "Music"),
    GenreVO(9648, "Mystery"),
    GenreVO(10749, "Romance"),
    GenreVO(878, "Science Fiction"),
    GenreVO(10770, "TV Movie"),
    GenreVO(53, "Thriller"),
    GenreVO(10752, "War"),
    GenreVO(37, "Western"),
  ];
}

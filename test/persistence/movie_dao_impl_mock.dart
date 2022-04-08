import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int?, MovieVO> moviesInDatabaseMock = {};
  @override
  Stream<void> getAllMovieEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMockMovieForTest();
  }

  @override
  MovieVO? getMoveById(int movieId) {
    return moviesInDatabaseMock.values
        .toList()
        .firstWhere((element) => element.id == movieId);
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMovieStream() {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>> getPopularMovieStream() {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isPopular ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>> getTopRatedMovieStream() {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }

  @override
  void saveAllMovies(List<MovieVO> movieList) {
    movieList.forEach((element) {
      moviesInDatabaseMock[element.id] = element;
    });
  }

  @override
  void saveSingleMove(MovieVO movie) {
    if( movie != null){
      moviesInDatabaseMock[movie.id] = movie;
    }
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if(getMockMovieForTest().isNotEmpty){
      return getMockMovieForTest().where((element) => element.isNowPlaying ?? false).toList();
    }else {
      return [];
    }
  }

  @override
  List<MovieVO> getPopularMovies() {
    if(getMockMovieForTest().isNotEmpty){
      return getMockMovieForTest().where((element) => element.isPopular ?? false).toList();
    }else {
      return [];
    }
  }

  @override
  List<MovieVO> getTopRatedMovies() {
    if(getMockMovieForTest().isNotEmpty){
      return getMockMovieForTest().where((element) => element.isTopRated ?? false).toList();
    }else {
      return [];
    }
  }
}

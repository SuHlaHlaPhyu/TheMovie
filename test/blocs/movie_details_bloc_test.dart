import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/blocs/movie_details_bloc.dart';

import '../data/models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Movie detail bloc test", (){
    MovieDetailsBloc? movieDetailsBloc;

    setUp((){
      movieDetailsBloc = MovieDetailsBloc(1,MovieModelImplMock());
    });
    
    test("Fetch movie detail test", (){
      expect(movieDetailsBloc?.movieDetail, getMockMovieForTest().first);
    });

    test("Fetch creators test", (){
      expect(movieDetailsBloc?.crews?.contains(getMockActorForTest()[1]), true);
    });

    test("Fetch actor test", (){
      expect(movieDetailsBloc?.casts?.contains(getMockActorForTest().first), true);
    });
  });
}
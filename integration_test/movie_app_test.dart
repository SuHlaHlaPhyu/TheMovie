import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/collection_vo.dart';
import 'package:movie_app/data/vos/date_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/data/vos/production_company_vo.dart';
import 'package:movie_app/data/vos/production_countries_vo.dart';
import 'package:movie_app/data/vos/spoken_languages_vo.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/persistence/hive_constance.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountriesVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);

  testWidgets("Tap Best Popular movie and Navigate to Details",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await Future.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);

    await tester.tap(find.text(TEST_DATA_MOVIE_NAME));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);
    expect(find.text(TEST_DATA_RELEASED_YEAR), findsOneWidget);
    expect(find.text(TEST_DATA_RATING), findsOneWidget);
  });
}

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/home_bloc.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/banner_view.dart';
import 'package:movie_app/viewitems/show_case_view.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import 'package:provider/provider.dart';

import '../widgets/title_and_horizontal_movie_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: HOME_SCREEN_BACKGROUND_COLOR,
          title: const Text(
            MAIN_SCREEN_APPBAR_TITLE,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: const Icon(
            Icons.menu,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: 0,
                right: MARGIN_MEDIUM_2,
              ),
              child: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (BuildContext context, bloc) =>
                      bloc.nowPlayingMovies,
                  builder:
                      (BuildContext context, popularMovies, Widget? child) {
                    return BannerSectionView(
                      popularMoviesList: popularMovies?.take(5).toList(),
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (BuildContext context, bloc) =>
                      bloc.popularMovies,
                  builder:
                      (BuildContext context, nowPlayingMovies, Widget? child) {
                    return TitleAndHorizontalMovieListView(
                      label: MAIN_SCREEN_POPULAR_MOVIES_AND_SERIES,
                      onTapMovies: (movieId) =>
                          _navigateToMovieDetailScreen(context, movieId ?? 1),
                      nowPlayingMovies: nowPlayingMovies,
                      onListEndReach: () {
                        HomeBloc bloc =
                            Provider.of<HomeBloc>(context, listen: false);
                        bloc.onNowPlayingMovieListEndReached();
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                CheckMovieShowTimeSectionView(),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Selector<HomeBloc, List<GenreVO>?>(
                  selector: (BuildContext context, bloc) => bloc.genres,
                  builder: (BuildContext context, genres, Widget? child) {
                    return Selector<HomeBloc, List<MovieVO>?>(
                      selector: (BuildContext context, bloc) =>
                          bloc.movieByGenre,
                      builder:
                          (BuildContext context, movieByGenre, Widget? child) {
                        return GenreSectionView(
                          onChooseGenre: (genreId) {
                            HomeBloc bloc =
                                Provider.of<HomeBloc>(context, listen: false);
                            if (genreId != null) {
                              bloc.onTapGenre(genreId);
                            }
                          },
                          movieByGenre: movieByGenre,
                          onTapMovie: (movieId) => _navigateToMovieDetailScreen(
                            context,
                            movieId ?? 1,
                          ),
                          genreList: genres,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (BuildContext context, bloc) => bloc.topRatedMovies,
                  builder:
                      (BuildContext context, topRatedMovies, Widget? child) {
                    return ShowCasesSection(
                      movieList: topRatedMovies,
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Selector<HomeBloc, List<ActorVO>?>(
                  selector: (BuildContext context, bloc) => bloc.actors,
                  builder: (BuildContext context, actors, Widget? child) {
                    return ActorsAndCreatorsSectionView(
                      BEST_ACTORS_TITLE,
                      BEST_ACOTRS_SEEMORE,
                      actorList: actors,
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(
    BuildContext context,
    int movieId,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(
          movieId,
        ),
      ),
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<MovieVO>? movieByGenre;
  final List<GenreVO>? genreList;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenre;
  GenreSectionView({
    required this.onTapMovie,
    required this.genreList,
    required this.movieByGenre,
    required this.onChooseGenre,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              onTap: (index) {
                onChooseGenre(genreList?[index].id);
              },
              isScrollable: true,
              indicatorColor: PLAYBUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map(
                        (genre) => Tab(
                          child: Text(genre.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: const EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) => onTapMovie(movieId),
            movieList: movieByGenre,
            onListEndReach: () {},
          ),
        ),
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      height: MOVIE_SHOW_TIME_SECTION_HEIGHT,
      margin: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      padding: const EdgeInsets.all(
        MARGIN_LARGE,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                MAIN_SCREEN_CHECK_MOVIEW_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAYBUTTON_COLOR,
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAYBUTTON_SIZE,
          ),
        ],
      ),
    );
  }
}

class ShowCasesSection extends StatelessWidget {
  final List<MovieVO>? movieList;
  ShowCasesSection({
    required this.movieList,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: TitleTextWithSeeMoreView(
            SHOW_CASES_TITLE,
            SHOW_CASES_SEEMORE,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            padding: const EdgeInsets.only(
              left: MARGIN_MEDIUM_2,
            ),
            scrollDirection: Axis.horizontal,
            children: movieList
                    ?.map(
                      (movie) => ShowCaseView(
                        movie: movie,
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO>? popularMoviesList;
  BannerSectionView({
    required this.popularMoviesList,
  });
  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.popularMoviesList
                    ?.map(
                      (movie) => BannerView(
                        movie: movie,
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        DotsIndicator(
          dotsCount: widget.popularMoviesList?.length ?? 1,
          position: _position,
          decorator: const DotsDecorator(
            color: HOME_SCREEN_BANNER_DOT_INACTIVE_COLOR,
            activeColor: PLAYBUTTON_COLOR,
          ),
        )
      ],
    );
  }
}

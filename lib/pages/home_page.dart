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
import 'package:movie_app/viewitems/movie_view.dart';
import 'package:movie_app/viewitems/show_case_view.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc();
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              StreamBuilder<List<MovieVO>?>(
                stream: _bloc.popularMoviesStreamController.stream,
                builder: (context, snapshot) {
                  return BannerSectionView(
                    popularMoviesList: snapshot.data?.take(5).toList(),
                  );
                },
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              StreamBuilder<List<MovieVO>?>(
                stream: _bloc.nowPlayingMoviesStreamController.stream,
                builder: (context, snapshot) {
                  return BestPopularMoviesAndSerialsView(
                    onTapMovies: (movieId) =>
                        _navigateToMovieDetailScreen(context, movieId ?? 1),
                    nowPlayingMovies: snapshot.data,
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
              StreamBuilder<List<GenreVO>?>(
                  stream: _bloc.genresStreamController.stream,
                  builder: (context, genreSnapshot) {
                    return StreamBuilder<List<MovieVO>?>(
                        stream: _bloc.movieByGenreStreamController.stream,
                        builder: (context, snapshot) {
                          return GenreSectionView(
                            onChooseGenre: (genreId) {
                              if (genreId != null) {
                                _bloc.onTapGenre(genreId);
                              }
                            },
                            movieByGenre: snapshot.data,
                            onTapMovie: (movieId) =>
                                _navigateToMovieDetailScreen(
                              context,
                              movieId ?? 1,
                            ),
                            genreList: genreSnapshot.data,
                          );
                        });
                  }),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              StreamBuilder<List<MovieVO>?>(
                stream: _bloc.topRatedMoviesStreamController.stream,
                builder: (context, snapshot) {
                  return ShowCasesSection(
                    movieList: snapshot.data,
                  );
                },
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              StreamBuilder<List<ActorVO>?>(
                stream: _bloc.actorsStreamController.stream,
                builder: (context, snapshot) {
                  return ActorsAndCreatorsSectionView(
                    BEST_ACTORS_TITLE,
                    BEST_ACOTRS_SEEMORE,
                    actorList: snapshot.data,
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

class BestPopularMoviesAndSerialsView extends StatelessWidget {
  final Function(int?) onTapMovies;
  final List<MovieVO>? nowPlayingMovies;
  // ignore: use_key_in_widget_constructors
  const BestPopularMoviesAndSerialsView({
    required this.onTapMovies,
    required this.nowPlayingMovies,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2,
          ),
          child: TitleText(
            MAIN_SCREEN_POPULAR_MOVIES_AND_SERIES,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          onTapMovie: (movieId) => onTapMovies(movieId),
          movieList: nowPlayingMovies,
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  HorizontalMovieListView({
    required this.onTapMovie,
    required this.movieList,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                left: MARGIN_MEDIUM_2,
              ),
              itemCount: movieList?.length ?? 0,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                return MovieView(
                  onTapMovie: () {
                    onTapMovie(movieList?[index].id);
                  },
                  movie: movieList?[index],
                );
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
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

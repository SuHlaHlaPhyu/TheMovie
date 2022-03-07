import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  MovieDetailsPage({required this.movieId});
  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieModel movieModel = MovieModelImpl();
  List<ActorVO>? casts;
  List<ActorVO>? crews;
  MovieVO? movieDetails;

  @override
  void initState() {
    /// Get Movie Details
    movieModel.getMovieDetails(widget.movieId).then((details) {
      setState(() {
        movieDetails = details;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Get Movie Details Database
    movieModel.getMovieDetailsFromDatabase(widget.movieId).then((details) {
      setState(() {
        movieDetails = details;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Get Credits by movies
    movieModel.getCreditByMovie(widget.movieId).then((castAndCrews) {
      setState(() {
        casts = castAndCrews.first;
        crews = castAndCrews.last;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailsSilverAppbarView(
              () => Navigator.pop(context),
              movie: movieDetails,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: MARGIN_MEDIUM_2,
                    ),
                    child: TrailerSection(
                      genreList: movieDetails?.getGenreListAsStringList() ?? [],
                      storyLine: movieDetails?.overview ?? "",
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_LARGE,
                  ),
                  ActorsAndCreatorsSectionView(
                    MOVIE_DETAIL_SCREEN_ACTOR_TITLE,
                    '',
                    seeMoreButtonVisibility: false,
                    actorList: casts,
                  ),
                  const SizedBox(
                    height: MARGIN_LARGE,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_MEDIUM_2,
                    ),
                    child: AboutFilmSectionView(
                      movie: movieDetails,
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_LARGE,
                  ),
                  ActorsAndCreatorsSectionView(
                    MOVIE_DETAIL_SCREEN_CREATOR_TITLE,
                    MOVIE_DETAIL_SCREEN_CREATOR_SEEMORE,
                    actorList: crews,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? movie;
  AboutFilmSectionView({
    required this.movie,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          'ABOUT FILM',
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Original title',
          movie?.title ?? "",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Type',
          movie?.getGenreListAsCommaSeparatedStringList() ?? "",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Production',
          movie?.getProductionCountriesAsCommaSeparatedStringList() ?? "",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Premiere',
          movie?.releaseDate ?? "",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Description',
          movie?.overview ?? "",
        ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;
  AboutFilmInfoView(
    this.label,
    this.description,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: const TextStyle(
              color: MOVIE_DETAIL_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;
  final String storyLine;
  TrailerSection({
    required this.genreList,
    required this.storyLine,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(
          genreList: genreList,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(
          storyline: storyLine,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: [
            MovieDetailScreenButtonView(
              'PLAY TRAILER',
              PLAYBUTTON_COLOR,
              const Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailScreenButtonView(
              'RATE MOVIE',
              HOME_SCREEN_BACKGROUND_COLOR,
              const Icon(
                Icons.star,
                color: PLAYBUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )
      ],
    );
  }
}

class MovieDetailScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;
  MovieDetailScreenButtonView(
    this.title,
    this.backgroundColor,
    this.buttonIcon, {
    this.isGhostButton = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_CARD_MEDIUM_2,
      ),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
        border: isGhostButton
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            const SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TEXT_REGULAR_2X,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  String? storyline;
  StoryLineView({required this.storyline});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          MOVIE_DETAIL_STORYLINE_TITLE,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          storyline ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(
          Icons.access_time,
          color: PLAYBUTTON_COLOR,
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        const Text(
          '2hr, 30 mins',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        ),
        ...genreList
            .map(
              (genre) => GenreChipView(genre),
            )
            .toList(),
        const Icon(
          Icons.favorite_border_outlined,
          color: Colors.white,
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;
  GenreChipView(this.genreText);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAIL_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}

class MovieDetailsSilverAppbarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movie;
  MovieDetailsSilverAppbarView(
    this.onTapBack, {
    required this.movie,
  });
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MOVIE_DETAILS_SCREEN_SILVER_APPBAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(
                imageUrl: movie?.posterPath ?? "",
              ),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(
                  () => onTapBack(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE,
                ),
                child: DetailAppbarInfoView(
                  movie: movie,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailAppbarInfoView extends StatelessWidget {
  final MovieVO? movie;
  DetailAppbarInfoView({required this.movie});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(
              releaseDate: movie?.releaseDate?.substring(0, 4) ?? "",
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RatingView(),
                    const SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText(
                      '${movie?.voteCount ?? 0} VOTES',
                    ),
                    const SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    ),
                  ],
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  movie?.voteAverage.toString() ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          movie?.title ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String? releaseDate;
  MovieDetailsYearView({required this.releaseDate});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: PLAYBUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
      ),
      child: Center(
        child: Text(
          releaseDate ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  BackButtonView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: Container(
        height: MARGIN_XXLARGE,
        width: MARGIN_XXLARGE,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  String imageUrl;
  MovieDetailsAppBarImageView({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
      fit: BoxFit.cover,
    );
  }
}

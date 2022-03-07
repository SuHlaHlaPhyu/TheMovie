import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {
  final String seeMoreText;
  final String titleText;
  final bool seeMoreButtonVisibility;
  final List<ActorVO>? actorList;
  ActorsAndCreatorsSectionView(
    this.titleText,
    this.seeMoreText, {
    this.seeMoreButtonVisibility = true,
        required this.actorList,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: const EdgeInsets.only(
        top: MARGIN_MEDIUM_2,
        bottom: MARGIN_XXLARGE,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_LARGE,
            ),
            child: TitleTextWithSeeMoreView(
              titleText,
              seeMoreText,
              seeMoreButtonVisibility: seeMoreButtonVisibility,
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Container(
            height: BEST_ACTORS_HEIGHT,
            child: ListView(
              padding: const EdgeInsets.only(
                left: MARGIN_MEDIUM_2,
              ),
              scrollDirection: Axis.horizontal,
              children: actorList?.map((actor) => ActorView(actor: actor,)).toList() ?? [],
            ),
          ),
        ],
      ),
    );
  }
}

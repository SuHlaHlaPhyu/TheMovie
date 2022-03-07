import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';

class ActorView extends StatelessWidget {
  final ActorVO actor;
  ActorView({required this.actor});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: MARGIN_MEDIUM,
      ),
      width: MOVIE_LSIT_ITEM_WIDTH,
      child: Stack(
        children: [
          Positioned.fill(
            child: ActorImageView(
              imageUrl: actor.profilePath ?? "",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              MARGIN_MEDIUM,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: FavoriteButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(
              actorName: actor.name ?? "",
            ),
          )
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  final String imageUrl;
  ActorImageView({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$imageUrl',
      fit: BoxFit.cover,
    );
  }
}

class FavoriteButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite_border_outlined,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  final String? actorName;
  ActorNameAndLikeView({required this.actorName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            actorName ?? "",
            style: const TextStyle(
              fontSize: TEXT_REGULAR,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: const [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM_2,
              ),
              Text(
                'YOU LIKE 13 VIDEOS',
                style: TextStyle(
                  color: HOME_SCREEN_LIST_TITLE_COLOR,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

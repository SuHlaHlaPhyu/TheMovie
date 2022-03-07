import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';

class PlayButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.play_circle_fill,
      size: BANNER_PLAYBUTTON_SIZE,
      color: PLAYBUTTON_COLOR,
    );
  }
}

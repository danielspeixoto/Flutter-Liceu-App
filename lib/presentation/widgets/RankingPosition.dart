import 'package:app/presentation/pages/trophy/ViewModel.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RankingPosition extends StatelessWidget {

  final TrophyEntry game;

  RankingPosition(this.game);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Text(game.position.toString() + "º"),
            Container(
              margin: EdgeInsets.all(8),
              child: RoundedImage(
                pictureURL:
                    game.pictureURL,
                size: 36,
              ),
            ),
            Text(game.name),
            Spacer(),
            Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.check),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Text(game.score),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.clock),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Text(game.timeSpent),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
}

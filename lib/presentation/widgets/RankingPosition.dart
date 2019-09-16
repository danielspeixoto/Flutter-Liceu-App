import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RankingPosition extends StatelessWidget {
  RankingPosition();

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Text("1º"),
            Container(
              margin: EdgeInsets.all(8),
              child: RoundedImage(
                pictureURL:
                    "https://static.thenounproject.com/png/17241-200.png",
                size: 36,
              ),
            ),
            Text("Daniel Peixoto"),
            Spacer(),
            Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.check),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Text("3"),
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
                        child: Text("3:01"),
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

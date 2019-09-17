import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/aggregates/ChallengeData.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';

class MatchHistory extends StatelessWidget {
  final ChallengeData challenge;

  MatchHistory(this.challenge);

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          user(context, challenge.challenger),
          Expanded(
            child: Text(
              "4 X 4",
              textAlign: TextAlign.center,
            ),
          ),
          user(context, challenge.challenged)
        ],
      );

  Widget user(BuildContext context, User user) => Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8),
              child: RoundedImage(
                pictureURL: user == null ? "" : user.picURL,
                size: 36,
              ),
            ),
            user == null ? "Em espera" : Text(user.name)
          ],
        ),
        padding: EdgeInsets.all(8),
      );
}

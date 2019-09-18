import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/aggregates/ChallengeData.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';

class MatchHistory extends StatelessWidget {
  final ChallengeData challenge;

  MatchHistory(this.challenge);

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Expanded(child: user(context, challenge.challenger)),
          Expanded(
            child: Text(
              challenge.scoreChallenger.toString() +
                  "   X   " +
                  (challenge.scoreChallenged == null
                      ? "-"
                      : challenge.scoreChallenged.toString()),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: user(context, challenge.challenged))
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

import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/aggregates/ChallengeHistoryData.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';

class MatchHistory extends StatelessWidget {
  final ChallengeHistoryData challenge;
  final Function(User user) onUserPressed;

  MatchHistory(this.challenge, this.onUserPressed);

  @override
  Widget build(BuildContext context) => Container(
        child: Row(
          children: <Widget>[
            Expanded(child: user(context, challenge.challenger)),
            Expanded(
              child: Column(
                children: [
                  Text(
                    challenge.scoreChallenger.toString() +
                        "   X   " +
                        (challenge.scoreChallenged == null
                            ? "-"
                            : challenge.scoreChallenged.toString()),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(child: user(context, challenge.challenged))
          ],
        ),
      );

  Widget user(BuildContext context, User user) => FlatButton(
        onPressed: () => onUserPressed(user),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8),
              child: RoundedImage(
                pictureURL: user == null ? user.picURL : null,
                picturePath: "assets/koala.png",
                size: 36,
              ),
            ),
            user == null
                ? Text("Em espera")
                : Text(
                    user.name,
                    textAlign: TextAlign.center,
                  )
          ],
        ),
        padding: EdgeInsets.all(8),
      );
}

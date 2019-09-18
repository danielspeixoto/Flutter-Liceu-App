import 'package:flutter/material.dart';

class ChallengeAnswerCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onPressed;

  ChallengeAnswerCard(this.iconData, this.title, this.onPressed);

  @override
  Widget build(BuildContext context) => FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: this.onPressed,
        child: Card(
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    iconData,
                    size: 24,
                  ),
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(right: 8),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

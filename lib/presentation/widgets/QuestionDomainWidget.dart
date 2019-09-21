import 'package:flutter/material.dart';

class QuestionDomainWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onPressed;

  QuestionDomainWidget(this.iconData, this.title, this.onPressed);

  @override
  Widget build(BuildContext context) => Card(
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: this.onPressed,
          child: Container(
            child: Column(
              children: <Widget>[
                Spacer(),
                Icon(
                  iconData,
                  size: 60,
                ),
                Container(
                  margin: EdgeInsets.all(32),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      );
}

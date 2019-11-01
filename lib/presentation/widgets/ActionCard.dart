import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {

  final IconData iconData;
  final String title;
  final Function onPressed;

  ActionCard(this.iconData, this.title, this.onPressed);

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
                    size: 48,
                  ),
                  padding: EdgeInsets.all(24),
                  margin: EdgeInsets.only(right: 24),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActionCard extends StatelessWidget {

  final IconData iconData;
  final String title;

  ActionCard(this.iconData, this.title);

  @override
  Widget build(BuildContext context) => FlatButton(
    padding: EdgeInsets.all(0),
    onPressed: () {},
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

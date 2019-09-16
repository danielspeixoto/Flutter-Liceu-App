import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';

class MatchHistory extends StatelessWidget {
  MatchHistory();

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  child: RoundedImage(
                    pictureURL:
                        "https://static.thenounproject.com/png/17241-200.png",
                    size: 36,
                  ),
                ),
                Text("Daniel Peixoto")
              ],
            ),
            padding: EdgeInsets.all(8),
          ),
          Expanded(
            child: Text(
              "4 X 4",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  child: RoundedImage(
                    pictureURL:
                        "https://static.thenounproject.com/png/17241-200.png",
                    size: 36,
                  ),
                ),
                Text("Daniel Peixoto")
              ],
            ),
            padding: EdgeInsets.all(8),
          ),
        ],
      );
}

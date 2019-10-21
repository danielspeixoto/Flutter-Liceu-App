import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentWidget extends StatelessWidget {
  final String content;
  final String author;
  final String authorPic;
  final Function() onUserPressed;

  CommentWidget(
      {@required this.content,
      @required this.author,
      this.onUserPressed,
      this.authorPic});

  Widget build(BuildContext context) => Card(
        elevation: 0,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: RoundedImage(
                    pictureURL: this.authorPic,
                    size: 24.0,
                  ),
                  margin: EdgeInsets.all(4),
                ),
                Container(
                    margin: EdgeInsets.all(2),
                    child: FlatButton(
                      onPressed: () {
                        if (this.onUserPressed != null) {
                          this.onUserPressed();
                        }
                      },
                      child: Text(
                        this.author,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),

                      ),
                    )),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: Text(this.content, style: TextStyle(fontSize: 12),),
            )
          ],
        ),
      );
}

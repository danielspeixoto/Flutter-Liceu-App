import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentWidget extends StatelessWidget {
  final String content;
  final String author;
  final Function() onUserPressed;

  CommentWidget({@required this.content, @required this.author, this.onUserPressed});

  Widget build(BuildContext context) => Card(
        elevation: 1,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(2),
              child: FlatButton(
                onPressed: () {
                  if(this.onUserPressed != null){
                    this.onUserPressed();
                  }
                },
                child: Text(
                this.author,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),) 
            ),
            Text(this.content)
          ],
        ),
      );
}

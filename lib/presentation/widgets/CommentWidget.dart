import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentWidget extends StatelessWidget {
  final String id;
  final String content;
  final String author;
  final String authorPic;
  final Function() onUserPressed;
  final Function(String id) onDeleteCommentPressed;
  final bool isFounder;

  CommentWidget(
      {@required this.id,
      @required this.content,
      @required this.author,
      this.onUserPressed,
      this.authorPic,
      this.isFounder,
      this.onDeleteCommentPressed});

  Widget build(BuildContext context) => Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () => onUserPressed(),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: RoundedImage(
                      pictureURL:
                          this.authorPic != null ? this.authorPic : null,
                      size: 30,
                    ),
                  ),
                  Text(
                    this.author,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  this.isFounder != null
                      ? this.isFounder == true
                          ? Container(
                              padding: EdgeInsets.all(4),
                              child: Image(
                                image: AssetImage("assets/founder.png"),
                                width: 12,
                              ),
                            )
                          : Container()
                      : Container(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  children: <Widget>[
                                    this.onDeleteCommentPressed != null
                                        ? ListTile(
                                            title: Text("Deletar"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              this.onDeleteCommentPressed(
                                                  this.id);
                                            },
                                          )
                                        : Container(),
                                  ],
                                );
                              });
                        },
                        icon: Container(
                          child: Icon(
                            FontAwesomeIcons.ellipsisV,
                            size: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 2, left: 12),
              child: Text(
                this.content,
                style: TextStyle(fontSize: 13),
              ),
            )
          ],
        ),
      );
}

import 'package:app/domain/aggregates/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RoundedImage.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class PostWidget extends StatelessWidget {
  final User user;
  final String postContent;
  final String imageURL;
  final Function() onDeletePressed;
  final Function() onSharePressed;
  final Function(User) onUserPressed;
  final FlatButton seeMore;
  final Function onImageZoomPressed;

  PostWidget(
      {@required this.user,
      @required this.postContent,
      this.onDeletePressed,
      @required this.onSharePressed,
      this.onUserPressed,
      @required this.imageURL,
      this.seeMore,
      this.onImageZoomPressed});

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.only(bottom: 4),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => onUserPressed(user),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          child: RoundedImage(
                            pictureURL: this.user.picURL != null
                                ? this.user.picURL
                                : null,
                            size: 36,
                          ),
                        ),
                        Text(
                          this.user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        alignment: Alignment.topRight,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("Compartilhar"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        onSharePressed();
                                      },
                                    ),
                                    onDeletePressed != null
                                        ? ListTile(
                                            title: Text("Deletar postagem"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              onDeletePressed();
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
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Linkify(
                  onOpen: (link) => launch(link.url),
                  text: this.postContent,
                ),
                margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                padding: EdgeInsets.only(bottom: 4),
              ),
              seeMore != null ? seeMore : Container(),
              imageURL == null
                  ? Container()
                  : FlatButton(
                      onPressed: () {
                        this.onImageZoomPressed();
                      },
                      child: FadeInImage.assetNetwork(
                        image: imageURL,
                        placeholder: "assets/loading.gif",
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
            ],
          ),
        ),
      );
}

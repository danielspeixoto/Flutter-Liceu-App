import 'package:app/presentation/widgets/LiceuWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class PostWidget extends StatelessWidget {

  final String userPic;
  final String userName;
  final String postContent;

  PostWidget(this.userName, this.userPic, this.postContent);

  @override
  Widget build(BuildContext context) =>
      Card(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            this.userPic)),
                  ),
                  margin: const EdgeInsets.all(16.0),
                ),
                Text(
                  this.userName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Linkify(
                onOpen: (link) => launch(link.url),
                text:
                this.postContent,
              ),
              margin: const EdgeInsets.fromLTRB(
                  8.0,
                  0.0,
                  8.0,
                  8.0
              ),
            )

          ],
        ),
      );
}

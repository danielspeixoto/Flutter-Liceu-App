import 'package:app/presentation/widgets/LiceuWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RoundedImage.dart';

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
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        elevation: 2,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                RoundedImage(pictureURL: this.userPic, size: 36,),
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
                text: this.postContent,
              ),
              margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              padding: EdgeInsets.only(bottom: 4),
            )
          ],
        ),
      );
}

import 'package:app/domain/aggregates/ENEMVideo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ENEMVideoWidget extends StatelessWidget {
  final List<ENEMVideo> videos;

  ENEMVideoWidget(this.videos,);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...videos.map((video) {
          return FlatButton(
            onPressed: () {
              launch("https://www.youtube.com/watch?v=${video.videoId}");
            },
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: Image.network(
                      video.thumbnail,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(
                        8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              video.title,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              video.channelTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

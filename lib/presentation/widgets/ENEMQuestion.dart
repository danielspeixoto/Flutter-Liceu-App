import 'package:app/domain/aggregates/ENEMVideo.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ENEMQuestionAnswer.dart';

class ENEMQuestionWidget extends StatelessWidget {
  final Function(int index) onPressed;
  final List<AnswerStatus> status;
  final String imageURL;
  final int width;
  final int height;
  final List<ENEMVideo> videos;

  ENEMQuestionWidget(
      this.onPressed, this.imageURL, this.width, this.height, this.videos,
      [this.status = const [
        AnswerStatus.DEFAULT,
        AnswerStatus.DEFAULT,
        AnswerStatus.DEFAULT,
        AnswerStatus.DEFAULT,
        AnswerStatus.DEFAULT,
      ]]);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            PinchZoomImage(
              image: FadeInImage.assetNetwork(
                image: imageURL,
                width: double.infinity,
                height: (MediaQuery.of(context).size.width - 8) * (height / width),
                placeholder: "assets/loading.gif",
                repeat: ImageRepeat.repeat,
              ),
            ),
            Row(
              children: <Widget>[
                ...List.generate(status.length, (i) {
                  return ENEMQuestionAnswer(
                    String.fromCharCode('A'.codeUnitAt(0) + i),
                    () {
                      this.onPressed(i);
                    },
                    status[i],
                  );
                }),
              ],
            ),
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
                        width: 100,
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
        ),
      ),
    );
  }
}

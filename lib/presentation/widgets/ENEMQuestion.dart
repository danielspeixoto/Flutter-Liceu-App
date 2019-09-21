import 'package:flutter/material.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';

import 'ENEMQuestionAnswer.dart';

class ENEMQuestionWidget extends StatelessWidget {
  final Function(int index) onPressed;
  final List<AnswerStatus> status;
  final String imageURL;
  final int width;
  final int height;

  ENEMQuestionWidget(this.onPressed, this.imageURL, this.width, this.height,
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
                height: MediaQuery
                    .of(context)
                    .size
                    .width * (height / width),
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
            FlatButton(
              onPressed: () {},
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: Image.network(
                          "https://i.ytimg.com/vi/5NqitWbBim8/maxresdefault.jpg"),
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
                                "Raised buttons have a minimum size of 88.0 by 36.0 which can be overidden with ButtonTheme.",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "Me Salva",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

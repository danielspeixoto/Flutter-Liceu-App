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
    return Column(
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
      ],
    );
  }
}

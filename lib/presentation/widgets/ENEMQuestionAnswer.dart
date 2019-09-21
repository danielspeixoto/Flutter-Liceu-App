import 'package:flutter/material.dart';

enum AnswerStatus { SELECTED, WRONG, CORRECT, DEFAULT }

class ENEMQuestionAnswer extends StatelessWidget {
  final String title;
  final Function onPressed;
  final AnswerStatus status;

  ENEMQuestionAnswer(this.title, this.onPressed,
      [this.status = AnswerStatus.DEFAULT]);

  @override
  Widget build(BuildContext context) => Expanded(
        child: ButtonTheme(
          minWidth: 50,
          child: FlatButton(
            color: status == AnswerStatus.SELECTED
                ? Color(0xFF0061A1)
                : status == AnswerStatus.CORRECT
                    ? Colors.green
                    : status == AnswerStatus.WRONG
                        ? Colors.red
                        : Colors.white,
            padding: EdgeInsets.all(0),
            onPressed: onPressed,
            child: Text(
              title,
              style: TextStyle(
                color: status == AnswerStatus.DEFAULT
                    ? Color(0xFF0061A1)
                    : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}

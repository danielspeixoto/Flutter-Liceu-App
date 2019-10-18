import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:flutter/material.dart';

class LiceuDialog extends StatelessWidget {
  final String dialogTitle;
  final String sendButtonTitle;
  final TextFieldHighlight textField;
  final String message;
  final Function() onDialogButtonPressed;
  final BuildContext dialogContext;
  final double width;
  final double height;

  LiceuDialog(
      {this.dialogTitle,
      this.sendButtonTitle,
      this.textField,
      this.message,
      this.onDialogButtonPressed,
      this.dialogContext,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: this.dialogTitle != null ? Text(this.dialogTitle) : Text(""),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Container(
            width: this.width,
            height: this.height,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                this.textField != null ? this.textField : Container(),
                this.message != null ? Text(this.message) : Container()
              ],
            )),
        actions: <Widget>[
          FlatButton(
            child: Text(this.sendButtonTitle),
            onPressed: () {
              Navigator.of(this.dialogContext).pop();

              if(this.onDialogButtonPressed != null)
                this.onDialogButtonPressed();
            },
          )
        ],
      );
}

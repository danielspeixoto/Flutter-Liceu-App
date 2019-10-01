import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldHighlight extends StatelessWidget {
  final int minLines;
  final int maxLines;
  final TextInputType keyboardType;
  final Color borderHighlightColor;
  final Color hintTextColor;
  final TextEditingController controller;
  final InputDecoration decoration;
  final Function(String) onChanged;

  TextFieldHighlight(
      {this.minLines,
      this.maxLines,
      this.keyboardType,
      this.borderHighlightColor,
      this.hintTextColor,
      this.controller,
      this.decoration,
      this.onChanged});

  @override
  Widget build(BuildContext context) => Theme(
      data: new ThemeData(
          primaryColor: this.borderHighlightColor,
          hintColor: this.hintTextColor),
      child: TextField(
        controller: this.controller,
          onChanged: this.onChanged,
          minLines: this.minLines,
          maxLines: this.maxLines,
          decoration: this.decoration,
          keyboardType: this.keyboardType));
}

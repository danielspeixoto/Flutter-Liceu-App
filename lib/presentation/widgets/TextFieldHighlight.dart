import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

class TextFieldHighlight extends StatelessWidget {
  final int minLines;
  final int maxLines;
  final TextInputType keyboardType;
  final Color borderHighlightColor;
  final Color hintTextColor;
  final TextEditingController controller;
  final InputDecoration decoration;
  final Function(String) onChanged;
  final bool isMasked;

  TextFieldHighlight(
      {this.minLines,
      this.maxLines,
      this.keyboardType,
      this.borderHighlightColor,
      this.hintTextColor,
      this.controller,
      this.decoration,
      this.onChanged,
      this.isMasked});

  @override
  Widget build(BuildContext context) => Theme(
      data: new ThemeData(
          primaryColor: this.borderHighlightColor,
          hintColor: this.hintTextColor),
      child: this.isMasked ? MaskedTextField
(
    maskedTextFieldController: controller,
    onChange: this.onChanged,
    mask: "(xx)xxxxx-xxxxx",
    maxLength: 14,
    keyboardType: TextInputType.number,
    inputDecoration: this.decoration
) : TextField(
        controller: this.controller,
          onChanged: this.onChanged,
          minLines: this.minLines,
          maxLines: this.maxLines,
          decoration: this.decoration,
          keyboardType: this.keyboardType));
}

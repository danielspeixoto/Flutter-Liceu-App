import 'package:autocomplete_textfield/autocomplete_textfield.dart';
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
  final TextCapitalization capitalization;
  final bool isAutoCompleteTextField;
  final List<String> suggestions;

  TextFieldHighlight(
      {this.minLines,
      this.maxLines,
      this.keyboardType,
      this.borderHighlightColor,
      this.hintTextColor,
      this.controller,
      this.decoration,
      this.onChanged,
      this.isMasked,
      this.capitalization,
      this.isAutoCompleteTextField,
      this.suggestions});

  @override
  Widget build(BuildContext context) => Theme(
      data: new ThemeData(
          primaryColor: this.borderHighlightColor,
          hintColor: this.hintTextColor),
      child: this.isMasked == true ? MaskedTextField
(
    maskedTextFieldController: controller,
    onChange: this.onChanged,
    mask: "(xx)xxxxx-xxxxx",
    maxLength: 14,
    keyboardType: TextInputType.number,
    inputDecoration: this.decoration
) : this.isAutoCompleteTextField != null ? SimpleAutoCompleteTextField(
      key: key,
      decoration: this.decoration,
      controller: this.controller,
      suggestions: suggestions,
      textChanged: (text) => this.onChanged,
      clearOnSubmit: true,
      )
     : TextField(
        controller: this.controller,
          onChanged: this.onChanged,
          minLines: this.minLines,
          textCapitalization: this.capitalization != null ? this.capitalization : TextCapitalization.none,
          maxLines: this.maxLines,
          decoration: this.decoration,
          keyboardType: this.keyboardType));
}

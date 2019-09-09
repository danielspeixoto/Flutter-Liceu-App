import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWithLinks extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextStyle linkStyle;

  TextWithLinks({this.text, this.style, this.linkStyle});

  @override
  Widget build(BuildContext context) => Linkify(
        onOpen: (link) => launch(link.url),
        text: this.text,
      );
}

import 'package:flutter/material.dart';

import 'LiceuAppBar.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class LiceuPage extends StatelessWidget {
  final Widget body;
  final List<Widget> actions;
  final String title;

  LiceuPage({this.actions, this.body, this.title});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: LiceuAppBar(actions: actions, title: title).build(context),
        body: this.body,
      );
}

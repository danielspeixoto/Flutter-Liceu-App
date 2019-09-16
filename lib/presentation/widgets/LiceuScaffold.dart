import 'package:flutter/material.dart';

import 'LiceuAppBar.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class LiceuScaffold extends StatelessWidget {
  final tabs = [TabData(Icons.account_circle)];

  final Widget body;
  final Widget leading;
  final Widget drawer;

  LiceuScaffold({this.leading, this.body, this.drawer});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: LiceuAppBar(
          leading: leading,
        ).build(context),
        body: this.body,
        endDrawer: drawer,
      );
}

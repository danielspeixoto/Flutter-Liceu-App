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
  final PreferredSizeWidget appBar;

  LiceuScaffold({this.leading, this.body, this.drawer, this.appBar});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: this.appBar == null
            ? LiceuAppBar(
                leading: leading,
              ).build(context)
            : appBar,
        body: this.body,
        endDrawer: drawer,
      );
}

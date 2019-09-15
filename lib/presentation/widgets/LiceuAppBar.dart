import 'package:flutter/material.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class LiceuAppBar {
  final tabs = [TabData(Icons.account_circle)];

  final Widget leading;
  final List<Widget> actions;
  final String title;
  final String fontFamily;

  LiceuAppBar(
      {this.leading,
      this.actions,
      this.title = "Liceu",
      this.fontFamily = "LobsterTwo"});

  AppBar build(BuildContext context) => AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: this.actions,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 1.0,
        leading: this.leading,
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: this.fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      );
}

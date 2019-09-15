import 'package:flutter/material.dart';

import 'LiceuAppBar.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class LiceuScaffold extends StatelessWidget {
  final tabs = [TabData(Icons.account_circle)];

  final int selectedIdx;
  final Widget body;
  final Widget leading;
  final Widget drawer;

  LiceuScaffold({this.selectedIdx, this.leading, this.body, this.drawer});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: LiceuAppBar(
          leading: leading,
        ).build(context),
        body: this.body,
        endDrawer: drawer,










//        bottomNavigationBar: new Container(
//          color: Colors.white,
//          height: 50,
//          alignment: Alignment.center,
//          child: BottomAppBar(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: tabs
//                  .asMap()
//                  .map((idx, tab) {
//                    return MapEntry(
//                      idx,
//                      Expanded(
//                        child: Container(
//                          child: new IconButton(
//                            icon: Icon(tab.icon),
//                            onPressed: () {},
//                          ),
//                          color: idx == this.selectedIdx
//                              ? Colors.black12
//                              : Colors.white,
//                        ),
//                      ),
//                    );
//                  })
//                  .values
//                  .toList(),
//            ),
//          ),
//        ),
      );
}

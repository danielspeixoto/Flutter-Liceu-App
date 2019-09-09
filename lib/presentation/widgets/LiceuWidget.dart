import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class Liceu extends StatelessWidget {
  final tabs = [
    TabData(Icons.account_circle)
  ];

  final int selectedIdx;
  final Widget body;
  final Widget leading;

  Liceu({this.selectedIdx, this.leading, this.body});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          elevation: 1.0,
          leading: this.leading,
          title: Text("Liceu"),
        ),
        body: this.body,
        bottomNavigationBar: new Container(
            color: Colors.white,
            height: 50,
            alignment: Alignment.center,
            child: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: tabs.asMap().map((idx, tab) {
                    return MapEntry(
                        idx,
                        Expanded(
                          child: Container(
                            child: new IconButton(
                              icon: Icon(tab.icon),
                              onPressed: () {},
                            ),
                            color: idx == this.selectedIdx
                                ? Colors.black12
                                : Colors.white,
                          ),
                        ));
                  }).values.toList(),
                ))),
      );
}
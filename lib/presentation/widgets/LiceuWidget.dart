import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class Liceu extends StatelessWidget {
  final tabs = [
    TabData(Icons.home),
    TabData(Icons.videogame_asset),
    TabData(Icons.account_circle)
  ];

  final int selectedIdx;
  final Widget body;

  Liceu(this.selectedIdx, this.body);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          leading: new Icon(Icons.create),
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
                                : Colors
                                .white,
                          ),
                        ));
                  }).values.toList(),
                ))),
      );
}
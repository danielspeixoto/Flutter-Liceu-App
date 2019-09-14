import 'package:app/presentation/reducers/Data.dart';
import 'package:flutter/material.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class FetcherWidget extends StatelessWidget {
  final bool isLoading;
  final String errorMessage;
  final Widget Function() child;

  FetcherWidget({this.isLoading, this.errorMessage, this.child});

  @override
  Widget build(BuildContext context) {
    return isLoading ?
        Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
          margin: EdgeInsets.all(16),
        )
        : errorMessage != "" ? Text(errorMessage) : this.child();
  }
}

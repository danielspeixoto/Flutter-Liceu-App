import 'package:flutter/material.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class FetcherWidget {
  static Widget build({isLoading, errorMessage = "", child}) {
    return isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            margin: EdgeInsets.all(16),
          )
        : errorMessage != ""
            ? Container(
                child: Center(
                  child: Text(errorMessage),
                ),
                margin: EdgeInsets.all(16),
              )
            : child();
  }
}

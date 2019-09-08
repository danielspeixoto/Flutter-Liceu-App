import 'package:flutter/material.dart';

import '../RouteObserver.dart';

class MainRoute<T> extends MaterialPageRoute<T> {
  MainRoute(Widget widget, {RouteSettings settings})
      : super(
      builder: (_) => RouteAwareWidget(child: widget),
      settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: child);
  }
}
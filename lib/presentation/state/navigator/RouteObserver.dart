import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../app_state.dart';
import 'NavigatorActions.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class RouteAwareWidget extends StatefulWidget {
  final Widget child;

  RouteAwareWidget({this.child});

  State<RouteAwareWidget> createState() => RouteAwareWidgetState(child: child);
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  final Widget child;

  RouteAwareWidgetState({this.child});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    store.dispatch(CancelChallengeAction());
    StoreProvider.of<AppState>(context).dispatch(NavigatePopStackAction());
    
  }

  @override
  Widget build(BuildContext context) => Container(child: child);
}

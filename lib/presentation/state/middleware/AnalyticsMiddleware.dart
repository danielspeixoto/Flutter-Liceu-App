import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

class AnalyticsMiddleware extends MiddlewareClass<AppState> {
  final analytics = FirebaseAnalytics();

  AnalyticsMiddleware();

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    analytics.logEvent(name: action.runtimeType.toString());
    if(action is PageInitAction) {
      analytics.setCurrentScreen(screenName: action.name);
    }
    next(action);
  }
}

import 'package:redux/redux.dart';
import '../../../State.dart';
import 'Reducer.dart';

class SplashPresenter extends MiddlewareClass<AppState> {
  SplashPresenter();

  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
  }
}

class SplashAction {
  SplashAction();
}


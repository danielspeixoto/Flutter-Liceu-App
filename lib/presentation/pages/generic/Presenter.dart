import 'package:redux/redux.dart';
import '../../../State.dart';
import 'Reducer.dart';

class GenericPresenter extends MiddlewareClass<AppState> {
  GenericPresenter();

  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
  }
}

class GenericAction {
  GenericAction();
}


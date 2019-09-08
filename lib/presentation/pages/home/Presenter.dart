import 'package:redux/redux.dart';
import '../../../State.dart';
import 'Reducer.dart';

class HomePresenter extends MiddlewareClass<AppState> {
  HomePresenter();

  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {

  }
}

class HomeAction {
  HomeAction();
}


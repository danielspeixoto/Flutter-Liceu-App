import 'package:redux/redux.dart';
import '../../../State.dart';
import 'Reducer.dart';

class CreatePostPresenter extends MiddlewareClass<AppState> {
  CreatePostPresenter();

  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
  }
}

class CreatePostAction {
  CreatePostAction();
}


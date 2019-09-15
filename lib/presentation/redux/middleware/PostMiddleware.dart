import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/presentation/redux/actions/PostActions.dart';
import 'package:redux/redux.dart';

import '../../../redux.dart';

class PostMiddleware extends MiddlewareClass<AppState> {
  final IDeletePostUseCase _deletePostUseCase;

  PostMiddleware(
    this._deletePostUseCase,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is DeletePostAction) {
      this._deletePostUseCase.run(action.postId).catchError((e) {
        print(e);
      });
    }
    next(action);
  }
}

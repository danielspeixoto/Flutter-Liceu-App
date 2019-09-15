import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/presentation/redux/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../../redux.dart';
import 'Actions.dart';

class CreatePostPageMiddleware extends MiddlewareClass<AppState> {
  final ICreatePostUseCase createPostUseCase;

  CreatePostPageMiddleware(
    this.createPostUseCase,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is CreatePostAction) {
      try {
        await createPostUseCase.run(action.postType, action.text);
        store.dispatch(PostCreatedAction());
      } catch (e) {
        print(e);
      }
    } else if (action is PostCreatedAction) {
      store.dispatch(NavigatePopAction());
    }
    next(action);
  }
}

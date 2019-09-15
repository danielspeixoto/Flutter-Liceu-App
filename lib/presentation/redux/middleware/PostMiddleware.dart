import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/presentation/redux/actions/PostActions.dart';
import 'package:app/presentation/redux/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';
import '../../app.dart';
import '../app_state.dart';

class PostMiddleware extends MiddlewareClass<AppState> {
  final IDeletePostUseCase _deletePostUseCase;
  final ICreatePostUseCase _createPostUseCase;

  PostMiddleware(
    this._deletePostUseCase,
    this._createPostUseCase,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is DeletePostAction) {
      this._deletePostUseCase.run(action.postId).catchError((e) {
        print(e);
      });
    } else if (action is CreatePostAction) {
      try {
        await _createPostUseCase.run(action.postType, action.text);
        store.dispatch(PostCreatedAction());
      } catch (e) {
        print(e);
      }
    } else if (action is PostCreatedAction) {
      if (store.state.route.last == AppRoutes.createPost) {
        store.dispatch(NavigatePopAction());
      }
    } else if (action is DeletePostAction) {
      try {
        await this._deletePostUseCase.run(action.postId);
      } catch (e) {
        print(e);
      }
    }
    next(action);
  }
}

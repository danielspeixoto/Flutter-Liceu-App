import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';

class CreatePostViewModel {
  final Function(String) onPostSubmitted;

  CreatePostViewModel({this.onPostSubmitted});

  factory CreatePostViewModel.create(
      Store<AppState> store, ICreatePostUseCase createPostUseCase) {
    return CreatePostViewModel(onPostSubmitted: (text) async {
      try {
        print(text);
        await createPostUseCase.run(PostType.TEXT, text);
        store.dispatch(FetchMyPostsAction());
        store.dispatch(NavigatePopAction());
      } catch (e) {
        print(e);
      }
    });
  }
}

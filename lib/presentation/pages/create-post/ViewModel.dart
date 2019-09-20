import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class CreatePostViewModel {
  final Function(String) onPostSubmitted;
  final bool isLoading;

  CreatePostViewModel({this.onPostSubmitted, this.isLoading});

  factory CreatePostViewModel.create(Store<AppState> store) {
    final isLoading = store.state.createPostState.isLoading;
    return CreatePostViewModel(
      onPostSubmitted: isLoading ? null : (text) async {
        store.dispatch(
          CreatePostAction(
            PostType.TEXT,
            text,
          ),
        );
      },
      isLoading: isLoading,
    );
  }
}

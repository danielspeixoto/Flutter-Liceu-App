import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class CreatePostViewModel {
  final Function(String) onPostSubmitted;
  final bool isLoading;
  final String createPostTextErrorMessage;

  CreatePostViewModel({this.onPostSubmitted, this.isLoading, this.createPostTextErrorMessage});

  factory CreatePostViewModel.create(Store<AppState> store) {
    final isLoading = store.state.postState.isCreatingPost;
    final createPostTextErrorMessage = store.state.postState.createPostTextErrorMessage;
    
    return CreatePostViewModel(
      onPostSubmitted: isLoading ? null : (text) async {
        store.dispatch(
          SubmitPostAction(
            PostType.TEXT,
            text,
          ),
        );
      },
      isLoading: isLoading,
      createPostTextErrorMessage: createPostTextErrorMessage
    );
  }
}

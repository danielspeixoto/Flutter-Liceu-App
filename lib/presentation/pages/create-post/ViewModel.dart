import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class CreatePostViewModel {
  final Function(String) onPostSubmitted;

  CreatePostViewModel({this.onPostSubmitted});

  factory CreatePostViewModel.create(Store<AppState> store) {
    return CreatePostViewModel(
      onPostSubmitted: (text) async {
        store.dispatch(
          CreatePostAction(
            PostType.TEXT,
            text,
          ),
        );
      },
    );
  }
}

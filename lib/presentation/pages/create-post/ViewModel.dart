import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/redux/actions/PostActions.dart';
import 'package:app/presentation/redux/app_state.dart';
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

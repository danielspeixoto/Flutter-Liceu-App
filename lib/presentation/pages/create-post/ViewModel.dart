import 'package:app/domain/aggregates/Post.dart';
import 'package:redux/redux.dart';

import '../../../redux.dart';
import 'Actions.dart';

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

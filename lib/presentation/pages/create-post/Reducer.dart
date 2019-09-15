import 'package:redux/redux.dart';

class CreatePostPageState {
  CreatePostPageState();

  factory CreatePostPageState.initial() => CreatePostPageState();
}

final Reducer<CreatePostPageState> createPostPageReducer =
    combineReducers<CreatePostPageState>([]);
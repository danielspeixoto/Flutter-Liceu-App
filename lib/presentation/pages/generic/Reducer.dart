import 'package:redux/redux.dart';

class CreatePostPageState {
  CreatePostPageState();

  factory CreatePostPageState.initial() => CreatePostPageState();
}

final Reducer<CreatePostPageState> CreatePostPageReducer = combineReducers<CreatePostPageState>([
]);

class CreatePostPageIsLoading {
  CreatePostPageIsLoading();
}

CreatePostPageState pageIsLoading(CreatePostPageState state, CreatePostPageIsLoading action) {
  return CreatePostPageState();
}
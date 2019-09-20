import 'dart:math';

import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:redux/redux.dart';

class CreatePostState {
  final bool isLoading;

  CreatePostState({
    this.isLoading = true,
  });

  factory CreatePostState.initial() => CreatePostState();

  CreatePostState copyWith({bool isLoading}) {
    final state = CreatePostState(
      isLoading: isLoading ?? this.isLoading,
    );
    return state;
  }
}

final Reducer<CreatePostState> createPostReducer =
combineReducers<CreatePostState>([
  TypedReducer<CreatePostState, CreatePostAction>(createPost),
  TypedReducer<CreatePostState, PostCreationAction>(postCreation),
]);

CreatePostState createPost(CreatePostState state, CreatePostAction action) {
  return state.copyWith(
      isLoading: true
  );
}

CreatePostState postCreation(CreatePostState state, PostCreationAction action) {
  return state.copyWith(
    isLoading: false,
  );
}

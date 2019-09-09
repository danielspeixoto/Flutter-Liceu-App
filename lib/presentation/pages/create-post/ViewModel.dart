import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';
import '../../../main.dart';

class CreatePostViewModel {

  final Function(String) onPostSubmitted;

  CreatePostViewModel({this.onPostSubmitted});

  factory CreatePostViewModel.create(Store<AppState> store, ICreatePostUseCase createPostUseCase) {
    return CreatePostViewModel(
      onPostSubmitted: (text) async {
        try {
          print(text);
          await createPostUseCase.run("text", text);
          store.dispatch(NavigatePopAction());
        } catch(e) {
          print(e);
        }
      }
    );
  }
}


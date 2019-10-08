import 'dart:convert';
import 'dart:io';

import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class CreatePostViewModel {
  final Function(String, File) onPostSubmitted;
  final bool isLoading;
  final String createPostTextErrorMessage;

  CreatePostViewModel(
      {this.onPostSubmitted, this.isLoading, this.createPostTextErrorMessage});

  factory CreatePostViewModel.create(Store<AppState> store) {
    final isLoading = store.state.postState.isCreatingPost;
    final createPostTextErrorMessage =
        store.state.postState.createPostTextErrorMessage;

    return CreatePostViewModel(
        onPostSubmitted: (text, file) async {
          if (!isLoading) {
            if (file == null) {
              store.dispatch(
                SubmitTextPostAction(
                  text,
                ),
              );
            } else {
              final imageData = "data:image/png;base64," +
                  base64Encode(file.readAsBytesSync());
              store.dispatch(
                SubmitImagePostAction(
                  text,
                  imageData,
                ),
              );
            }
          }
        },
        isLoading: isLoading,
        createPostTextErrorMessage: createPostTextErrorMessage);
  }
}

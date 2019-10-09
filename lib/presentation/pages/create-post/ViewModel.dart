import 'dart:convert';
import 'dart:io';

import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class CreatePostViewModel {
  final Function(String, File) onPostSubmitted;
  final Function(File) onImageSet;
  final File image;
  final bool isLoading;
  final String createPostTextErrorMessage;

  CreatePostViewModel({
    this.image,
    this.onPostSubmitted,
    this.isLoading,
    this.createPostTextErrorMessage,
    this.onImageSet,
  });

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
            final imageData =
                "data:image/png;base64," + base64Encode(file.readAsBytesSync());
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
      createPostTextErrorMessage: createPostTextErrorMessage,
      onImageSet: (file) => store.dispatch(SetImageForSubmission(file)),
      image: store.state.postState.imageSubmission,
    );
  }
}

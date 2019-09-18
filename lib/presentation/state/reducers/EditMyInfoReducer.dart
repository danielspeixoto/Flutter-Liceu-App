import 'dart:math';

import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:redux/redux.dart';

class EditMyInfoState {
  final String bio;
  final String instagram;
  final bool isLoading;

  EditMyInfoState({
    this.bio = "",
    this.instagram = "",
    this.isLoading = true,
  });

  factory EditMyInfoState.initial() => EditMyInfoState();

  EditMyInfoState copyWith(
      {String bio, String instagram, bool isLoading}) {
    final state = EditMyInfoState(
      bio: bio ?? this.bio,
      instagram: instagram ?? this.instagram,
      isLoading: isLoading ?? this.isLoading,
    );
    return state;
  }
}

final Reducer<EditMyInfoState> editMyInfoReducer =
    combineReducers<EditMyInfoState>([
  TypedReducer<EditMyInfoState, SetUserEditFieldAction>(
      setUserEditFieldAction),
  TypedReducer<EditMyInfoState, SetUserAction>(
      updateEditFieldsOnUserUpdate),
  TypedReducer<EditMyInfoState, SubmitUserProfileChangesAction>(
      setLoadingEditPage),
]);

String _limitBioSize(String bio) {
  return bio == null ? null : bio.substring(0, min(300, bio.length));
}

String _limitInstagramSize(String instagram) {
  return instagram == null
      ? null
      : instagram.substring(0, min(60, instagram.length));
}

EditMyInfoState setUserEditFieldAction(
    EditMyInfoState state, SetUserEditFieldAction action) {
  return state.copyWith(
    bio: _limitBioSize(action.bio),
    instagram: _limitInstagramSize(action.instagram),
  );
}

EditMyInfoState updateEditFieldsOnUserUpdate(
    EditMyInfoState state, SetUserAction action) {
  return state.copyWith(
    bio: _limitBioSize(action.user.bio),
    instagram: _limitInstagramSize(action.user.instagramProfile),
  );
}

EditMyInfoState setLoadingEditPage(
    EditMyInfoState state, SubmitUserProfileChangesAction action) {
  return state.copyWith(
    isLoading: true,
  );
}

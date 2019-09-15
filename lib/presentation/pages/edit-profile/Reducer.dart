import 'dart:math';

import 'package:app/presentation/redux/actions/UserActions.dart';
import 'package:redux/redux.dart';

import 'Actions.dart';

class EditProfilePageState {
  final String bio;
  final String instagram;
  final bool isLoading;

  EditProfilePageState({
    this.bio = "",
    this.instagram = "",
    this.isLoading = true,
  });

  factory EditProfilePageState.initial() => EditProfilePageState();

  EditProfilePageState copyWith(
      {String bio, String instagram, bool isLoading}) {
    final state = EditProfilePageState(
      bio: bio ?? this.bio,
      instagram: instagram ?? this.instagram,
      isLoading: isLoading ?? this.isLoading,
    );
    return state;
  }
}

final Reducer<EditProfilePageState> editProfilePageReducer =
    combineReducers<EditProfilePageState>([
  TypedReducer<EditProfilePageState, SetUserEditFieldAction>(
      setUserEditFieldAction),
  TypedReducer<EditProfilePageState, SetUserAction>(
      updateEditFieldsOnUserUpdate),
  TypedReducer<EditProfilePageState, SubmitUserProfileChangesAction>(
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

EditProfilePageState setUserEditFieldAction(
    EditProfilePageState state, SetUserEditFieldAction action) {
  return state.copyWith(
    bio: _limitBioSize(action.bio),
    instagram: _limitInstagramSize(action.instagram),
  );
}

EditProfilePageState updateEditFieldsOnUserUpdate(
    EditProfilePageState state, SetUserAction action) {
  return state.copyWith(
    bio: _limitBioSize(action.user.bio),
    instagram: _limitInstagramSize(action.user.instagramProfile),
  );
}

EditProfilePageState setLoadingEditPage(
    EditProfilePageState state, SubmitUserProfileChangesAction action) {
  return state.copyWith(
    isLoading: true,
  );
}

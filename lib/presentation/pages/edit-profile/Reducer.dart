import 'dart:math';

import 'package:app/presentation/reducers/Data.dart';
import 'package:redux/redux.dart';

class EditData {
  final String bio;

  EditData({this.bio=""});

  EditData copyWith({
    String bio,
  }) {
    final state = EditData(
      bio: bio ?? this.bio,
    );
    return state;
  }
}

class EditProfilePageState {
  final Data<EditData> data;

  EditProfilePageState({this.data});

  factory EditProfilePageState.initial() => EditProfilePageState(
        data: Data(
          content: EditData(),
        ),
      );

  EditProfilePageState copyWith({
    Data<EditData> data,
  }) {
    final state = EditProfilePageState(
      data: data ?? this.data,
    );
    return state;
  }
}

final Reducer<EditProfilePageState> editProfilePageReducer =
    combineReducers<EditProfilePageState>([
  TypedReducer<EditProfilePageState, SetUserEditFieldAction>(
      setUserEditFieldAction),
  TypedReducer<EditProfilePageState, SetLoadingEditPageAction>(
      setLoadingEditPage),
]);

class SetUserEditFieldAction {
  final String bio;

  SetUserEditFieldAction({this.bio});
}

EditProfilePageState setUserEditFieldAction(
    EditProfilePageState state, SetUserEditFieldAction action) {

  final bio = action.bio.substring(0, min(300, action.bio.length));

  return EditProfilePageState(
    data: state.data.copyWith(
      content: state.data.content.copyWith(
        bio: bio,
      ),
    ),
  );
}

class SetLoadingEditPageAction {
  final bool isLoading;

  SetLoadingEditPageAction(this.isLoading);
}

EditProfilePageState setLoadingEditPage(
    EditProfilePageState state, SetLoadingEditPageAction action) {
  return EditProfilePageState(
      data: state.data.copyWith(isLoading: action.isLoading));
}

import 'dart:math';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:redux/redux.dart';

class EditMyInfoState {
  final String bio;
  final String instagram;
  final String phone;
  final String desiredCourse;
  final bool isLoading;
  final String message;

  EditMyInfoState({
    this.bio = "",
    this.instagram = "",
    this.phone = "",
    this.desiredCourse = "",
    this.isLoading = false,
    this.message = ""
  });

  factory EditMyInfoState.initial() => EditMyInfoState();

  EditMyInfoState copyWith(
      {String bio,
      String instagram,
      String phone,
      String desiredCourse,
      bool isLoading,
      String message}) {
    final state = EditMyInfoState(
      bio: bio ?? this.bio,
      instagram: instagram ?? this.instagram,
      phone: phone ?? this.phone,
      desiredCourse: desiredCourse ?? this.desiredCourse,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message
    );
    return state;
  }
}

final Reducer<EditMyInfoState> editMyInfoReducer =
    combineReducers<EditMyInfoState>([
  TypedReducer<EditMyInfoState, SetUserEditFieldAction>(setUserEditFieldAction),
  TypedReducer<EditMyInfoState, SetUserAction>(updateEditFieldsOnUserUpdate),
  TypedReducer<EditMyInfoState, SubmitUserProfileChangesAction>(
      setLoadingEditPage),
      TypedReducer<EditMyInfoState, SubmitUserProfileChangesSuccessAction>(submitUserProfileSuccess),
  TypedReducer<EditMyInfoState, NavigateUserEditProfileAction>(navigateEditProfile),   
  TypedReducer<EditMyInfoState, SubmitUserProfileChangesErrorAction>(setErrorMessage),   
]);

String _limitBioSize(String bio) {
  return bio == null ? null : bio.substring(0, min(300, bio.length));
}

String _limitInstagramSize(String instagram) {
  return instagram == null
      ? null
      : instagram.substring(0, min(60, instagram.length));
}

String _limitDesiredCourseSize(String desiredCourse) {
  return desiredCourse == null
      ? null
      : desiredCourse.substring(0, min(100, desiredCourse.length));
}

String _limitPhoneSize(String phone) {
  return phone == null ? null : phone.substring(0, min(20, phone.length));
}

EditMyInfoState setUserEditFieldAction(
    EditMyInfoState state, SetUserEditFieldAction action) {
  return state.copyWith(
    bio: _limitBioSize(action.bio),
    instagram: _limitInstagramSize(action.instagram),
    phone: _limitPhoneSize(action.phone),
    desiredCourse: _limitDesiredCourseSize(action.desiredCourse),
  );
}

EditMyInfoState submitUserProfileSuccess(
    EditMyInfoState state, SubmitUserProfileChangesSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    message: "Perfil editado com sucesso"
  );
}

EditMyInfoState setErrorMessage(
    EditMyInfoState state, SubmitUserProfileChangesErrorAction action) {
  return state.copyWith(
    isLoading: false,
    message: "Algum erro ocorreu ao tentar editar o perfil."
  );
}

EditMyInfoState navigateEditProfile(EditMyInfoState state, NavigateUserEditProfileAction action) {
  return state.copyWith(
    message: ""
  );
}

EditMyInfoState updateEditFieldsOnUserUpdate(
    EditMyInfoState state, SetUserAction action) {
  return state.copyWith(
    bio: _limitBioSize(action.user.bio),
    instagram: _limitInstagramSize(action.user.instagramProfile),
    phone: _limitPhoneSize(action.user.telephoneNumber),
    desiredCourse: _limitDesiredCourseSize(action.user.desiredCourse),
  );
}

EditMyInfoState setLoadingEditPage(
    EditMyInfoState state, SubmitUserProfileChangesAction action) {
  return state.copyWith(
    isLoading: true,
    message: ""
  );
}

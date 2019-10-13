import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class EditProfileViewModel {
  final bool isLoading;
  final String bio;
  final String instagram;
  final String desiredCourse;
  final String phone;
  final Function(String text) onBioTextChanged;
  final Function(String text) onInstagramTextChanged;
  final Function(String text) onPhoneTextChanged;
  final Function(String text) onDesiredCourseTextChanged;
  final Function() save;

  EditProfileViewModel({
    this.isLoading,
    this.bio,
    this.instagram,
    this.desiredCourse,
    this.phone,
    this.save,
    this.onBioTextChanged,
    this.onInstagramTextChanged,
    this.onPhoneTextChanged,
    this.onDesiredCourseTextChanged
  });

  factory EditProfileViewModel.create(Store<AppState> store) {
    final state = store.state.editMyInfoState;

    return EditProfileViewModel(
        isLoading: store.state.editMyInfoState.isLoading ||
            store.state.userState.user.isLoading,
        bio: state.bio,
        instagram: state.instagram,
        desiredCourse: state.desiredCourse,
        phone: state.phone,
        save: () async {
          store.dispatch(
            SubmitUserProfileChangesAction(
              bio: state.bio,
              instagram: state.instagram,
              desiredCourse: state.desiredCourse,
              phone: state.phone
            ),
          );
        },
        onBioTextChanged: (text) {
          store.dispatch(SetUserEditFieldAction(bio: text));
        },
        onInstagramTextChanged: (text) {
          store.dispatch(SetUserEditFieldAction(instagram: text));
        },
        onPhoneTextChanged: (text) {
          store.dispatch(SetUserEditFieldAction(phone: text));
        },
        onDesiredCourseTextChanged: (text) {
          store.dispatch(SetUserEditFieldAction(desiredCourse: text));
        });
  }
}

import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class EditProfileViewModel {
  final bool isLoading;
  final String bio;
  final String instagram;
  final Function(String text) onBioTextChanged;
  final Function(String text) onInstagramTextChanged;
  final Function() save;

  EditProfileViewModel({
    this.isLoading,
    this.bio,
    this.instagram,
    this.save,
    this.onBioTextChanged,
    this.onInstagramTextChanged,
  });

  factory EditProfileViewModel.create(Store<AppState> store) {
    final state = store.state.editMyInfoState;

    return EditProfileViewModel(
        isLoading: store.state.editMyInfoState.isLoading ||
            store.state.userState.user.isLoading,
        bio: state.bio,
        instagram: state.instagram,
        save: () async {
          store.dispatch(
            SubmitUserProfileChangesAction(
              bio: state.bio,
              instagram: state.instagram,
            ),
          );
        },
        onBioTextChanged: (text) {
          store.dispatch(SetUserEditFieldAction(bio: text));
        },
        onInstagramTextChanged: (text) {
          store.dispatch(SetUserEditFieldAction(instagram: text));
        });
  }
}

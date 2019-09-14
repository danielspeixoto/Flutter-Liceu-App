import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:app/presentation/reducers/Data.dart';
import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:redux/redux.dart';
import '../../../redux.dart';
import 'Reducer.dart';

class EditProfileViewModel {
  final Data<EditData> editData;
  final Function(String text) onBioTextChanged;
  final Function() save;

  EditProfileViewModel({this.editData, this.save, this.onBioTextChanged});

  factory EditProfileViewModel.create(Store<AppState> store,
      ISetUserDescriptionUseCase setUserDescriptionUseCase) {

    final data = store.state.editProfilePageState.data;

    return EditProfileViewModel(
        editData: data,
        save: () async {
          try {
            await setUserDescriptionUseCase.run(data.content.bio);
            store.dispatch(FetchMyInfoAction());
            store.dispatch(NavigatePopAction());
          } catch (e) {
            print(e);
          }
        },
      onBioTextChanged: (text) {
        store.dispatch(SetUserEditFieldAction(bio: text));
      },
    );
  }
}

import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';
import '../../../main.dart';

class HomeViewModel {

  final String userName;
  final String userPic;
  final String userBio;
  final Function() onCreateButtonPressed;

  HomeViewModel(this.userName, this.userPic, this.userBio, this.onCreateButtonPressed);

  factory HomeViewModel.create(Store<AppState> store) {
    final userState = store.state.userState;
    return HomeViewModel(
      userState.name,
      userState.picURL,
      userState.bio,
        () => store.dispatch(NavigatePushAction(AppRoutes.createPost))
    );
  }
}


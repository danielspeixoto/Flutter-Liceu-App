import 'package:redux/redux.dart';
import '../../../State.dart';
import 'Presenter.dart';

class HomeViewModel {

  final String userName;
  final String userPic;
  final String userBio;

  HomeViewModel(this.userName, this.userPic, this.userBio);

  factory HomeViewModel.create(Store<AppState> store) {
    final userState = store.state.userState;
    return HomeViewModel(
      userState.name,
      userState.picURL,
      userState.bio,
    );
  }
}


import 'package:redux/redux.dart';
import '../../../State.dart';
import 'Presenter.dart';

class HomeViewModel {

  HomeViewModel();

  factory HomeViewModel.create(Store<AppState> store) {
    return HomeViewModel();
  }
}


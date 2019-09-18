import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  HomeViewModel();

  factory HomeViewModel.create(Store<AppState> store) {
    return HomeViewModel();
  }
}

import 'package:app/presentation/redux/app_state.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  HomeViewModel();

  factory HomeViewModel.create(Store<AppState> store) {
    return HomeViewModel();
  }
}

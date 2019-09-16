import 'package:app/presentation/redux/app_state.dart';
import 'package:redux/redux.dart';

class GameViewModel {
  GameViewModel();

  factory GameViewModel.create(Store<AppState> store) {
    return GameViewModel();
  }
}

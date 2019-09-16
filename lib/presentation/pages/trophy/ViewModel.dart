import 'package:app/presentation/redux/app_state.dart';
import 'package:redux/redux.dart';

class TrophyViewModel {
  TrophyViewModel();

  factory TrophyViewModel.create(Store<AppState> store) {
    return TrophyViewModel();
  }
}

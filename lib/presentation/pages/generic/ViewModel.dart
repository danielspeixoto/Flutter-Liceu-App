import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class GenericViewModel {
  GenericViewModel();

  factory GenericViewModel.create(Store<AppState> store) {
    return GenericViewModel();
  }
}

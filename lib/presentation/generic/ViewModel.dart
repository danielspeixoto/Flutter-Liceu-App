import 'package:redux/redux.dart';
import '../../State.dart';
import 'Presenter.dart';

class GenericViewModel {

  GenericViewModel();

  factory GenericViewModel.create(Store<AppState> store) {
    return GenericViewModel();
  }
}


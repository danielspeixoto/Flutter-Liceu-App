import 'package:redux/redux.dart';

import '../../../redux.dart';

class GenericViewModel {
  GenericViewModel();

  factory GenericViewModel.create(Store<AppState> store) {
    return GenericViewModel();
  }
}

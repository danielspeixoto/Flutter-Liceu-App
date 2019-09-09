import 'package:redux/redux.dart';
import '../../../State.dart';
import 'Presenter.dart';

class CreatePostViewModel {

  CreatePostViewModel();

  factory CreatePostViewModel.create(Store<AppState> store) {
    return CreatePostViewModel();
  }
}


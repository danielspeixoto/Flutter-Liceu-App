import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class ImagePostViewModel {
  final String imageURL;

  ImagePostViewModel({
    this.imageURL
  });

    factory ImagePostViewModel.create(Store<AppState> store) {
    final postState = store.state.postState;

    return ImagePostViewModel(
      imageURL: postState.imageURL
    );
  }
}
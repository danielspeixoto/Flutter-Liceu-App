import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';

class CreatePostViewModel {

  final Function(String) onPostSubmitted;

  CreatePostViewModel({this.onPostSubmitted});

  factory CreatePostViewModel.create(Store<AppState> store, ICreatePostUseCase createPostUseCase) {
    return CreatePostViewModel(
      onPostSubmitted: (text) async {
        try {
          print(text);
          await createPostUseCase.run("text", text);
        } catch(e) {
          print(e);
        }
      }
    );
  }
}


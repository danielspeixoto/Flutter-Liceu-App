import 'package:app/presentation/pages/image-post/ViewModel.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/ImageZoom.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ImagePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ImagePostViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("ImagePost")),
        converter: (store) => ImagePostViewModel.create(store),
        builder: (BuildContext context, ImagePostViewModel viewModel) {
          return LiceuScaffold(body: ImageZoom(imageURL: viewModel.imageURL));
        },
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../State.dart';
import 'ViewModel.dart';


class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, CreatePostViewModel>(
          converter: (store) => CreatePostViewModel.create(store),
          builder: (BuildContext context, CreatePostViewModel viewModel) {
              return Text("createPost");
          });
}

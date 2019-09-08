import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../State.dart';
import 'ViewModel.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, HomeViewModel>(
          converter: (store) => HomeViewModel.create(store),
          builder: (BuildContext context, HomeViewModel viewModel) {
              return Text("Home");
          });
}

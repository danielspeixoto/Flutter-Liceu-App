import 'package:app/presentation/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'ViewModel.dart';

class GenericPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, GenericViewModel>(
          converter: (store) => GenericViewModel.create(store),
          builder: (BuildContext context, GenericViewModel viewModel) {
            return Text("generic");
          });
}

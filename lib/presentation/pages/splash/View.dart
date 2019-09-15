import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../redux.dart';
import 'Actions.dart';
import 'ViewModel.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, SplashViewModel>(
          onInit: (store) => store.dispatch(CheckIfIsLoggedInAction()),
          converter: (store) => SplashViewModel.create(store),
          builder: (BuildContext context, SplashViewModel viewModel) {
            return Scaffold(
              body: Container(
                child: Center(child: CircularProgressIndicator()),
                color: Theme.of(context).primaryColor,
              ),
            );
          });
}

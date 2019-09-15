import 'package:app/presentation/redux/actions/LoginActions.dart';
import 'package:app/presentation/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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

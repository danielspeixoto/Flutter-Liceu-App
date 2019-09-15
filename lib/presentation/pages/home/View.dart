import 'package:app/presentation/pages/profile/View.dart';
import 'package:app/presentation/redux/actions/UserActions.dart';
import 'package:app/presentation/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ViewModel.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class HomePage extends StatelessWidget {

  HomePage();

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, HomeViewModel>(
      onInit: (store) {
        store.dispatch(FetchMyInfoAction());
        store.dispatch(FetchMyPostsAction());
      },
      converter: (store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel viewModel) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(width: 0.15),
                ),
              ),
              child: TabBar(
                tabs: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      FontAwesomeIcons.gamepad,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      FontAwesomeIcons.home,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Icon(Icons.directions_car),
                ProfilePage(),
              ],
            ),
          ),
        );
      },
    );
  }
}

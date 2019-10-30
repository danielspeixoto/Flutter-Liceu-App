import 'package:app/presentation/pages/explore/View.dart';
import 'package:app/presentation/pages/game/View.dart';
import 'package:app/presentation/pages/profile/View.dart';
import 'package:app/presentation/pages/trophy/View.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ViewModel.dart';

class HomePage extends StatelessWidget {
  HomePage();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      onInit: (store) {
        store.dispatch(FetchPostsAction());
        store.dispatch(FetchUserInfoAction());
        store.dispatch(FetchUserPostsAction());
        store.dispatch(FetchUserChallengesAction());
        store.dispatch(FetchRankingAction());
      },
      converter: (store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel viewModel) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            key: Key("homePage"),
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
                      FontAwesomeIcons.trophy,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      FontAwesomeIcons.bookOpen,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      FontAwesomeIcons.userGraduate,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                GamePage(),
                TrophyPage(),
                ExplorePage(),
                ProfilePage(),
              ],
            ),
          ),
        );
      },
    );
  }
}

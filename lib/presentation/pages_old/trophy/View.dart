import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuDivider.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/RankingPosition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'ViewModel.dart';

class TrophyPage extends StatelessWidget {
  TrophyPage();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, TrophyViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("Trophy")),
        converter: (store) => TrophyViewModel.create(store),
        builder: (BuildContext context, TrophyViewModel viewModel) {
          return LiceuScaffold(
            body: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  child: Text(
                    "Ranking do Mês",
                    style: TextStyle(
                      fontFamily: "LobsterTwo",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FetcherWidget.build(
                  isLoading: viewModel.rankingData.isLoading,
                  errorMessage: viewModel.rankingData.errorMessage,
                  child: () {
                    return Card(
                      child: Column(
                          children: viewModel.rankingData.content.map((game) {
                        return Column(
                          children: <Widget>[
                            FlatButton(
                              child: RankingPosition(game),
                              onPressed: () =>
                                  viewModel.onUserPressed(game.user),
                            ),
                            LiceuDivider(),
                          ],
                        );
                      }).toList()),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
}

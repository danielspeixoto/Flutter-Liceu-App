import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuDivider.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/RankingPosition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ViewModel.dart';

class TrophyPage extends StatelessWidget {
  TrophyPage();

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, TrophyViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("trophy")),
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
                FetcherWidget(
                  isLoading: viewModel.rankingData.isLoading,
                  errorMessage: viewModel.rankingData.errorMessage,
                  child: () {
                    return Card(
                      child: Column(
                          children:
                              viewModel.rankingData.content.map((game) {
                        return Column(
                          children: <Widget>[
                            RankingPosition(game),
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

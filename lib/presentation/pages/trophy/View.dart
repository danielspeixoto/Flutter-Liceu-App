import 'package:app/presentation/redux/app_state.dart';
import 'package:app/presentation/widgets/ActionCard.dart';
import 'package:app/presentation/widgets/LiceuDivider.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/RankingPosition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ViewModel.dart';

class TrophyPage extends StatelessWidget {
  TrophyPage();

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, TrophyViewModel>(
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
                Card(
                  child: Column(
                    children: <Widget>[
                      RankingPosition(),
                      LiceuDivider(),
                      RankingPosition(),
                      LiceuDivider(),
                      RankingPosition(),
                      LiceuDivider(),
                      RankingPosition(),
                      LiceuDivider(),
                      RankingPosition(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}

import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/ActionCard.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuDivider.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/MatchHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ViewModel.dart';

class GamePage extends StatelessWidget {
  GamePage();

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, GameViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("Game")),
        converter: (store) => GameViewModel.create(store),
        builder: (BuildContext context, GameViewModel viewModel) {
          return LiceuScaffold(
              leading: viewModel.isCreateTriviaFeatureReady
                  ? FlatButton(
                      onPressed: viewModel.onCreateTriviaPressed,
                      child: new Icon(
                        FontAwesomeIcons.plus,
                      ),
                    )
                  : null,
              body: SmartRefresher(
                controller: _refreshController,
                onRefresh: () async {
                  viewModel.refresh();
                  _refreshController.refreshCompleted();
                },
                child: ListView(
                  children: <Widget>[
                    ActionCard(
                      FontAwesomeIcons.gamepad,
                      "Desafio Rápido",
                      () => viewModel.onChallengePressed(),
                    ),
                    ActionCard(
                      FontAwesomeIcons.trophy,
                      "Torneio",
                      () => viewModel.onTournamentPressed(),
                    ),
                    ActionCard(
                      FontAwesomeIcons.userGraduate,
                      "Treinamento",
                      () => viewModel.onTrainingPressed(),
                    ),
                    FlatButton(
                      onPressed: () {
                        viewModel.onChallengeFriendPressed();
                      },
                      child: Text(
                        "Desafie um amigo",
                        style: TextStyle(
                          color: Color(0xFF0061A1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              color: Colors.black,
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Histórico",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            FetcherWidget.build(
                                errorMessage: viewModel.challenges.errorMessage,
                                isLoading: viewModel.challenges.isLoading,
                                child: () {
                                  return Container(
                                    child: Column(
                                      children: viewModel
                                                  .challenges.content.length ==
                                              0
                                          ? [
                                              Container(
                                                child: Text(
                                                    "Você ainda não participou de nenhuma partida"),
                                                margin: EdgeInsets.all(16),
                                              )
                                            ]
                                          : viewModel.challenges.content
                                              .map((challenge) {
                                              return Column(
                                                children: <Widget>[
                                                  MatchHistory(
                                                    challenge,
                                                    (user) => viewModel
                                                        .onUserPressed(user),
                                                  ),
                                                  LiceuDivider()
                                                ],
                                              );
                                            }).toList(),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      );
}

import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/ChallengeReducer.dart';
import 'package:app/presentation/widgets/ChallegeAnswerCard.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'ViewModel.dart';

class ChallengePage extends StatelessWidget {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ChallengeViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("Challenge")),
          converter: (store) => ChallengeViewModel.create(store),
          builder: (BuildContext context, ChallengeViewModel viewModel) {
            return LiceuPage(
              title: "Liceu",
              body: FetcherWidget(
                isLoading: viewModel.isLoading,
                child: () {
                  return Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            top: 16, bottom: 0, left: 16, right: 16),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: RoundedImage(
                                    pictureURL: viewModel.challenger != null
                                        ? "assets/koala.png"
                                        : "assets/koala.png",
                                    size: 64,
                                  ),
                                ),
                                viewModel.challenger == null
                                    ? Text("Em espera")
                                    : Text(
                                        viewModel.challenger.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                              ],
                            ),
                            Spacer(),
                            Text(
                              "VS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Spacer(),
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: RoundedImage(
                                    pictureURL: viewModel.challenged == null
                                        ? "https://png.pngtree.com/svg/20170823/monkey_15.png"
                                        : viewModel.challenged.picURL,
                                    size: 64,
                                  ),
                                ),
                                viewModel.challenged == null
                                    ? Text("Em espera")
                                    : Text(
                                        viewModel.challenged.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 32),
                        child: Row(
                          children: [
                            Spacer(),
                            new CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 5.0,
                              percent:
                                  viewModel.timeLeft / TRIVIA_TIME_TO_ANSWER,
                              center: new Text(
                                viewModel.timeLeft.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              progressColor: viewModel.timeLeft > 10
                                  ? Colors.green
                                  : viewModel.timeLeft > 5
                                      ? Colors.yellow
                                      : Colors.red,
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                      Card(
                        child: Container(
                          margin: EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              Text(
                                viewModel.question,
                                style: TextStyle(fontSize: 16),
                              ),
                              Row(
                                children: <Widget>[
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: RoundedImage(
                                              pictureURL:
                                                  viewModel.author.picURL,
                                              size: 20),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8),
                                        ),
                                        Text(
                                          viewModel.author.name,
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ChallengeAnswerCard(
                          FontAwesomeIcons.arrowAltCircleRight,
                          viewModel.answer1,
                          () => viewModel.onAnswer(viewModel.answer1),
                          viewModel.showAnswer
                              ? viewModel.correctAnswer == 0
                                  ? Colors.green
                                  : Colors.red
                              : null),
                      ChallengeAnswerCard(
                          FontAwesomeIcons.arrowAltCircleRight,
                          viewModel.answer2,
                          () => viewModel.onAnswer(viewModel.answer2),
                          viewModel.showAnswer
                              ? viewModel.correctAnswer == 1
                                  ? Colors.green
                                  : Colors.red
                              : null),
                      Spacer(),
                    ],
                  );
                },
              ),
            );
          });
}

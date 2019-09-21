import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/ENEMQuestion.dart';
import 'package:app/presentation/widgets/ENEMQuestionAnswer.dart';
import 'package:app/presentation/widgets/ENEMVideoWidget.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ViewModel.dart';

class TournamentReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, TournamentReviewViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("TournamentReview")),
          converter: (store) => TournamentReviewViewModel.create(store),
          builder: (BuildContext context, TournamentReviewViewModel viewModel) {
            return LiceuScaffold(
              body: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(FontAwesomeIcons.chartBar),
                              ),
                              Container(
                                margin: EdgeInsets.all(8),
                                child: Text(
                                  "${viewModel.score} questões certas!",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(FontAwesomeIcons.userClock),
                              ),
                              Container(
                                margin: EdgeInsets.all(8),
                                child: Text(
                                  "Tarefa concluída em ${(viewModel.timeSpent / 60).floor()}:${(viewModel.timeSpent % 60) < 10 ? "0" : ""}${(viewModel.timeSpent % 60).floor()} minutos",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  FetcherWidget(
                    isLoading: viewModel.questions.isLoading,
                    errorMessage: viewModel.questions.errorMessage,
                    child: () => Container(
                      child: Column(
                        children: [
                          ...viewModel.questions.content.map(
                            (question) {
                              var status = [
                                AnswerStatus.DEFAULT,
                                AnswerStatus.DEFAULT,
                                AnswerStatus.DEFAULT,
                                AnswerStatus.DEFAULT,
                                AnswerStatus.DEFAULT,
                              ];
                              if (question.selectedAnswer != -1) {
                                status[question.selectedAnswer] =
                                    AnswerStatus.WRONG;
                                status[question.answer] = AnswerStatus.CORRECT;
                              }
                              return Card(
                                child: Column(
                                  children: <Widget>[
                                    ENEMQuestionWidget(
                                      (int idx) {},
                                      question.imageURL,
                                      question.width,
                                      question.height,
                                      status,
                                    ),
                                    ENEMVideoWidget(question.videos),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
}

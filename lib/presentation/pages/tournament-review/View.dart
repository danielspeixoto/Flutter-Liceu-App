import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/ENEMQuestion.dart';
import 'package:app/presentation/widgets/ENEMQuestionAnswer.dart';
import 'package:app/presentation/widgets/ENEMVideoWidget.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
                    margin: EdgeInsets.all(8),
                    child: Text(
                      "Confira o resultado da sua partida",
                      textAlign: TextAlign.center,
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

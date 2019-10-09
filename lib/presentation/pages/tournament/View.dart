import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/ENEMQuestion.dart';
import 'package:app/presentation/widgets/ENEMQuestionAnswer.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ViewModel.dart';

class TournamentPage extends StatelessWidget {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) => StoreConnector<AppState,
          TournamentViewModel>(
      onInit: (store) => store.dispatch(PageInitAction("Tournament")),
      converter: (store) => TournamentViewModel.create(store),
      builder: (BuildContext context, TournamentViewModel viewModel) {
        return LiceuScaffold(
          body: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  "Responda o máximo de perguntas em menos tempo para entrar no ranking.",
                  textAlign: TextAlign.center,
                ),
              ),
              FetcherWidget(
                isLoading: viewModel.questions.isLoading,
                errorMessage: viewModel.questions.errorMessage,
                child: () => Container(
                  child: Column(
                    children: <Widget>[
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
                                AnswerStatus.SELECTED;
                          }
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Card(
                                  child: ENEMQuestionWidget(
                                    (int idx) {
                                      viewModel.onAnswer(question.id, idx);
                                    },
                                    question.imageURL,
                                    question.width,
                                    question.height,
                                    status,
                                  ),
                                ),
                              ]);
                        },
                      ).toList(),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: FlatButton(
                          onPressed: () {
                            viewModel.submit();
                          },
                          child: Text(
                            "Enviar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0061A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

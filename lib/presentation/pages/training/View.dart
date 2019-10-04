import 'package:app/injection.dart';
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
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ViewModel.dart';

class TrainingPage extends StatelessWidget {
  final inputController = TextEditingController();
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, TrainingViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("Training")),
          converter: (store) => TrainingViewModel.create(store),
          builder: (BuildContext context, TrainingViewModel viewModel) {
            return LiceuScaffold(
              body: SmartRefresher(
                onRefresh: () async {
                  viewModel.refresh();
                  _refreshController.refreshCompleted();
                },
                controller: _refreshController,
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        "Olha a questão que escolhemos para você!",
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
                                  status[question.answer] =
                                      AnswerStatus.CORRECT;
                                }
                                return Card(
                                  child: Column(
                                    children: <Widget>[
                                      ENEMQuestionWidget(
                                        (int idx) {
                                          viewModel.onAnswer(question.id, idx);
                                        },
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
                             Container(
                               alignment: Alignment.bottomRight,
                               margin: EdgeInsets.all(8),
                                child: GestureDetector(
                              onTap: () {
                                viewModel.onReportButtonPressed(
                                    viewModel.questions.content[0].id,
                                    viewModel.questions.content[0].answer,
                                    viewModel
                                        .questions.content[0].selectedAnswer);
                              },
                              child: Column(
                                children: [
                                Icon(
                                  FontAwesomeIcons.exclamationCircle,
                                  color: Colors.black,
                                  size: 12,
                                ),
                                Text(
                                  'Reportar erro',
                                  style: TextStyle(
                                      color: Color(0xFF0061A1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ]),
                            )),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: FlatButton(
                                onPressed: () {
                                  viewModel.refresh();
                                },
                                child: Text(
                                  "Trocar questão",
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
              ),
            );
          });
}

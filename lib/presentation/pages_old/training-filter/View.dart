import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:app/presentation/widgets/QuestionDomainWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ViewModel.dart';

class TrainingFilterPage extends StatelessWidget {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, TrainingFilterViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("TrainingFilter")),
          converter: (store) => TrainingFilterViewModel.create(store),
          builder: (BuildContext context, TrainingFilterViewModel viewModel) {
            return LiceuPage(
                title: "Liceu",
                body: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: QuestionDomainWidget(
                                FontAwesomeIcons.solidCommentAlt, "Linguagens", () {
                                  viewModel.onDomainSelected(QuestionDomain.LANGUAGES);
                                }),
                          ),
                          Expanded(
                            child: QuestionDomainWidget(
                                FontAwesomeIcons.calculator, "Matemática", () {
                              viewModel.onDomainSelected(QuestionDomain.MATHEMATICS);
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: QuestionDomainWidget(
                                FontAwesomeIcons.landmark, "Humanas", () {
                                  viewModel.onDomainSelected(QuestionDomain.HUMAN_SCIENCES);
                            }),
                          ),
                          Expanded(
                            child: QuestionDomainWidget(
                                FontAwesomeIcons.dna, "Naturais", () {
                                  viewModel.onDomainSelected(QuestionDomain.NATURAL_SCIENCES);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          });
}

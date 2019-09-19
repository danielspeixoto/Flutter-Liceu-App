import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/ActionCard.dart';
import 'package:app/presentation/widgets/ChallegeAnswerCard.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ViewModel.dart';

class ChallengePage extends StatelessWidget {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ChallengeViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("challenge")),
          converter: (store) => ChallengeViewModel.create(store),
          builder: (BuildContext context, ChallengeViewModel viewModel) {
            return LiceuPage(
              title: "Liceu",
              body: FetcherWidget(
                isLoading: viewModel.isLoading,
                child: () {
                  return Column(
                    children: <Widget>[
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
                      ),
                      ChallengeAnswerCard(
                          FontAwesomeIcons.arrowAltCircleRight,
                          viewModel.answer2,
                            () => viewModel.onAnswer(viewModel.answer2),
                      ),
                    ],
                  );
                },
              ),
            );
          });
}

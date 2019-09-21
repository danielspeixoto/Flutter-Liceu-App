import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/ENEMQuestion.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
                    FetcherWidget(
                      isLoading: viewModel.questions.isLoading,
                      errorMessage: viewModel.questions.errorMessage,
                      child: () => Container(
                        child: Column(
                            children: viewModel.questions.content
                                .map(
                                  (question) => ENEMQuestionWidget(
                                    (int idx) {},
                                    question.imageURL,
                                    question.width,
                                    question.height,
                                  ),
                                )
                                .toList()),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
}

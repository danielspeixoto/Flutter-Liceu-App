import 'dart:math';
import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class TrainingFilterViewModel {
  final Function(QuestionDomain) onDomainSelected;
  TrainingFilterViewModel({
    this.onDomainSelected,
  });

  factory TrainingFilterViewModel.create(Store<AppState> store) {
    return TrainingFilterViewModel(
      onDomainSelected: (domain) => store.dispatch(FilterTrainingQuestions(domain))
    );
  }
}

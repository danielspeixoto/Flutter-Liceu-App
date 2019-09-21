import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/aggregates/RankingData.dart';

import '../../constants.dart';

class FetchRankingAction {
  FetchRankingAction();
}

class FetchingRankingErrorAction {
  final String error;

  FetchingRankingErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class RankingRetrievedAction {
  final RankingData ranking;

  RankingRetrievedAction(this.ranking);
}

class TrainingAction {}

class FilterTrainingQuestions {
  final QuestionDomain domain;

  FilterTrainingQuestions(this.domain);
}

class TrainingQuestionsRetrievedAction {
  final List<ENEMQuestionData> questions;

  TrainingQuestionsRetrievedAction(this.questions);
}
